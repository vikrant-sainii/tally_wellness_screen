import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_screen/bloc/user_state.dart';
import 'package:tally_screen/bloc/user_event.dart';
import '../models/guide_model.dart';
import '../repository/home_repo.dart';
import '../repository/guide_repo.dart';
import 'package:logger/logger.dart';
import '../models/quote_model.dart';
import '../repository/quote_repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepo;
  final GuideRepository guideRepo;
  final QuoteRepository quoteRepo;
  final Logger logger = Logger();
  final Connectivity _connectivity = Connectivity();

  late final StreamSubscription<List<ConnectivityResult>>
  _connectivitySubscription;

  UserBloc({
    required this.userRepo,
    required this.guideRepo,
    required this.quoteRepo,
  }) : super(const UserState()) {
    on<LoadHome>(_onLoadHome);
    on<CompleteCheckIn>(_onCompleteCheckIn);
    on<AddPendingGuide>(_onAddPendingGuide);
    on<WentOffline>(_onWentOffline);
    on<WentOnline>(_onWentOnline);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      if (results.contains(ConnectivityResult.none)) {
        add(WentOffline());
      } else {
        add(WentOnline());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }

  //dynamic greeting function
  String _greeting(String name) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  //function to check if thisweek checkin pending
  bool _hasCheckedInThisWeek(DateTime? lastCheckInAt) {
    if (lastCheckInAt == null) {
      return false;
    }
    final now = DateTime.now();

    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
    return lastCheckInAt.isAfter(startOfWeek);
  }

  Future<void> _onLoadHome(LoadHome event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = await userRepo.getUser(event.userId);
      final pending = await guideRepo.getPendingGuides(user.pendingGuides!);
      final weekly = await guideRepo.getThisWeekGuides();
      final mood = user.lastMood == null
          ? <GuideModel>[]
          : await guideRepo.getMoodGuides(user.lastMood!);
      final quoteMessage = await quoteRepo.getQuoteForMood(user.lastMood!);
      final checkedIn = _hasCheckedInThisWeek(user.lastCheckInAt);
      emit(
        state.copyWith(
          isLoading: false,
          user: user,
          pendingGuides: pending,
          thisWeekGuides: weekly,
          moodGuides: mood,
          quoteMessage: quoteMessage,
          greeting: _greeting(user.name),
          hasCheckedIn: checkedIn,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onCompleteCheckIn(
    CompleteCheckIn event,
    Emitter<UserState> emit,
  ) async {
    final user = state.user;

    if (user == null) {
      return;
    }
    try {
      await userRepo.completeCheckIn(userId: user.id, mood: event.mood);
      final updatedUser = user.copyWith(
        onboardingDone: true,
        lastMood: event.mood,
        lastCheckInAt: DateTime.now(),
      );
      final mood = await guideRepo.getMoodGuides(event.mood);
      String str = 'Done for this week.';
      String detail ='Thank you for checking in with yourself. We will be here next week.';
      if (state.hasCheckedIn == true) {
        str = "Mood Changed! Check 'Your Guide' Section Now";
        detail ='PowerFul person is the one know himself better than anyone';
      }
      emit(
        state.copyWith(
          user: updatedUser,
          moodGuides: mood,
          quoteMessage: QuoteModel(
            title: str,
            description: detail,    
          ),
          hasCheckedIn: true
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onAddPendingGuide(
    AddPendingGuide event,
    Emitter<UserState> emit,
  ) async {
    final user = state.user;

    if (user == null) return;

    // Prevent duplicates
    if (state.pendingGuides.any((g) => g.id == event.guide.id)) {
      return;
    }

    try {
      await userRepo.addPendingGuide(userId: user.id, guideId: event.guide.id);
      emit(
        state.copyWith(pendingGuides: [...state.pendingGuides, event.guide]),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onWentOffline(WentOffline event, Emitter<UserState> emit) {
    emit(state.copyWith(isOffline: true));
  }

  void _onWentOnline(WentOnline event, Emitter<UserState> emit) {
    emit(state.copyWith(isOffline: false));
  }
}

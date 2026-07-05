import 'package:tally_screen/models/quote_model.dart';

import '../models/guide_model.dart';
import '../models/user_model.dart';

class UserState {
  final UserModel? user;
  final List<GuideModel> thisWeekGuides;
  final List<GuideModel> pendingGuides;
  final List<GuideModel> moodGuides;
  final QuoteModel? quoteMessage;
  final bool isLoading;
  final bool hasCheckedIn;
  final String greeting;
  final String? error;

  const UserState({
    this.user,
    this.thisWeekGuides = const [],
    this.pendingGuides = const [],
    this.moodGuides = const [],
    this.quoteMessage,
    this.isLoading = false,
    this.hasCheckedIn = false,
    this.greeting = '',
    this.error,
  });

  UserState copyWith({
    UserModel? user,
    List<GuideModel>? thisWeekGuides,
    List<GuideModel>? pendingGuides,
    List<GuideModel>? moodGuides,
    QuoteModel? quoteMessage,
    bool? isLoading,
    bool? hasCheckedIn,
    String? greeting,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      thisWeekGuides: thisWeekGuides ?? this.thisWeekGuides,
      pendingGuides: pendingGuides ?? this.pendingGuides,
      moodGuides: moodGuides ?? this.moodGuides,
      quoteMessage: quoteMessage??this.quoteMessage,
      isLoading: isLoading ?? this.isLoading,
      hasCheckedIn: hasCheckedIn ?? this.hasCheckedIn,
      greeting: greeting ?? this.greeting,
      error: error ?? this.error,
    );
  }
}

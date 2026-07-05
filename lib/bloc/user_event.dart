import '../models/guide_model.dart';

abstract class UserEvent {}

class LoadHome extends UserEvent {
  final String userId;

  LoadHome(this.userId);
}

class CompleteCheckIn extends UserEvent {
  final String mood;

  CompleteCheckIn(this.mood);
}

class AddPendingGuide extends UserEvent {
  final GuideModel guide;

  AddPendingGuide(this.guide);
}

// NEW EVENTS
class WentOffline extends UserEvent {}

class WentOnline extends UserEvent {}

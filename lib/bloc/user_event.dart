abstract class UserEvent {}

class LoadHome extends UserEvent {
  final String userId;

  LoadHome(this.userId);
}

class CompleteCheckIn extends UserEvent {
  final String mood;

  CompleteCheckIn(this.mood);
}
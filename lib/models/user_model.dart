import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {
  final String id;
  final String name;
  final bool onboardingDone;
  final bool hasCheckedInThisWeek;
  final String? lastMood;
  final DateTime? lastCheckInAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.onboardingDone,
    required this.hasCheckedInThisWeek,
    this.lastMood,
    this.lastCheckInAt,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
    String id,
  ) {
    return UserModel(
      id: id,
      name: json['name'] ?? '',
      onboardingDone: json['onboardingDone'] ?? false,
      hasCheckedInThisWeek:
          json['hasCheckedInThisWeek'] ?? false,
      lastMood: json['lastMood'],
      lastCheckInAt:
          (json['lastCheckInAt'] as Timestamp?)
              ?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'onboardingDone': onboardingDone,
      'hasCheckedInThisWeek':
          hasCheckedInThisWeek,
      'lastMood': lastMood,
      'lastCheckInAt': lastCheckInAt == null
          ? null
          : Timestamp.fromDate(lastCheckInAt!),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    bool? onboardingDone,
    bool? hasCheckedInThisWeek,
    String? lastMood,
    DateTime? lastCheckInAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      onboardingDone:onboardingDone ??this.onboardingDone,
      hasCheckedInThisWeek:hasCheckedInThisWeek ??this.hasCheckedInThisWeek,
      lastMood: lastMood ?? this.lastMood,
      lastCheckInAt:lastCheckInAt ??this.lastCheckInAt,
    );
  }
}

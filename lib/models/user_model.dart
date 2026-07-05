import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {
  final String id;
  final String name;
  final bool onboardingDone;
  final String? lastMood;
  final DateTime? lastCheckInAt;
  final List<String>? pendingGuides;

  const UserModel({
    required this.id,
    required this.name,
    required this.onboardingDone,
    this.lastMood,
    this.lastCheckInAt,
    this.pendingGuides,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
    String id,
  ) {
    return UserModel(
      id: id,
      name: json['name'] ?? ' ',
      onboardingDone: json['onboardingDone'] ?? false,
      lastMood: json['lastMood'],
      lastCheckInAt:(json['lastCheckInAt'] as Timestamp?)?.toDate(),
      pendingGuides: List<String>.from(json['pendingGuides']??[]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'onboardingDone': onboardingDone,
      'lastMood': lastMood,
      'lastCheckInAt': lastCheckInAt == null? null:Timestamp.fromDate(lastCheckInAt!),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    bool? onboardingDone,
    bool? hasCheckedInThisWeek,
    String? lastMood,
    DateTime? lastCheckInAt,
    List<String>? pendingGuides,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      onboardingDone:onboardingDone ??this.onboardingDone,
      lastMood: lastMood ?? this.lastMood,
      lastCheckInAt:lastCheckInAt ??this.lastCheckInAt,
      pendingGuides:pendingGuides ?? this.pendingGuides,
    );
  }
}

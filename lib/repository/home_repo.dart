import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>
  get _users =>
      firestore.collection('users');

  Future<UserModel> getUser(
    String userId,
  ) async {
    final doc =
        await _users
            .doc(userId)
            .get();

    if (!doc.exists) {
      throw Exception(
        'User not found',
      );
    }

    return UserModel.fromJson(
      doc.data()!,
      doc.id,
    );
  }

  Future<void> completeCheckIn({
    required String userId,
    required String mood,
  }) async {
    await _users
        .doc(userId)
        .update({
          'lastMood': mood,
          'lastCheckInAt':
              Timestamp.now(),
        });
  }

  Future<void> updatePendingGuides({
    required String userId,
    required List<String>
    pendingGuides,
  }) async {
    await _users
        .doc(userId)
        .update({
          'pendingGuides':
              pendingGuides,
        });
  }
  Future<void> addPendingGuide({
    required String userId,
    required String guideId,
  }) async {
    await firestore
        .collection('users')
        .doc(userId)
        .update({
      'pendingGuides':
          FieldValue.arrayUnion(
        [guideId],
      ),
    });
  }
}
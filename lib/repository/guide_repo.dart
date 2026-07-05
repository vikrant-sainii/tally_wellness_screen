import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/guide_model.dart';

class GuideRepository {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>
  get _guides =>
      firestore.collection(
        'guides',
      );

  Future<List<GuideModel>>
  getThisWeekGuides() async {
    final snapshot =
        await _guides
            .where(
              'featuredThisWeek',
              isEqualTo: true,
            )
            .where(
              'active',
              isEqualTo: true,
            )
            .get();

    return snapshot.docs
        .map(
          (e) =>
              GuideModel.fromJson(
                e.data(),
                e.id,
              ),
        )
        .toList();
  }

  Future<List<GuideModel>>
  getPendingGuides(
    List<String> ids,
  ) async {
    if (ids.isEmpty) {
      return [];
    }
    final snapshot =
        await _guides
            .where(
              FieldPath.documentId,
              whereIn: ids,
            )
            .where(
              'active',
              isEqualTo: true,
            )
            .get();

    return snapshot.docs
        .map(
          (e) =>
              GuideModel.fromJson(
                e.data(),
                e.id,
              ),
        )
        .toList();
  }

  Future<List<GuideModel>>
  getMoodGuides(
    String mood,
  ) async {
    final snapshot =
        await _guides
            .where(
              'moods',
              arrayContains: mood,
            )
            .where(
              'active',
              isEqualTo: true,
            )
            .get();

    return snapshot.docs
        .map(
          (e) =>
              GuideModel.fromJson(
                e.data(),
                e.id,
              ),
        )
        .toList();
  }
}
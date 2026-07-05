import '../models/quote_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteRepository{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuoteModel?> getQuoteForMood(String mood) async {
    final doc = await firestore.collection('weekly_quotes').doc(mood).get();
    if (!doc.exists){ 
      return null;
    }
    return QuoteModel.fromJson(doc.data()!);
  }
}

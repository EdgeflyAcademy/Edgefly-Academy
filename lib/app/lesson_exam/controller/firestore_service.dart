import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getQuestions() async {
    var querySnapshot = await _firestore
        .collection('question/SSC/English/chapter 1/chapter 1')
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}

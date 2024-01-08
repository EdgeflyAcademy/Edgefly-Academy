import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static getUser(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}

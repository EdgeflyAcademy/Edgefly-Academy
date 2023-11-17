import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../nodels/user.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User? get user => auth.currentUser;

  //for checking if user exists or not
  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final createuser = UserDetails(
      id: user!.uid,
      name: user!.displayName.toString(),
      email: user!.email.toString(),
      about: "Hay i'am using L.earn",
      image: user!.photoURL.toString(),
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '',
      phone: '',
      category: '',
      institution: '',
      password: '',
    );
    return await firestore
        .collection('users')
        .doc(user!.uid)
        .set(createuser.toJson());
  }

  static Future<void> storeUserData(
      {name, password, email, phone, category, institution}) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentReference store = firestore.collection('users').doc(user!.uid);
    store.set({
      'about': "Hay i am using L.earn",
      'created_at': time,
      'name': name,
      'password': password,
      'email': email,
      'image': '',
      'id': user!.uid,
      'is_online': false,
      'last_active': time,
      'push_token': "",
      'phone': phone,
      'category': category,
      'institution': institution,
    });
  }
}

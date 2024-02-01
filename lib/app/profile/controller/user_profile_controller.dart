import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var userData = <String, dynamic>{}.obs;

  void fetchUserData() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snapshot.exists) {
        userData.value = snapshot.data() as Map<String, dynamic>;
      }
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }
}

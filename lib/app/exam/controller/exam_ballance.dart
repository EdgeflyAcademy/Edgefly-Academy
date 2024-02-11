import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ExamBallanceController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final balance = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getuserinfo();
  }

  getuserinfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;

      DocumentSnapshot userDocSnapshot =
          await _firestore.collection('users').doc(userId).get();

      String balanceString = userDocSnapshot['balance'];
      int balanceInt = int.parse(balanceString);
      balance.value = balanceInt;
    }
  }
}

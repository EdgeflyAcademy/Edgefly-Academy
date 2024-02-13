import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  @override
  void onInit() {
    getData = getUserData();
    super.onInit();
  }

  var isLoading = false.obs;
  var currentUser = FirebaseAuth.instance.currentUser;
  var userbalance = ''.obs;
  var userpoint = ''.obs;
  Future? getData;

  getUserData() async {
    isLoading(true);
    DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    var userData = user.data();
    userbalance.value = userData!['balance'] ?? "";
    userpoint.value = userData['points'] ?? "";
    isLoading(false);
  }
}

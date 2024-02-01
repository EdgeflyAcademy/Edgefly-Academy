import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  RxString errorMessage = ''.obs;

  Future<void> updatePassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      String currentPassword = userDoc['password'];

      if (oldPasswordController.text == currentPassword) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'password': newPasswordController.text});

        Get.back(result: 'Password updated successfully');
      } else {
        errorMessage.value = 'Old password does not match. Try again.';
      }
    } catch (error) {
      print('Error updating password: $error');
      // Handle error as needed
    }
  }
}

class UpdatePasswordScreen extends StatelessWidget {
  final UpdatePasswordController controller = Get.put(UpdatePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter old password',
              ),
            ),
            TextField(
              controller: controller.newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter new password',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.updatePassword(),
              child: Text('Update Password'),
            ),
            Obx(() {
              if (controller.errorMessage.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}

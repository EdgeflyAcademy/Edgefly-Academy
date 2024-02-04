import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileSettingsController extends GetxController {
  RxBool isProfileVisible = true.obs;
  RxBool isButtonEnabled = false.obs;
  RxBool isLoading = false.obs;

  void toggleProfileVisibility(bool value) {
    isProfileVisible.value = value;
    isButtonEnabled.value = true;
  }

  Future<void> saveChanges() async {
    try {
      isLoading.value = true;

      // Simulate a delay for the loading indicator (you can remove this in a real application)
      await Future.delayed(Duration(seconds: 2));

      // Update the "profile_visibility" field in Firestore
      final userId =
          FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .update({"profile_visibility": isProfileVisible.value});

      // Show a snackbar after successful update
      Get.snackbar(
        'Updated',
        'Profile visibility changed',
        snackPosition: SnackPosition.TOP,
        shouldIconPulse: true,
        icon: Icon(Icons.check_circle_rounded, color: Colors.green[900]),
      );
    } catch (error) {
      // Handle error if necessary
      Get.snackbar(
        'Error',
        'Failed to update profile visibility',
        snackPosition: SnackPosition.TOP,
        shouldIconPulse: true,
        icon: Icon(Icons.error_rounded, color: Colors.red[900]),
      );
      print("Error: $error");
    } finally {
      isLoading.value = false;
      isButtonEnabled.value = false;
    }
  }
}

class ProfileSettingsPage extends StatelessWidget {
  final ProfileSettingsController controller =
      Get.put(ProfileSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile Visibility Settings:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'If you want to make your profile public and visible to others, then select enable. Otherwise, select disable and to confirm click save changes.',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16.0),
            Obx(() => RadioListTile(
                  title: const Text(
                    'Enable',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: true,
                  groupValue: controller.isProfileVisible.value,
                  onChanged: (value) {
                    controller.toggleProfileVisibility(value!);
                  },
                  activeColor: Colors.blue,
                )),
            Obx(() => RadioListTile(
                  title: const Text(
                    'Disable',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  value: false,
                  groupValue: controller.isProfileVisible.value,
                  onChanged: (value) {
                    controller.toggleProfileVisibility(value!);
                  },
                  activeColor: Colors.blue,
                )),
          ],
        ),
      ),

      // Save Changes Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => ElevatedButton(
              onPressed: controller.isButtonEnabled.value
                  ? () async {
                      await controller.saveChanges();
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  // if (controller.isLoading.value) {
                  //   return Colors.grey; // Grey color when disabled
                  // }
                  return controller.isButtonEnabled.value
                      ? states.contains(MaterialState.pressed)
                          ? Colors.blueAccent
                          : Colors.blue
                      : Colors.grey;
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: !controller.isLoading.value,
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Visibility(
                    visible: controller.isLoading.value,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

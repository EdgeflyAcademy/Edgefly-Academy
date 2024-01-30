import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    nameController.text = Get.find<UserController>().userData['name'] ?? '';
    aboutController.text = Get.find<UserController>().userData['about'] ?? '';
    emailController.text = Get.find<UserController>().userData['email'] ?? '';
    institutionController.text =
        Get.find<UserController>().userData['institution'] ?? '';
    phoneController.text = Get.find<UserController>().userData['phone'] ?? '';
    passwordController.text =
        Get.find<UserController>().userData['password'] ?? '';
  }

  final imageUrl = Get.find<UserController>().userData['imageUrl'];
  //get the download URL after uploading image in the firestore
  String getImageUrl = '';

  final UserController userController = Get.put(UserController());

  File? _pickedImage;

  //to get picked image from camera
  Future<void> _pickCameraImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 15);
    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
  }

  //to get picked image from gallery
  Future<void> _pickGalleryImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 15);
    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
  }

  //pick image from gallery or camera popup
  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      _pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.camera_alt, color: Colors.black),
                    title: const Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      _pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.image, color: Colors.black),
                    title: const Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // _showImagePickerDialog();
                  pickImage(context);
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: (_pickedImage != null)
                          ? FileImage(_pickedImage!) as ImageProvider
                          : NetworkImage(imageUrl),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // CircleAvatar(
              //   radius: 60,
              //   backgroundImage: NetworkImage(
              //       Get.find<UserController>().userData['imageUrl']),
              // ),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: aboutController,
                decoration: InputDecoration(labelText: 'About'),
              ),
              // Add TextFormField for other fields as needed
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: institutionController,
                decoration: InputDecoration(labelText: 'Institution'),
              ),

              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),

              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_pickedImage != null) {
              String uniqueFileName =
                  "${nameController.text}@${institutionController.text}@${phoneController.text}@${DateTime.now().millisecondsSinceEpoch.toString()}";
              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages = referenceRoot.child('user_images');
              //Create a reference for the image to be stored
              Reference referenceImageToUpload =
                  referenceDirImages.child(uniqueFileName);
              //Handle errors/success
              try {
                //Store the file
                await referenceImageToUpload.putFile(File(_pickedImage!.path));
                //Success: get the download URL
                getImageUrl = await referenceImageToUpload.getDownloadURL();
                /************ */
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'imageUrl': getImageUrl,
                  'name': nameController.text,
                  'about': aboutController.text,
                  'email': emailController.text,
                  'institution': institutionController.text,
                  'phone': phoneController.text,
                  'password': passwordController.text,
                  // Update other fields as needed
                });
                Get.find<UserController>().fetchUserData();
                Get.back(); // Navigate back to the profile screen
                Get.snackbar(
                  'Success',
                  'Your profile is updated',
                  snackPosition: SnackPosition.TOP,
                  shouldIconPulse: true,
                  icon: Icon(Icons.check_circle_rounded,
                      color: Colors.green[900]),
                );
              } catch (error) {
                print("Error updating user data: $error");
                // Handle error, show snackbar, etc.
                Get.snackbar(
                  'Error',
                  'Failed to update profile. Please try again.',
                  snackPosition: SnackPosition.TOP,
                  shouldIconPulse: true,
                  icon: Icon(Icons.error_rounded, color: Colors.red[900]),
                );
              }
              _pickedImage = null;
            } else {
              try {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'name': nameController.text,
                  'about': aboutController.text,
                  'email': emailController.text,
                  'institution': institutionController.text,
                  'phone': phoneController.text,
                  'password': passwordController.text,
                  // Update other fields as needed
                });
                Get.find<UserController>().fetchUserData();
                Get.back(); // Navigate back to the profile screen
                Get.snackbar(
                  'Success',
                  'Your profile is updated',
                  snackPosition: SnackPosition.TOP,
                  shouldIconPulse: true,
                  icon: Icon(Icons.check_circle_rounded,
                      color: Colors.green[900]),
                );
              } catch (error) {
                print("Error updating user data: $error");
                // Handle error, show snackbar, etc.
                Get.snackbar(
                  'Error',
                  'Failed to update profile. Please try again.',
                  snackPosition: SnackPosition.TOP,
                  shouldIconPulse: true,
                  icon: Icon(Icons.error_rounded, color: Colors.red[900]),
                );
              }
            }
          },
          child: Text('Update Profile'),
        ),
      ),
    );
  }
}

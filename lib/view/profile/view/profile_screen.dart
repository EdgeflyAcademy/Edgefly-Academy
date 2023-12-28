import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../auth/view/signin_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final GoogleSignIn googleSignIn = GoogleSignIn();
            final FirebaseAuth auth = FirebaseAuth.instance;

            // Sign out of Google
            await googleSignIn.signOut();
            log('Signed out of Google');

            // Sign out of Firebase
            await auth.signOut();
            await FirebaseAuth.instance.signOut();
            log('Signed out of Firebase');

            // Navigate to WelcomeScreen
            Get.offAll(() => const SigninScreen());
          } catch (e) {
            log('Error: $e');
          }
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}

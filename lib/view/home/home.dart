import 'package:edgefly_academy/view/wellcome_screen/wellcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          await googleSignIn.signOut();
          Get.offAll(() => const WellcomeScreen());
        },
        child: const Icon(Icons.logout_rounded),
      ),
      appBar: AppBar(
        title: "Home".text.make(),
      ),
    );
  }
}

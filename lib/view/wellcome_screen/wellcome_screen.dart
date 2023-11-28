import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../common widzet/dialogs.dart';
import '../home_screen/home_screen/home.dart';
import '../auth/controller/api.dart';
import '../auth/view/Registration_page.dart';
import '../auth/view/signin_screen.dart';
import 'component/line.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({super.key});

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  handleGoogleButtunClick() {
    Dialogs.showProgress(context);
    signInWithGoogle().then((user) async {
      navigator!.pop(context);
      if (user != null) {
        //already have data
        if ((await Apis.userExists())) {
          Get.offAll(() => const Home());
        } else {
          //user log in for first time
          await Apis.createUser().then((value) {
            Get.offAll(() => const Home());
          });
        }
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    try {
      await InternetAddress.lookup('google.com');
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // ignore: use_build_context_synchronously
      Dialogs.showSnackbar(context, "No internet connection !");
      // ignore: avoid_print
      print('error:$e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/icon.png",
            height: context.screenHeight * .3,
            width: context.screenWidth * .3,
          ).box.alignment(Alignment.center).make(),
          "The best education app".text.size(24).color(Colors.black87).make(),
          "The more you study, The more you earn"
              .text
              .size(18)
              .color(Colors.black54)
              .make(),
          30.heightBox,
          SizedBox(
            height: 50,
            width: context.screenWidth - 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF134668)),
              onPressed: () {
                Get.to(() => const RegistrationPage());
              },
              child: "Registration".text.white.make(),
            ),
          ),
          15.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(
                size: Size(context.screenWidth * .35, 1), // Size of the line
                painter: MyPainter(), // CustomPainter
              ),
              8.widthBox,
              "OR".text.make(),
              8.widthBox,
              CustomPaint(
                size: Size(context.screenWidth * .35, 1), // Size of the line
                painter: MyPainter(), // CustomPainter
              ),
            ],
          ).box.padding(const EdgeInsets.symmetric(horizontal: 20)).make(),
          10.heightBox,
          SizedBox(
            width: context.screenWidth * .9,
            height: context.screenHeight * .06,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 223, 255, 187),
                  shape: const StadiumBorder(),
                  elevation: 1),
              onPressed: () {
                handleGoogleButtunClick();
              },
              //google icon
              icon: Image.asset('assets/icons/google.png',
                  height: context.screenHeight * .03),
              //login with google label
              label: RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(text: 'Login with '),
                    TextSpan(
                        text: 'Google',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Already have an account?".text.color(Colors.black54).make(),
              10.widthBox,
              TextButton(
                  onPressed: () {
                    Get.to(() => const SigninScreen());
                  },
                  child: "Sign in".text.color(const Color(0xFF134668)).make())
            ],
          )
        ],
      ),
    );
  }
}

// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:pinput/pinput.dart';

import '../nodels/coustom_text.dart';

class VerificationPage extends StatefulWidget {
  final User user;
  const VerificationPage({super.key, required this.user});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  var code = "";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: "Enter Code".text.color(Colors.black87).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            10.heightBox,
            "Code has send to ${widget.user.phone}".text.size(17).make(),
            30.heightBox,
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                code = value;
              },
            ),
            30.heightBox,
            "Resend code in 59 s".text.size(16).color(Colors.black54).make(),
            20.heightBox,
            SizedBox(
              height: 50,
              width: context.screenWidth - 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF134668)),
                onPressed: () async {
                  // Dialogs.showProgress(context);
                  // try {
                  //   firebase_auth.PhoneAuthCredential credential =
                  //       firebase_auth.PhoneAuthProvider.credential(
                  //           verificationId: RegistrationPage.verify,
                  //           smsCode: code);

                  //   // Sign the user in (or link) with the credential
                  //   await auth.signInWithCredential(credential);
                  //   await Apis.storeUserData(
                  //     name: widget.user.name,
                  //     password: widget.user.password,
                  //     email: widget.user.email,
                  //     phone: widget.user.phone,
                  //     category: widget.user.category,
                  //     institution: widget.user.institution,
                  //   ).then((value) {
                  //     VxToast.show(context, msg: "signupsucess");
                  //     navigator!.pop(context);
                  //     Get.offAll(() => const Home());
                  //   });
                  // } catch (e) {
                  //   VxToast.show(context, msg: "Wrong OTP");
                  // }
                },
                child: "Verify".text.white.make(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../common widzet/dialogs.dart';
import '../component/coustom_textfield.dart';
import '../nodels/coustom_text.dart';
import 'varification_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static String verify = "";

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController countrycodecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  TextEditingController institutioncontroller = TextEditingController();
  var phone = "";

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    inistalGetSavedData();
    countrycodecontroller.text = "+880";
  }

  void inistalGetSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void storedata() {
    User user = User(
      namecontroller.text,
      emailcontroller.text,
      passcontroller.text,
      phonecontroller.text,
      categorycontroller.text,
      institutioncontroller.text,
    );

    Map<String, dynamic> userMap = user.toMap(); // Convert User to a Map
    String userdata = jsonEncode(userMap); // Encode the Map to JSON
    sharedPreferences.setString('userdata', userdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: "Registration".text.color(Colors.black87).make(),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              coustomtextfield(
                controller: namecontroller,
                hint: "Enter your full name",
                title: "Full Name",
                isPass: false,
              ),
              coustomtextfield(
                controller: emailcontroller,
                hint: "Enter your Email",
                title: "Email",
                isPass: false,
              ),
              coustomtextfield(
                controller: passcontroller,
                hint: "********",
                title: "Password",
                isPass: true,
              ),
              coustomtextfield(
                hint: "********",
                title: "Confirm Password",
                isPass: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Phone number"
                      .text
                      .size(18.0)
                      .color(const Color(0xFF134668))
                      .align(TextAlign.start)
                      .make(),
                ],
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(width: 1, color: const Color(0xFF134668)),
                ),
                child: Row(
                  children: [
                    6.widthBox,
                    SizedBox(
                      width: 45,
                      child: TextField(
                        controller: countrycodecontroller,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                          fontSize: context.screenHeight * .03,
                          color: Colors.grey),
                    ),
                    10.widthBox,
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "enter your phone number"),
                    ))
                  ],
                ),
              ),
              coustomtextfield(
                controller: categorycontroller,
                hint: "SSC",
                title: "Category",
                isPass: false,
              ),
              coustomtextfield(
                controller: institutioncontroller,
                hint: "Dhaka International University",
                title: "Institution",
                isPass: false,
              ),
              30.heightBox,
              SizedBox(
                height: 50,
                width: context.screenWidth - 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF134668)),
                  onPressed: () async {
                    try {
                      Dialogs.showProgress(context);
                      await auth.FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countrycodecontroller.text + phone,
                        verificationCompleted:
                            (auth.PhoneAuthCredential credential) {},
                        verificationFailed: (auth.FirebaseAuthException e) {},
                        codeSent:
                            (String verificationId, int? resendToken) async {
                          RegistrationPage.verify = verificationId;
                          User user = User(
                            namecontroller.text,
                            emailcontroller.text,
                            passcontroller.text,
                            countrycodecontroller.text + phone,
                            categorycontroller.text,
                            institutioncontroller.text,
                          );
                          storedata();
                          navigator!.pop(context);
                          Get.to(() => VerificationPage(
                                user: user,
                              ));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    } catch (e) {
                      // ignore: avoid_print
                      print('error:$e');
                      VxToast.show(context,
                          msg: "Check Your internet connection");
                    }
                  },
                  child: "Registration".text.white.make(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

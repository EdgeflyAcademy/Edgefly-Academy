import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../home/home.dart';
import '../component/coustom_textfield.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool? isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/learning.png",
                height: context.screenHeight * .22,
                width: context.screenWidth * .60,
              ).box.alignCenter.make(),
              "Sign in to your account".text.size(28).make(),
              coustomtextfield(
                hint: "Enter your Email",
                title: "Phone number or Email",
                isPass: false,
              ),
              coustomtextfield(
                hint: "********",
                title: "Password",
                isPass: true,
              ),
              10.heightBox,
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    value: isCheck,
                    onChanged: (newvalue) {
                      setState(() {
                        isCheck = newvalue;
                      });
                    },
                  ),
                  "Remember me".text.make()
                ],
              ),
              SizedBox(
                height: 50,
                width: context.screenWidth - 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF134668)),
                  onPressed: () {
                    Get.offAll(() => const Home());
                  },
                  child: "Sign in".text.white.make(),
                ),
              ),
              15.heightBox,
              "Forgot the password?".text.size(16).make(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Don’t have an account?".text.size(16).make(),
                  5.widthBox,
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: "Sign up".text.color(Colors.green).make(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:edgefly_academy/app/home_screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int incorrectAnswers;
  final int skipedAnsewr;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.skipedAnsewr,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff408dd3),
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => const HomeScreen());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Exam result',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.screenWidth * .05),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff4bb050),
                  borderRadius: BorderRadius.circular(20)),
              height: 200,
              width: context.screenWidth * .90,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Congratulation".text.bold.size(25).white.make(),
                  20.heightBox,
                  'Correct Answers: $correctAnswers'.text.white.make(),
                  'Incorrect Answers: $incorrectAnswers'.text.white.make(),
                  'Skiped Question: $skipedAnsewr'.text.white.make(),
                  10.heightBox,
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => const HomeScreen());
                    },
                    child: "Go to home".text.make(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

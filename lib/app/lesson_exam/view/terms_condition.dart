// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:edgefly_academy/app/exam/controller/exam_ballance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../wallet/view/recharge.dart';
import 'exam_view.dart';

class TermCondition extends StatelessWidget {
  var subject;
  var chapter;
  TermCondition({super.key, this.subject, this.chapter});

  @override
  Widget build(BuildContext context) {
    ExamBallanceController controller = Get.put(ExamBallanceController());
    return Scaffold(
      appBar: AppBar(
        title: "Terms & Conditions".text.make(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "1:Eligibility: Participants must be eligible as per exam guidelines."),
              10.heightBox,
              const Text(
                  "2:Registration: Registration implies acceptance of these terms."),
              10.heightBox,
              const Text(
                  "3:Integrity: Cheating or dishonesty will result in disqualification."),
              const Text(
                  "4:Materials: Only authorized materials allowed during exam."),
              10.heightBox,
              const Text(
                  "5:Conduct: Follow proctor instructions; no disruption."),
              10.heightBox,
              const Text("6:Confidentiality: Do not share exam content."),
              10.heightBox,
              const Text("7:Results: Provided as per institution's timeline."),
              10.heightBox,
              const Text(
                  "8:Liability: Institution not liable for participant expenses or losses."),
              10.heightBox,
              const Text(
                  "9:Changes: Institution reserves right to update terms."),
              10.heightBox,
              const Text(
                  "10:Jurisdiction: Governing laws and jurisdiction apply."),
              30.heightBox,
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3a74c7)),
                  onPressed: () {
                    if (controller.balance < 10) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Insufficient balance'),
                            content: const Text(
                                'Your account does not have enough money to continue the exam.Pleaace reacherge first'),
                            actions: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff4bb050),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    Get.back();
                                    Get.to(WalletRechargePage());
                                  },
                                  child: const Text(
                                    'recharge',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              10.widthBox,
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff3a74c7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Get.offAll(() => LesonQuizScreen(
                            subject: subject,
                            chapter: chapter,
                          ));
                    }
                  },
                  child: "Agree & Continue".text.white.make(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

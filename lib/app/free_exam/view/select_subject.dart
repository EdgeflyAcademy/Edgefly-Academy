import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../home_screen/home_screen/home_screen.dart';
import 'terms_condition.dart';

class FreeSubjectChose extends StatelessWidget {
  const FreeSubjectChose({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => const HomeScreen());
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: const Color(0xff3778c8),
        elevation: 2,
        title: "Select subject".text.white.bold.make(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff3777c8),
              Color.fromARGB(255, 89, 215, 247),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Select an subject".text.size(22).bold.white.make(),
              20.heightBox,
              SizedBox(
                height: context.screenHeight * .08,
                width: context.screenWidth * .4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200]),
                  onPressed: () {
                    Get.to(
                      () => TermsConditionsss(
                        subject: "Physics",
                      ),
                    );
                  },
                  child: "Physics".text.white.make(),
                ),
              ),
              20.heightBox,
              SizedBox(
                height: context.screenHeight * .08,
                width: context.screenWidth * .4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[200]),
                  onPressed: () {
                    Get.to(
                      () => TermsConditionsss(
                        subject: "Chemistry",
                      ),
                    );
                  },
                  child: "Chemistry".text.white.make(),
                ),
              ),
              20.heightBox,
              SizedBox(
                height: context.screenHeight * .08,
                width: context.screenWidth * .4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[200]),
                  onPressed: () {
                    Get.to(
                      () => TermsConditionsss(
                        subject: "Biology",
                      ),
                    );
                  },
                  child: "Biology".text.white.make(),
                ),
              ),
              20.heightBox,
              SizedBox(
                height: context.screenHeight * .08,
                width: context.screenWidth * .4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200]),
                  onPressed: () {
                    Get.to(
                      () => TermsConditionsss(
                        subject: "Biology",
                      ),
                    );
                  },
                  child: "Hiremath".text.white.make(),
                ),
              ),
              SizedBox(
                height: context.screenHeight * .3,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../home_screen/home_screen/home_screen.dart';
import '../controller/exam_controller.dart';
import '../widgets/showdialog.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  var subject;
  QuizScreen({super.key, this.subject});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver {
  final QuizController quizController = Get.put(QuizController());
  bool _showDialogOnResume = false;

  @override
  void initState() {
    super.initState();
    quizController.loadQuestions(widget.subject);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is sent to the background (minimized)
      _showDialogOnResume = true;
    } else if (state == AppLifecycleState.resumed) {
      // App is resumed (comes back to the foreground)
      if (_showDialogOnResume) {
        _showDialogOnResume = false;
        showDialogOnResume();
      }
    }
  }

  void showDialogOnResume() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CountdownDialog(); // Use StatefulWidget for dialog content
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              showConfirmationDialog(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xff4bb050),
        title: const Text(
          'MCQ Quiz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => quizController.questions.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : quizController.questions.length <= 14
                  ? const Center(child: Text("Not enough questions"))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: 15,
                            itemBuilder: (context, index) {
                              var question = quizController.questions[index];
                              return Card(
                                color: const Color(0xff4bb050),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                elevation: 5,
                                child: Column(
                                  children: [
                                    10.heightBox,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Question: ${question.question}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    10.heightBox,
                                    Obx(
                                      () => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: RadioListTile(
                                          title: Text(question.option1),
                                          value: question.option1,
                                          groupValue: quizController
                                              .selectedAnswer[index],
                                          onChanged: (value) {
                                            quizController.setSelectedAnswer(
                                                index, value.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                    5.heightBox,
                                    Obx(
                                      () => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: RadioListTile(
                                          title: Text(question.option2),
                                          value: question.option2,
                                          groupValue: quizController
                                              .selectedAnswer[index],
                                          onChanged: (value) {
                                            quizController.setSelectedAnswer(
                                                index, value.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                    5.heightBox,
                                    Obx(
                                      () => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: RadioListTile(
                                          title: Text(question.option3),
                                          value: question.option3,
                                          groupValue: quizController
                                              .selectedAnswer[index],
                                          onChanged: (value) {
                                            quizController.setSelectedAnswer(
                                                index, value.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                    5.heightBox,
                                    Obx(
                                      () => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: RadioListTile(
                                          title: Text(question.option4),
                                          value: question.option4,
                                          groupValue: quizController
                                              .selectedAnswer[index],
                                          onChanged: (value) {
                                            quizController.setSelectedAnswer(
                                                index, value.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                    10.heightBox,
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: context.screenWidth * .4,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
          onPressed: () {
            quizController.checkAnswers();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.done_all,
                color: Colors.white,
              ),
              5.widthBox,
              const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownDialog extends StatefulWidget {
  @override
  _CountdownDialogState createState() => _CountdownDialogState();
}

class _CountdownDialogState extends State<CountdownDialog> {
  int countdown = 3;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
        Navigator.of(context).pop(); // Close the dialog
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Welcome Back"),
      content: Row(
        children: [
          const Text("You will return to home page in "),
          Text(
            "$countdown",
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),
          ),
          const Text(" seconds."),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/exam_controller.dart';

class QuizScreen extends StatelessWidget {
  final QuizController quizController = Get.put(QuizController());

  QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4bb050),
        title: const Text('MCQ Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => quizController.questions.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: quizController.questions.length,
                  itemBuilder: (context, index) {
                    var question = quizController.questions[index];
                    return Card(
                      color: const Color(0xff4bb050),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 5,
                      child: Column(
                        children: [
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              15.widthBox,
                              "Question: ".text.semiBold.white.make(),
                              Text(
                                question.question,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          10.heightBox,
                          Obx(
                            () => Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RadioListTile(
                                title: Text(question.option1),
                                value: question.option1,
                                groupValue:
                                    quizController.selectedAnswer[index],
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RadioListTile(
                                title: Text(question.option2),
                                value: question.option2,
                                groupValue:
                                    quizController.selectedAnswer[index],
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RadioListTile(
                                title: Text(question.option3),
                                value: question.option3,
                                groupValue:
                                    quizController.selectedAnswer[index],
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: RadioListTile(
                                title: Text(question.option4),
                                value: question.option4,
                                groupValue:
                                    quizController.selectedAnswer[index],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          quizController.checkAnswers();
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

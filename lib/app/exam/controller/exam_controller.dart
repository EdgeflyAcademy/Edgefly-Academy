import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/question_model.dart';
import 'firestore_service.dart';

class QuizController extends GetxController {
  var questions = <Question>[].obs;
  var selectedAnswer = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    var questionsData = await FirestoreService().getQuestions();

    questions.assignAll(
      questionsData.map((data) => Question(
            answer: data['answer'],
            category: data['category'],
            chapter: data['chapter'],
            option1: data['option1'],
            option2: data['option2'],
            option3: data['option3'],
            option4: data['option4'],
            question: data['question'],
            subject: data['subject'],
          )),
    );

    // Initialize the selectedAnswer list with empty strings for each question
    selectedAnswer.assignAll(List.generate(questions.length, (_) => ''));
  }

  void setSelectedAnswer(int questionIndex, String answer) {
    selectedAnswer[questionIndex] = answer;
    update(); // Update the UI when the answer is selected
  }

  void checkAnswers() {
    // Implement logic to check answers and display result in a popup screen

    var correctAnswers = 0;
    var incorrectAnswers = 0;

    for (var i = 0; i < questions.length; i++) {
      if (questions[i].answer == selectedAnswer[i]) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    }

    Get.defaultDialog(
      title: 'Quiz Result',
      content: Column(
        children: [
          Text('Correct Answers: $correctAnswers'),
          Text('Incorrect Answers: $incorrectAnswers'),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back(); // Close the dialog
        },
        child: const Text('OK'),
      ),
    );
  }
}

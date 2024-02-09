import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../result_screen/show_result.dart';
import '../model/question_model.dart';

class QuizController extends GetxController {
  var questions = <Question>[].obs;
  var selectedAnswer = <String>[].obs;
  var skippedAnswers = 0.obs; // Variable to track skipped answers
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Question>> getQuestions(String subject) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;

      DocumentSnapshot userDocSnapshot =
          await _firestore.collection('users').doc(userId).get();

      String category = userDocSnapshot['category'];
      var querySnapshot = await _firestore
          .collection("question")
          .doc(category)
          .collection(subject)
          .get();

      List<DocumentSnapshot> documents = querySnapshot.docs;

      documents.shuffle();
      List<DocumentSnapshot> selectedDocuments =
          documents.sublist(0, min(15, documents.length));

      List<Question> selectedQuestions = selectedDocuments
          .map((doc) => Question(
                answer: doc['answer'],
                category: doc['category'],
                chapter: doc['chapter'],
                option1: doc['option1'],
                option2: doc['option2'],
                option3: doc['option3'],
                option4: doc['option4'],
                question: doc['question'],
                subject: doc['subject'],
              ))
          .toList();

      return selectedQuestions;
    } else {
      throw Exception('User is not authenticated');
    }
  }

  Future<void> loadQuestions(String subject) async {
    try {
      var questionsData = await getQuestions(subject);
      questions.assignAll(questionsData);
      selectedAnswer.assignAll(List.generate(questions.length, (_) => ''));
    } catch (e) {
      // ignore: avoid_print
      print('Error loading questions: $e');
    }
  }

  void setSelectedAnswer(int questionIndex, String answer) {
    selectedAnswer[questionIndex] = answer;
    update();
  }

  void checkAnswers() {
    var correctAnswers = 0;
    var incorrectAnswers = 0;
    var skipped = 0; // Variable to track skipped answers

    for (var i = 0; i < questions.length; i++) {
      // Check if the answer is skipped (not selected)
      if (selectedAnswer[i].isEmpty) {
        skipped++;
      } else if (questions[i].answer == selectedAnswer[i]) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    }

    // Update the skippedAnswers variable
    skippedAnswers.value = skipped;

    Get.offAll(
      () => ResultScreen(
        correctAnswers: correctAnswers,
        incorrectAnswers: incorrectAnswers,
        skipedAnsewr: skipped,
      ),
    );
  }
}

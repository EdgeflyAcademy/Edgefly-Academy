import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edgefly_academy/app/home_screen/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../result_screen/show_result.dart';
import '../model/question_model.dart';
import '../widgets/exam_dialog.dart';

class LesonQuizController extends GetxController {
  var questions = <Question>[].obs;
  var selectedAnswer = <String>[].obs;
  var skippedAnswers = 0.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var balance = 0.obs;

  RxString remainingTimeString = ''.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    int totalSeconds = 15 * 60;
    remainingTimeString.value = formatDuration(totalSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalSeconds > 0) {
        totalSeconds--;
        remainingTimeString.value = formatDuration(totalSeconds);
      } else {
        _timer?.cancel();
        Get.snackbar(
          'Time out',
          'Your exam time is over',
          snackPosition: SnackPosition.TOP,
          shouldIconPulse: true,
          icon: Icon(
            Icons.check_circle_rounded,
            color: Colors.green[900],
          ),
        );
        Get.offAll(() => const HomeScreen());
      }
    });
  }

  String formatDuration(int totalSeconds) {
    final Duration duration = Duration(seconds: totalSeconds);
    final String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<List<Question>> getQuestions(String subject, String chapter) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;

      DocumentSnapshot userDocSnapshot =
          await _firestore.collection('users').doc(userId).get();

      String category = userDocSnapshot['category'];
      String balanceString = userDocSnapshot['balance'];
      int balanceInt = int.parse(balanceString);
      balance.value = balanceInt - 10;

      var querySnapshot = await _firestore
          .collection("question")
          .doc(category)
          .collection(subject)
          .where('chapter', isEqualTo: chapter)
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

  Future<void> loadQuestions(String subject, String chapter, context) async {
    try {
      var questionsData = await getQuestions(subject, chapter);
      if (questionsData.length < 15) {
        VxToast.show(context,
            msg: "Not Enough Data,you will get your money back");
        showNotEnoughQUestion(context);
      } else {
        questions.assignAll(questionsData);
        selectedAnswer.assignAll(List.generate(questions.length, (_) => ''));
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'balance': balance.toString()});
      }
    } catch (e) {
      VxToast.show(context, msg: "Try after some time");
    }
  }

  void setSelectedAnswer(int questionIndex, String answer) {
    selectedAnswer[questionIndex] = answer;
    update();
  }

  void checkAnswers() {
    var correctAnswers = 0;
    var incorrectAnswers = 0;
    var skipped = 0;

    for (var i = 0; i < questions.length; i++) {
      if (selectedAnswer[i].isEmpty) {
        skipped++;
      } else if (questions[i].answer == selectedAnswer[i]) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
    }

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

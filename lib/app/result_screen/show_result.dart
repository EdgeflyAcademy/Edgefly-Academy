import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edgefly_academy/app/home_screen/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class ResultScreen extends StatefulWidget {
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
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    uploadtofirestoredata();
  }

  late String _category;
  late String _points;
  var pointss = 0.obs;

  // Method to fetch user category from Firestore
  Future<void> uploadtofirestoredata() async {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        String timestamp = generateTimestamp();
        _category = userDoc.get('category');
        _points = userDoc.get('points');
        int balanceInt = int.parse(_points);
        pointss.value = balanceInt + widget.correctAnswers;
        // ignore: avoid_print
        print(_category);
        FirebaseFirestore.instance
            .collection('examresult')
            .doc(_category)
            .collection('allresult')
            .doc(timestamp)
            .set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'timestamp': timestamp,
          'time': formattedDate,
          'correctedanswer': widget.correctAnswers,
          'incorrectanswer': widget.incorrectAnswers,
          'skipquestion': widget.skipedAnsewr,
        }).then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'points': pointss.toString()});
        }).then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("allexam")
              .doc(timestamp).set({
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'timestamp': timestamp,
          'time': formattedDate,
          'correctedanswer': widget.correctAnswers,
          'incorrectanswer': widget.incorrectAnswers,
          'skipquestion': widget.skipedAnsewr,
        });
        });
        
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      throw Exception('Error fetching user category: $e');
    }
  }

  // Method to get the user category
  String getUserCategory() {
    return _category;
  }

  String generateTimestamp() {
    DateTime currentTime = DateTime.now();
    return currentTime.toUtc().toIso8601String();
  }

  String formattedDate = DateFormat('MMMM d, y hh:mm a').format(DateTime.now());

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
                  'Correct Answers: ${widget.correctAnswers}'.text.white.make(),
                  'Incorrect Answers: ${widget.incorrectAnswers}'
                      .text
                      .white
                      .make(),
                  'Skiped Question: ${widget.skipedAnsewr}'.text.white.make(),
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

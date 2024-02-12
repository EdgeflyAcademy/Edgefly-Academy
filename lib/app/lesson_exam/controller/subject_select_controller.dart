import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSubjectController extends GetxController {
  TextEditingController questionController = TextEditingController();
  TextEditingController optioncontroller1 = TextEditingController();
  TextEditingController optioncontroller2 = TextEditingController();
  TextEditingController optioncontroller3 = TextEditingController();
  TextEditingController optioncontroller4 = TextEditingController();
  TextEditingController correctAnswerController = TextEditingController();

  late String selectedField2 = ""; // Value for the second dropdown
  late String selectedField3 = ""; // Value for the third dropdown
  List<String> field2Items = ['Physics', 'Chemistry', 'Biology', 'Hiremath'];
  List<String> field3Items = [
    'chapter 1',
    'chapter 2',
    'chapter 3',
    'chapter 4',
    'chapter 5',
    'chapter 6',
    'chapter 7',
    'chapter 8',
    'chapter 9',
    'chapter 10',
    'chapter 11',
    'chapter 12'
  ];
  String? validDropdownbutton(values) {
    if (values == null || values.isEmpty) {
      return 'Please select an option';
    }
    return null;
  }
}

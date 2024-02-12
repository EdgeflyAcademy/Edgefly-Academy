import 'package:edgefly_academy/app/home_screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showNotEnoughQUestion(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Not enough queststions'),
        content: const Text('Please try after some time'),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                Get.offAll(const HomeScreen());
              },
              child: const Text(
                'ok',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    },
  );
}

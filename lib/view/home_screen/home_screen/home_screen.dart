import 'package:edgefly_academy/view/exam/view/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/home_wiget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List _image = [
    'assets/images/Subjecttive.png',
    'assets/images/Practice.png',
    'assets/images/Lessionwise.png',
    'assets/images/Special.png',
    'assets/images/Free point.png',
  ];
  final List _image2 = [
    'assets/images/Group Study.png',
    'assets/images/Syllabus.png',
    'assets/images/Classes.png',
  ];
  final List _image3 = [
    'assets/images/Wallet.png',
    'assets/images/Leaderboard.png',
    'assets/images/Reward.png',
  ];
  final List _text = [
    'Subjecttive',
    'Practice',
    'Lessionwise',
    'Special',
    'Free point',
  ];
  final List _text2 = [
    'Group Study',
    'Syllabus',
    'Classes',
  ];
  final List _text3 = [
    'Wallet',
    'Leaderboard',
    'Reward',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "EXAM",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "view all",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            const Divider(thickness: 0.5),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _image.length,
                  itemBuilder: (context, index) {
                    return HomeWiget(
                      ontap: () {
                        Get.to(() => const TermCondition());
                      },
                      image: _image[index],
                      text: _text[index],
                    );
                  }),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "SUGESSTION",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "view all",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            const Divider(thickness: 0.5),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _image2.length,
                  itemBuilder: (context, index) {
                    return HomeWiget(
                      image: _image2[index],
                      text: _text2[index],
                    );
                  }),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "ACTIVITY",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "view all",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            const Divider(thickness: 0.5),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _image3.length,
                  itemBuilder: (context, index) {
                    return HomeWiget(
                      image: _image3[index],
                      text: _text3[index],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

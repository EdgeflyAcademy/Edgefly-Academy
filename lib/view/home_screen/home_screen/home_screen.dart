import 'package:edgefly_academy/view/exam/view/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

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
      appBar: AppBar(
        backgroundColor: const Color(0xFF134668),
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 20),
              child: CircleAvatar(
                child: Image.asset('assets/images/Group Study.png'),
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ABDULLA AL NUMAN",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "LEVEL-3",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        leadingWidth: context.screenWidth * 0.8,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/trophy.png",
                    width: context.screenWidth * 0.09,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/setting.png",
                    width: context.screenWidth * 0.09,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

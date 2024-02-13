import 'package:edgefly_academy/app/auth/view/signin_screen.dart';
import 'package:edgefly_academy/app/suggestion/classes/classes.dart';
import 'package:edgefly_academy/app/suggestion/syllabus/syllabus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../all_subject/view/show_all_subject.dart';
import '../../wallet/user_wallet.dart';
import '../widget/appbar.dart';
import '../widget/home_wiget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      // drawer: const MyDrawer(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CoustomAppbar(),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await FirebaseAuth.instance.signOut();
      //     Get.offAll(() => const SigninScreen());
      //   },
      //   child: const Icon(Icons.logout),
      // ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeWiget(
                  image: "assets/images/Subjecttive.png",
                  text: "Subjecttive",
                  ontap: () {
                    Get.to(() => const SubjectView());
                  },
                ),
                HomeWiget(
                  image: "assets/images/Lessionwise.png",
                  text: "Lessionwise",
                  ontap: () {},
                ),
                HomeWiget(
                  image: "assets/images/Special.png",
                  text: "Special",
                  ontap: () {},
                ),
                HomeWiget(
                  image: "assets/images/Free point.png",
                  text: "Free point",
                  ontap: () {},
                ),
              ],
            ),
            20.heightBox,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "SUGGESTION",
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
                    return InkWell(
                      onTap: () {
                        if (index == 1) {
                          Get.to(SyllabusPage());
                        }
                        if (index == 2) {
                          Get.to(ClassesPage());
                        }
                      },
                      child: HomeWiget(
                        image: _image2[index],
                        text: _text2[index],
                      ),
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
                    return InkWell(
                      onTap: () {
                        if (index == 0) {
                          Get.to(UserWallet());
                        }
                      },
                      child: HomeWiget(
                        image: _image3[index],
                        text: _text3[index],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

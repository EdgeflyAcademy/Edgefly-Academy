import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edgefly_academy/app/exam/view/terms_condition.dart';
import 'package:edgefly_academy/general/common%20widzet/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../general/services/firebase_services.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: Colors.greenAccent.withOpacity(0.8),
          child: StreamBuilder(
            stream: FirestoreServices.getUser(
                FirebaseAuth.instance.currentUser!.uid),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: LoadingIndicator());
              } else {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        child: Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.asset(
                                    "assets/images/learning.png",
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(
                                    data['imageUrl'],
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            5.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data['name']}",
                                    style: const TextStyle(fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  "Level- ${data['level']}"
                                      .text
                                      .size(14)
                                      .make(),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/trophy.png',
                                width: 40,
                              ),
                            ),
                            10.widthBox,
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/setting.png',
                                width: 45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
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
                    return InkWell(
                      onTap: () {},
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

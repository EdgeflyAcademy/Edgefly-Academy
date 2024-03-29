import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../general/services/firebase_services.dart';
import '../../profile/view/profile_screen.dart';
import '../../settings/seetings.dart';

class CoustomAppbar extends StatelessWidget {
  const CoustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent.withOpacity(0.8),
      child: StreamBuilder(
        stream:
            FirestoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
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
                        InkWell(
                          onTap: () {
                            Get.to(() => const ProfileScreen());
                          },
                          child: data['imageUrl'] == ''
                              ? ClipOval(
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.asset(
                                    "assets/images/learning.png",
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    data['imageUrl'],
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        20.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['name']}",
                                style: const TextStyle(fontSize: 20),
                                overflow: TextOverflow.ellipsis,
                              ),
                              "Level- ${data['level']}".text.size(14).make(),
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
                          onPressed: () {
                            Get.to(() => SettingsPage());
                          },
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
    );
  }
}

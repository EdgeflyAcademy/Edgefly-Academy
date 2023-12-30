import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edgefly_academy/view/auth/view/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../services/firebase_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile Screen"),
      ),
      body: StreamBuilder(
        stream:
            FirestoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];

            return SafeArea(
              child: Column(
                children: [
                  //User section and logout section
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 20, bottom: 10),
                    child: Row(
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(
                                "assets/images/learning.png",
                                width: 90,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                            : Image.network(
                                data['imageUrl'],
                                width: 90,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        5.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}".text.make(),
                            "${data['email']}".text.size(10).make(),
                          ],
                        )),
                        //edit button
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                            color: Color(0xFF134668),
                          )),
                          onPressed: () {
                            // controller.nameController.text = data['name'];
                            // Get.to(() => EditProfilescreen(data: data));
                          },
                          child: const Icon(Icons.edit),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF134668),
                        padding: const EdgeInsets.all(18)),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => const SigninScreen());
                    },
                    child: const Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white),
                    ),
                  ).box.rounded.shadow.size(150, 55).make()
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

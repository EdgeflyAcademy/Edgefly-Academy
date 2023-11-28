// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../wellcome_screen/wellcome_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final GoogleSignIn googleSignIn = GoogleSignIn();
            final FirebaseAuth auth = FirebaseAuth.instance;

            // Sign out of Google
            await googleSignIn.signOut();
            print('Signed out of Google');

            // Sign out of Firebase
            await auth.signOut();
            await FirebaseAuth.instance.signOut();
            print('Signed out of Firebase');

            // Navigate to WelcomeScreen
            Get.offAll(() => const WellcomeScreen());
          } catch (e) {
            print('Error: $e');
          }
        },
        child: const Icon(Icons.logout),
      ),
      // body: StreamBuilder(
      //   stream: _usersStream,
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           valueColor: AlwaysStoppedAnimation(Colors.red),
      //         ),
      //       );
      //     } else {
      //       var data = snapshot.data!.docs[0];
      //       return SafeArea(
      //         child: Center(
      //           child: Padding(
      //             padding: const EdgeInsets.all(10.0),
      //             child: Column(
      //               children: [
      //                 SizedBox(
      //                   height: context.screenHeight * 0.1,
      //                 ),
      //                 data['image'] == ''
      //                     ? Image.asset(
      //                         'assets/images/Classes.png',
      //                         width: 90,
      //                         fit: BoxFit.cover,
      //                       )
      //                     : Image.network(
      //                         data['image'],
      //                         width: 90,
      //                         fit: BoxFit.cover,
      //                       ),
      //                 ReusableRow(
      //                     tittle: 'Username',
      //                     icondata: Icons.person_outline,
      //                     value: data['name']),
      //                 ReusableRow(
      //                     tittle: 'Email',
      //                     icondata: Icons.email_outlined,
      //                     value: data['email']),
      //                 ReusableRow(
      //                     tittle: 'Phone',
      //                     icondata: Icons.phone_outlined,
      //                     value: data['phone']),
      //                 ReusableRow(
      //                     tittle: 'Institution',
      //                     icondata: Icons.business_center_outlined,
      //                     value: data['institution']),
      //                 ElevatedButton(
      //                     style: ElevatedButton.styleFrom(
      //                         backgroundColor: const Color(0xFF134668),
      //                         padding: const EdgeInsets.all(10.0)),
      //                     onPressed: () async {
      //                       try {
      //                         final GoogleSignIn googleSignIn = GoogleSignIn();
      //                         final FirebaseAuth auth = FirebaseAuth.instance;

      //                         // Sign out of Google
      //                         await googleSignIn.signOut();
      //                         print('Signed out of Google');

      //                         // Sign out of Firebase
      //                         await auth.signOut();
      //                         await FirebaseAuth.instance.signOut();
      //                         print('Signed out of Firebase');

      //                         // Navigate to WelcomeScreen
      //                         Get.offAll(() => const WellcomeScreen());
      //                       } catch (e) {
      //                         print('Error: $e');
      //                       }
      //                     },
      //                     child: const Text(
      //                       "Log Out",
      //                       style: TextStyle(color: Colors.white),
      //                     )).box.rounded.size(180, 50).make()
      //               ],
      //             ),

      //             // Center(
      //             //   child: Container(
      //             //     decoration: BoxDecoration(
      //             //       shape: BoxShape.circle,
      //             //       border:
      //             //           Border.all(width: 5, color: Colors.grey.shade400),
      //             //     ),
      //             //     height: 120,
      //             //     width: 120,
      //             //     child: ClipRRect(
      //             //       borderRadius: BorderRadius.circular(100),
      //             //       child: Image(
      //             //         fit: BoxFit.cover,
      //             //         image: const NetworkImage(
      //             //             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPzqZlURWLNh-fgMClHn_LCt0yBA126MY21g&usqp=CAU'),
      //             //         loadingBuilder: (context, child, loadingprogress) {
      //             //           if (loadingprogress == null) return child;
      //             //           return const Center(
      //             //             child: CircularProgressIndicator(),
      //             //           );
      //             //         },
      //             //         errorBuilder: (context, object, stack) {
      //             //           return Container(
      //             //             child: const Icon(
      //             //               Icons.error_outline,
      //             //               color: Colors.deepOrangeAccent,
      //             //             ),
      //             //           );
      //             //         },
      //             //       ),
      //             //     ),
      //             // ),
      //             // ),
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String tittle, value;
  final IconData icondata;
  const ReusableRow(
      {super.key,
      required this.tittle,
      required this.icondata,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(tittle),
          leading: Icon(icondata),
          trailing: Text(value),
        ),
      ],
    );
  }
}

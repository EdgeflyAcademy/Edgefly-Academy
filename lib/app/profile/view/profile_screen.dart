import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/user_profile_controller.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Obx(() {
        if (userController.userData.isEmpty) {
          userController.fetchUserData(); // Fetch user data if not available
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage(userController.userData['imageUrl']),
                ),
                SizedBox(height: 20),
                Text(
                  userController.userData['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${userController.userData['about']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                ProfileField(
                    label: 'Email', value: userController.userData['email']),
                ProfileField(
                    label: 'Institution',
                    value: userController.userData['institution']),
                ProfileField(
                    label: 'Category',
                    value: userController.userData['category']),
                ProfileField(
                    label: 'Phone Number',
                    value: userController.userData['phone']),
                ProfileField(
                    label: 'Level', value: userController.userData['level']),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => EditProfileScreen());
          },
          child: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              // Use different colors for different states if needed
              return states.contains(MaterialState.pressed)
                  ? Colors.blueAccent
                  : Colors.blue;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:edgefly_academy/app/auth/view/signin_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../../../general/services/firebase_services.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Profile Screen"),
//       ),
//       body: StreamBuilder(
//         stream:
//             FirestoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
//         builder: (BuildContext context,
//             AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
//               ),
//             );
//           } else {
//             var data = snapshot.data!.docs[0];

//             return SafeArea(
//               child: Column(
//                 children: [
//                   //User section and logout section
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 8, right: 8, top: 20, bottom: 10),
//                     child: Row(
//                       children: [
//                         data['imageUrl'] == ''
//                             ? Image.asset(
//                                 "assets/images/learning.png",
//                                 width: 90,
//                                 fit: BoxFit.cover,
//                               ).box.roundedFull.clip(Clip.antiAlias).make()
//                             : Image.network(
//                                 data['imageUrl'],
//                                 width: 90,
//                                 fit: BoxFit.cover,
//                               ).box.roundedFull.clip(Clip.antiAlias).make(),
//                         5.widthBox,
//                         Expanded(
//                             child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             "${data['name']}".text.make(),
//                             "${data['email']}".text.size(10).make(),
//                           ],
//                         )),
//                         //edit button
//                         OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                               side: const BorderSide(
//                             color: Color(0xFF134668),
//                           )),
//                           onPressed: () {
//                             // controller.nameController.text = data['name'];
//                             // Get.to(() => EditProfilescreen(data: data));
//                           },
//                           child: const Icon(Icons.edit),
//                         )
//                       ],
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF134668),
//                         padding: const EdgeInsets.all(18)),
//                     onPressed: () async {
//                       await FirebaseAuth.instance.signOut();
//                       Get.offAll(() => const SigninScreen());
//                     },
//                     child: const Text(
//                       "Log Out",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ).box.rounded.shadow.size(150, 55).make()
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

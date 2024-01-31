import 'package:edgefly_academy/app/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/home_screen/home_screen/home_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Get.to(() => const HomeScreen());
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Get.to(() => ProfileScreen());
            },
          ),
        ],
      ),
    );
  }
}

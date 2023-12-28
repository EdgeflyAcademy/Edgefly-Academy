import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../profile/view/profile_screen.dart';
import 'home_screen.dart';
import 'notification.dart';
import 'time.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final allpages = [
    const HomeScreen(),
    const Time(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allpages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        iconSize: context.screenWidth * .08,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.grey.shade600,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.grey.shade600,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time_outlined,
              color: Colors.grey.shade600,
            ),
            label: 'Time',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.grey.shade600,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              color: Colors.grey.shade600,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

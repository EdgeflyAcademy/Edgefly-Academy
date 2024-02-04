import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: const Color.fromARGB(255, 197, 157, 157),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            NotificationCard(
              title: 'New Message',
              message: 'You have a new message from Rakibur Rahman.',
              time: '10:30 AM',
              icon: Icons.mail_outline,
              color: Colors.blue,
            ),
            NotificationCard(
              title: 'Exam Reminder',
              message: 'Don\'t forget your sit on exam at 2:00 PM.',
              time: '1:45 PM',
              icon: Icons.event,
              color: Colors.orange,
            ),
            SizedBox(height: 20),
            Text(
              'Yesterday',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            NotificationCard(
              title: 'Payment Received',
              message: 'You received a stiphen of Tk. 50 from Edgefly Academy.',
              time: '5:15 PM',
              icon: Icons.attach_money,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color color;

  NotificationCard({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(message),
        trailing: Text(time),
      ),
    );
  }
}

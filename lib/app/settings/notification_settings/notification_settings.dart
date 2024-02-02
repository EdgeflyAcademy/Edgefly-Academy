import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // Initial values for toggle switches
  bool friendRequestsEnabled = true;
  bool promotionalNotificationsEnabled = true;
  bool transactionNotificationsEnabled = true;
  bool subscriptionNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildToggleSwitch("Friend Requests", friendRequestsEnabled,
                (value) {
              setState(() {
                friendRequestsEnabled = value;
              });
            }),
            buildToggleSwitch(
                "Promotional Notifications", promotionalNotificationsEnabled,
                (value) {
              setState(() {
                promotionalNotificationsEnabled = value;
              });
            }),
            buildToggleSwitch(
                "Transaction Notifications", transactionNotificationsEnabled,
                (value) {
              setState(() {
                transactionNotificationsEnabled = value;
              });
            }),
            buildToggleSwitch(
                "Subscription Notifications", subscriptionNotificationsEnabled,
                (value) {
              setState(() {
                subscriptionNotificationsEnabled = value;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget buildToggleSwitch(String text, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}

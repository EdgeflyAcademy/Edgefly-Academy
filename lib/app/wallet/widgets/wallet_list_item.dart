import 'package:flutter/material.dart';

class WalletListItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData leadingIcon;
  final IconData trailingIcon;

  WalletListItem({
    required this.onTap,
    required this.title,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      leading: Icon(leadingIcon),
      trailing: Icon(trailingIcon),
      // Add more properties as needed
    );
  }
}

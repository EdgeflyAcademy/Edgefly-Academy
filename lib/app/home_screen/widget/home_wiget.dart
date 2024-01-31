import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class HomeWiget extends StatelessWidget {
  final String image;
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  var ontap;
  HomeWiget({super.key, required this.image, required this.text, this.ontap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: IconButton(
            onPressed: ontap,
            icon: Image.asset(image, width: context.screenWidth * 0.09),
          ),
        ),
        Text(text),
      ],
    );
  }
}

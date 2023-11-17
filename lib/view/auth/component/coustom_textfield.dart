import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget coustomtextfield({
  String? title,
  String? hint,
  controller,
  isPass,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(const Color(0xFF134668)).size(18).make(),
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black54,
          ),
          isDense: true,
          fillColor: Colors.black12,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF134668))),
        ),
      ),
      8.heightBox
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget coustomtextfield({
  String? title,
  String? hint,
  controller,
  isPass,
  validator,
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
          border: const OutlineInputBorder(borderSide: BorderSide()),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF134668))),
        ),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
      8.heightBox
    ],
  );
}

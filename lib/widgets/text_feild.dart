import 'package:flutter/material.dart';
import 'package:pos/utls/colors.dart';

getTextFormField(lbl, control, obscure) {
  return TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter $lbl";
      }
      return null;
    },
    controller: control,
    obscureText: obscure,
    decoration: InputDecoration(
      hintText: lbl,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
          )),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

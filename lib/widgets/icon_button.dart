import 'package:flutter/material.dart';
import 'package:pos/utls/colors.dart';

getIconButton(icon, onPressed) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(icon),
    color: AppColors.primaryColor,
  );
}

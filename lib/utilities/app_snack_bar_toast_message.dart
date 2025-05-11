import 'package:flutter/material.dart';

import 'app_color.dart';

class SnackBarToastMessage {
  SnackBarToastMessage._();
  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColor.blueColor,
        duration: const Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        content: Text(message),
      ),
    );
  }
}
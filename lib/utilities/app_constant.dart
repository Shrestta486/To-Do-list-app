

import 'dart:io';

import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_font.dart';

int language = 0;

class AppConstant {
  static const int firstnameLength = 25;
  static const int lastnameLength = 25;
  static const int fullnameLength = 50;
  static const int emailMaxLength = 100;
  static const int mobileLength = 15;
  static const int passwordLength = 16;
  static const int searchLength = 250;
  static const int describeLength = 500;
  static const int otpLength =5;
  static bool isLoggedOut = false;
  static int selectFooterIndex = 0;
  static bool isTutorialShown = false;

  static var deviceType = Platform.isAndroid ? 'android' : 'ios';

  static const TextStyle textFilledStyle = TextStyle(
      color: AppColor.hintTextinputColor,
      fontFamily: AppFont.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 15);

  static const TextStyle textHeadingStyle = TextStyle(
      fontFamily: AppFont.fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 23,
      color: AppColor.primaryColor);

  static const TextStyle textFilledHeading = TextStyle(
      color: AppColor.primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: AppFont.fontFamily);

  static const TextStyle textFilledProfileHeading = TextStyle(
      color: AppColor.primaryColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: AppFont.fontFamily);
}

class ContentClass {
  final String header;
  final String contenttype;

  ContentClass({required this.header, required this.contenttype});
}

enum BottomMenus { home, myBookings, wallet, profile }

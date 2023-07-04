import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

printDebug(String message) {
  if (kDebugMode) debugPrint(message);
}

enum ToastedStates { SUCCESS, ERROR, WARNING }

showToast(
    {required String msg,
      required ToastedStates state,
      ToastGravity gravity = ToastGravity.BOTTOM,
      Toast toastLength = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

Color chooseToastColor(ToastedStates states) {
  Color color;
  switch (states) {
    case ToastedStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastedStates.ERROR:
      color = Colors.red;
      break;
    case ToastedStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
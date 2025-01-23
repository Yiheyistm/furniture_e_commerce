 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showNotification(String message, BuildContext context, Color? color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
      webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
      webPosition: "center",
      webShowClose: true,
    );
  }
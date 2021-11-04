import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

Widget alertBar(BuildContext context, String alertMessage, Color backGroundColor) {
  return Flushbar(
    message: alertMessage, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: backGroundColor,
    duration:  Duration(seconds: 5),
  )..show(context);
}
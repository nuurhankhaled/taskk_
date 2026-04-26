import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void customToast({required String msg, required var color}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16,
    );

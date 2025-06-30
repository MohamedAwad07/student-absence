import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';

class ToastsHelper {
  void success(BuildContext context, String title) {
    CherryToast.success(
      title: Text(
        title,
        style: const TextStyle(
          // fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);
  }

  void info(BuildContext context, String title, String desc) {
    CherryToast.info(
      title: Text(
        title,
        style: const TextStyle(
          // fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      description: Text(
        desc,
        style: const TextStyle(
          // fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);
  }

  void warning(BuildContext context, String description) {
    CherryToast.warning(
      description: Text(
        description,
        style: const TextStyle(
          // fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);
  }

  void error(BuildContext context, String title, String description) {
    CherryToast.error(
      description: Text(
        description,
        textAlign: TextAlign.justify,
        style: TextStyle(
          // fontFamily: fontFamily,
          fontWeight: FontWeight.normal,
          color: Colors.black.withValues(alpha: 0.7),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          // fontFamily: fontFamily,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);
  }
}

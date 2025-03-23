import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showSnackBarWidget({
  required BuildContext context,
  required Color backgroundColor,
  required String text,
  bool? isError,
}) async {
  toastification.show(
    context: context,
    type: isError == true ? ToastificationType.error : ToastificationType.success,
    style: ToastificationStyle.flat,
    // title: Text('Connection Error'),
    description: Text(text),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 4),
    applyBlurEffect: true,
    showProgressBar: false,
  );
}

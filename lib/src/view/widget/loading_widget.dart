import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_communication_prototype/src/core/constants.dart';

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: AppBorderRadius.large,
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoActivityIndicator(
          color: AppColor.lightPrimary,
          radius: 32.0,
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

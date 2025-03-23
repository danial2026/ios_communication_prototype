import 'package:flutter/material.dart';
import 'package:ios_communication_prototype/src/core/constants.dart';

Widget labelTextField({required BuildContext context, required String text}) {
  return Padding(
    padding: const EdgeInsets.only(left: AppPadding.large),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 12,
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget multilineTextView(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: const BoxDecoration(
      borderRadius: AppBorderRadius.large,
    ),
    child: SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  );
}

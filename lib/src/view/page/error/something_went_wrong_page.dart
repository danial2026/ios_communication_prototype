import 'package:flutter/material.dart';

class SomethingWentWrongPage extends StatefulWidget {
  const SomethingWentWrongPage({super.key});

  static const routeName = '/something-went-wrong';

  @override
  State<SomethingWentWrongPage> createState() => _SomethingWentWrongPageState();
}

class _SomethingWentWrongPageState extends State<SomethingWentWrongPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              maxLines: 1,
              textAlign: TextAlign.center,
              'Something Went Wrong Page',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

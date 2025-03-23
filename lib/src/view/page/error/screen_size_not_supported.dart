import 'package:flutter/material.dart';

class ScreenSizeNotSupportedPage extends StatefulWidget {
  const ScreenSizeNotSupportedPage({super.key});

  static const routeName = '/screen-size-not-supported';

  @override
  State<ScreenSizeNotSupportedPage> createState() => _ScreenSizeNotSupportedPageState();
}

class _ScreenSizeNotSupportedPageState extends State<ScreenSizeNotSupportedPage> {
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
              'Screen Size Not Supported',
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

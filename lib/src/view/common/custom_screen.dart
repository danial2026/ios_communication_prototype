import 'package:flutter/material.dart';
import 'package:ios_communication_prototype/src/view/page/error/screen_size_not_supported.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({
    super.key,
    required this.child,
    this.onInit,
    this.onClose,
  });

  final Widget child;
  final VoidCallback? onInit;
  final VoidCallback? onClose;

  @override
  CustomScreenState createState() => CustomScreenState();
}

class CustomScreenState extends State<CustomScreen> {
  @override
  void initState() {
    super.initState();
    if (null != widget.onInit) {
      widget.onInit!();
    }
  }

  @override
  void dispose() {
    if (null != widget.onClose) {
      widget.onClose!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 350 || MediaQuery.of(context).size.height < 660) {
      return const ScreenSizeNotSupportedPage();
    }
    return widget.child;
  }
}

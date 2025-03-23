import 'package:flutter/services.dart';
import 'package:ios_communication_prototype/src/core/constants.dart';
import 'package:universal_io/io.dart' as universal_io;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.appBar,
    this.bottomNavigationBar,
    this.canPop = true,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
  });

  final Widget body;
  final bool canPop;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (bool didPop, value) async {
        if (canPop) {
          return;
        }
        await showDialog<bool>(
          context: context,
          barrierColor: AppColor.popupDialogBarrierColor,
          builder: (context) {
            return AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.doYouWantToExit,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
              shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.xLarge),
              actionsPadding: const EdgeInsets.only(bottom: AppPadding.xxLarge),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Text(
                        AppLocalizations.of(context)!.ok,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        if (universal_io.Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (universal_io.Platform.isIOS) {
                          universal_io.exit(0);
                        }
                      },
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        extendBody: extendBody,
        body: body,
      ),
    );
  }
}

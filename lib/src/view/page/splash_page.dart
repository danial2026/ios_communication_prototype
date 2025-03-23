import 'package:flutter/services.dart';
import 'package:ios_communication_prototype/src/app_preferences/app_preferences_controller.dart';
import 'package:ios_communication_prototype/src/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ios_communication_prototype/src/navigator/navigator_controller.dart';
import 'package:ios_communication_prototype/src/view/common/custom_scaffold.dart';
import 'package:ios_communication_prototype/src/view/common/custom_screen.dart';
import 'package:ios_communication_prototype/src/view/page/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.appPreferencesController});

  final AppPreferencesController appPreferencesController;

  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late String _version = "";

  void _dismissKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void _initPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = 'version ${packageInfo.version} + ${packageInfo.buildNumber}';
    });
  }

  @override
  void initState() {
    super.initState();
    _dismissKeyboard();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.appPreferencesController.getThemeData();

    return CustomScreen(
      onInit: () {
        Future.delayed(const Duration(seconds: 2)).then((value) async {
          NavigatorController.pushReplacementWithoutState(context, HomePage.routeName);
        });
      },
      child: CustomScaffold(
        canPop: false,
        backgroundColor: theme.colorScheme.surface,
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // App logo and name
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App icon
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.large,
                      boxShadow: [
                        BoxShadow(
                          color: theme.shadowColor.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: AppBorderRadius.large,
                      child: Image.asset(
                        AppIcon.appIcon,
                        width: 160,
                        height: 160,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // App name
                  Text(
                    AppLocalizations.of(context)!.appName,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    AppLocalizations.of(context)!.appDescription,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Version info at the bottom
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05,
              child: Text(
                maxLines: 1,
                textAlign: TextAlign.center,
                _version,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary.withOpacity(0.6),
                ),
              ),
            ),

            // Loading indicator
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_communication_prototype/src/app_preferences/app_preferences_controller.dart';
import 'package:ios_communication_prototype/src/bloc/ios_communication/ios_communication_bloc.dart';
import 'package:ios_communication_prototype/src/core/constants.dart';
import 'package:ios_communication_prototype/src/view/common/custom_scaffold.dart';
import 'package:ios_communication_prototype/src/view/common/custom_screen.dart';
import 'package:ios_communication_prototype/src/view/widget/loading_widget.dart';
import 'package:ios_communication_prototype/src/view/widget/snackbar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.appPreferencesController});

  static const routeName = '/home';

  final AppPreferencesController appPreferencesController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isInitialLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Start the iOS communication when the page loads
    Future.microtask(() {
      final iosCommunicationBloc = BlocProvider.of<IosCommunicationBloc>(context);
      iosCommunicationBloc.startRandomIntPerSecond();
    });
  }

  @override
  void dispose() {
    // Stop the iOS communication when the page is disposed
    final iosCommunicationBloc = BlocProvider.of<IosCommunicationBloc>(context);
    iosCommunicationBloc.stopRandomIntPerSecond();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iosCommunicationBloc = BlocProvider.of<IosCommunicationBloc>(context);
    final theme = widget.appPreferencesController.getThemeData();
    final localizations = AppLocalizations.of(context)!;

    return CustomScreen(
      child: CustomScaffold(
        canPop: false,
        body: BlocConsumer<IosCommunicationBloc, IosCommunicationState>(
          bloc: iosCommunicationBloc,
          listener: (context, state) {
            if (state is IosCommunicationInProgress && _isInitialLoading) {
              showLoaderDialog(context);
            } else if (state is IosCommunicationListening || state is IosCommunicationSuccess) {
              if (_isInitialLoading) {
                _isInitialLoading = false;
                Navigator.of(context, rootNavigator: true).pop();
              }
              _animationController.forward();
            } else if (state is IosCommunicationFailure) {
              if (_isInitialLoading) {
                _isInitialLoading = false;
                Navigator.of(context, rootNavigator: true).pop();
              }
              showSnackBarWidget(
                context: context,
                backgroundColor: theme.colorScheme.surface,
                text: state.error.toString(),
                isError: true,
              );
            }
          },
          builder: (context, state) => Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width < 680 ? MediaQuery.of(context).size.width : 680,
              ),
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.xLarge),
                    children: [
                      const SizedBox(height: AppPadding.xxxLarge),
                      FadeTransition(
                        opacity: _animationController,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              localizations.appName,
                              style: theme.textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppPadding.xLarge),
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeOut,
                        )),
                        child: FadeTransition(
                          opacity: _animationController,
                          child: Container(
                            padding: const EdgeInsets.all(AppPadding.large),
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.large,
                              boxShadow: [
                                BoxShadow(
                                  color: theme.shadowColor.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localizations.iosCommunication,
                                  style: theme.textTheme.titleLarge,
                                ),
                                const SizedBox(height: AppPadding.small),
                                Text(
                                  localizations.randomIntegersDescription,
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: AppPadding.medium),
                                const Divider(),
                                const SizedBox(height: AppPadding.medium),
                                _buildRandomIntDisplay(state),
                                const SizedBox(height: AppPadding.large),
                                Center(
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.colorScheme.surface,
                                      foregroundColor: theme.colorScheme.onPrimary,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppPadding.large,
                                        vertical: AppPadding.medium,
                                      ),
                                      minimumSize: const Size(200, 50),
                                      side: BorderSide(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (state is IosCommunicationListening || state is IosCommunicationSuccess) {
                                        iosCommunicationBloc.stopRandomIntPerSecond();
                                      } else {
                                        iosCommunicationBloc.startRandomIntPerSecond();
                                      }
                                    },
                                    icon: Icon(
                                      (state is IosCommunicationListening || state is IosCommunicationSuccess)
                                          ? Icons.stop_circle
                                          : Icons.play_circle,
                                    ),
                                    label: Text(
                                      (state is IosCommunicationListening || state is IosCommunicationSuccess)
                                          ? localizations.stopRandomIntGenerator
                                          : localizations.startRandomIntGenerator,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRandomIntDisplay(IosCommunicationState state) {
    final theme = widget.appPreferencesController.getThemeData();
    final localizations = AppLocalizations.of(context)!;

    if (state is IosCommunicationSuccess) {
      final timeString = DateTime.fromMillisecondsSinceEpoch(state.item.timestamp).toString();
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(AppPadding.large),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.2),
          borderRadius: AppBorderRadius.medium,
          border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.numbers),
                const SizedBox(width: AppPadding.small),
                Text(
                  localizations.randomNumber,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppPadding.medium),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.large,
                  vertical: AppPadding.medium,
                ),
                child: Text(
                  "${state.item.randomInt}",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppPadding.medium),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: AppPadding.small),
                Expanded(
                  child: Text(
                    timeString,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (state is IosCommunicationFailure) {
      return Container(
        padding: const EdgeInsets.all(AppPadding.large),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer.withOpacity(0.2),
          borderRadius: AppBorderRadius.medium,
          border: Border.all(color: theme.colorScheme.error.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error, color: theme.colorScheme.error),
                const SizedBox(width: AppPadding.small),
                Text(
                  localizations.error,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppPadding.medium),
            Text(
              "${state.error}",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      );
    } else if (state is IosCommunicationListening) {
      return Container(
        padding: const EdgeInsets.all(AppPadding.large),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.2),
          borderRadius: AppBorderRadius.medium,
          border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.sync),
                const SizedBox(width: AppPadding.small),
                Text(
                  localizations.waitingForData,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppPadding.large),
            const CircularProgressIndicator(),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(AppPadding.large),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.2),
          borderRadius: AppBorderRadius.medium,
          border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.pending),
                const SizedBox(width: AppPadding.small),
                Text(
                  localizations.waitingToStart,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppPadding.large),
            Text(
              localizations.pressButtonToStart,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }
}

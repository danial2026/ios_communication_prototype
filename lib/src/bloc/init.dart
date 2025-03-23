import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_communication_prototype/src/bloc/custom_bloc_observer.dart';
import 'package:ios_communication_prototype/src/bloc/ios_communication/ios_communication_bloc.dart';

Future<void> initBlocObserverAndStorage() async {
  Bloc.observer = CustomBlocObserver();
}

List<BlocProvider> provideBlocList() {
  return [
    BlocProvider<IosCommunicationBloc>(
      create: (BuildContext context) => IosCommunicationBloc(),
    ),
  ];
}

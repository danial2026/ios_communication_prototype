import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_communication_prototype/src/bloc/ios_communication/ios_communication_response_model.dart';
import 'package:ios_communication_prototype/src/bloc/custom_bloc_event.dart';
import 'package:ios_communication_prototype/src/bloc/custom_bloc_exception.dart';
import 'package:ios_communication_prototype/src/bloc/custom_bloc_state.dart';
import 'package:ios_communication_prototype/src/helpers/logger/logger_helper.dart';

class IosCommunicationBloc extends _IosCommunicationBloc {
  IosCommunicationBloc() : super();
}

abstract class _IosCommunicationBloc extends Bloc<IosCommunicationEvent, IosCommunicationState> {
  _IosCommunicationBloc() : super(const IosCommunicationInitial()) {
    on<_IosCommunicationStartRequested>(_mapStartRequestedToState);
    on<_IosCommunicationStopRequested>(_mapStopRequestedToState);
    on<_IosCommunicationDataReceived>(_mapDataReceivedToState);
  }

  // Platform channel for communication with iOS
  static const MethodChannel _methodChannel = MethodChannel('com.zanis.ios_communication/method');
  static const EventChannel _eventChannel = EventChannel('com.zanis.ios_communication/event');

  StreamSubscription? _eventSubscription;

  Future<void> _mapStartRequestedToState(_IosCommunicationStartRequested event, Emitter<IosCommunicationState> emit) async {
    emit(const IosCommunicationInProgress());

    try {
      // Call the iOS method to start generating random numbers
      await _methodChannel.invokeMethod('startRandomIntPerSecond');

      // Listen for events from iOS
      _eventSubscription = _eventChannel.receiveBroadcastStream().listen(
        (dynamic event) {
          if (event is Map) {
            // Convert the received map to IosCommunicationResponseModel
            final response = IosCommunicationResponseModel(
              randomInt: event['randomInt'] as int,
              timestamp: event['timestamp'] as int,
            );

            // Add the received data event
            add(_IosCommunicationDataReceived(response: response));
          }
        },
        onError: (dynamic error) {
          LoggerHelper.debugLog('Error from event channel: $error');
          emit(IosCommunicationFailure(error: CustomBlocException(error.toString())));
        },
      );

      emit(const IosCommunicationListening());
    } catch (e) {
      LoggerHelper.debugLog('Failed to start random int generation: $e');
      emit(IosCommunicationFailure(error: CustomBlocException(e.toString())));
    }
  }

  Future<void> _mapStopRequestedToState(_IosCommunicationStopRequested event, Emitter<IosCommunicationState> emit) async {
    try {
      // Cancel event subscription
      await _eventSubscription?.cancel();
      _eventSubscription = null;

      // Call the iOS method to stop generating random numbers
      await _methodChannel.invokeMethod('stopRandomIntPerSecond');

      emit(const IosCommunicationStopped());
    } catch (e) {
      LoggerHelper.debugLog('Failed to stop random int generation: $e');
      emit(IosCommunicationFailure(error: CustomBlocException(e.toString())));
    }
  }

  void _mapDataReceivedToState(_IosCommunicationDataReceived event, Emitter<IosCommunicationState> emit) {
    emit(IosCommunicationSuccess(item: event.response));
  }

  @override
  Future<void> close() {
    _eventSubscription?.cancel();
    return super.close();
  }

  void startRandomIntPerSecond() => add(_IosCommunicationStartRequested());

  void stopRandomIntPerSecond() => add(_IosCommunicationStopRequested());
}

// Events
abstract class IosCommunicationEvent extends CustomBlocEvent {
  const IosCommunicationEvent();
}

class _IosCommunicationStartRequested extends IosCommunicationEvent {
  const _IosCommunicationStartRequested();
}

class _IosCommunicationStopRequested extends IosCommunicationEvent {
  const _IosCommunicationStopRequested();
}

class _IosCommunicationDataReceived extends IosCommunicationEvent {
  const _IosCommunicationDataReceived({required this.response});

  final IosCommunicationResponseModel response;
}

// States
abstract class IosCommunicationState extends CustomBlocState {
  const IosCommunicationState({required Status status}) : super(status: status);
}

class IosCommunicationInitial extends IosCommunicationState {
  const IosCommunicationInitial() : super(status: Status.Initial);

  @override
  String toString() => 'IosCommunicationInitial';
}

class IosCommunicationInProgress extends IosCommunicationState {
  const IosCommunicationInProgress() : super(status: Status.InProgress);

  @override
  String toString() => 'IosCommunicationInProgress';
}

class IosCommunicationListening extends IosCommunicationState {
  const IosCommunicationListening() : super(status: Status.Success);

  @override
  String toString() => 'IosCommunicationListening';
}

class IosCommunicationSuccess extends IosCommunicationState {
  const IosCommunicationSuccess({required this.item}) : super(status: Status.Success);

  final IosCommunicationResponseModel item;

  @override
  String toString() => 'IosCommunicationSuccess';
}

class IosCommunicationStopped extends IosCommunicationState {
  const IosCommunicationStopped() : super(status: Status.Success);

  @override
  String toString() => 'IosCommunicationStopped';
}

class IosCommunicationFailure extends IosCommunicationState {
  const IosCommunicationFailure({this.error}) : super(status: Status.Failure);

  final CustomBlocException? error;
}

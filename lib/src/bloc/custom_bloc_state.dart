import 'package:meta/meta.dart';

@immutable
abstract class CustomBlocState {
  const CustomBlocState({this.status});

  final Status? status;
}

enum Status {
  Initial,
  InProgress,
  Success,
  Failure,
}

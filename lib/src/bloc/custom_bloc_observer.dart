import 'package:bloc/bloc.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    var _out = '----------------EVENT-------------------\n';
    _out += '${transition.event}\n';
    _out += '----------------STATE-------------------\n';
    _out += '${transition.currentState}\n';
    _out += '╚> ${transition.nextState}';
    print(_out);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

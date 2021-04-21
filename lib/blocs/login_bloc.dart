import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerente_loja/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with LoginValidators {
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPass => _passController.stream.transform(validadePass);
  Stream<bool> get outSubmittedValid => Rx.combineLatest2(outEmail, outPass,
     (a, b) => a != null && b != null) ; // combine only emits if all stream have already emitted on value each

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;

  @override
  void dispose() {
    _emailController.close();
    _passController.close();
    super.dispose();
  }
}
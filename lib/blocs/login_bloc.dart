import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerente_loja/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState {IDLE, LOADING, SUCCESS, FAIL}

class LoginBloc extends BlocBase with LoginValidators {
  final _emailController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPass => _passController.stream.transform(validadePass);
  // combine only emits if all streams have already emitted at least one value each
  Stream<bool> get outSubmittedValid => Rx.combineLatest2(outEmail, outPass,
     (a, b) => a != null && b != null
  );
  Stream<LoginState> get outState => _stateController.stream;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;

  LoginBloc() {
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {
      if(firebaseUser != null) {
        print('logou!');
        FirebaseAuth.instance.signOut();
      } else {

        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submit() {
    final email = _emailController.value;
    final pass = _passController.value;
    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, password: pass
    ).catchError( (e) {
      _stateController.add(LoginState.FAIL);
    });
  }

  @override
  void dispose() {
    _emailController.close();
    _passController.close();
    _stateController.close();
    
    super.dispose();
  }
}
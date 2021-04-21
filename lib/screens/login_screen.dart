import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/login_bloc.dart';
import 'package:gerente_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// stateful because the screen will change with opening and closing the keyboard
class _LoginScreenState extends State<LoginScreen> {

  final LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack( // center child, but needed an empty container as its child
        alignment: Alignment.center,
        children: [
          Container(),
          SingleChildScrollView(
            child: Container( // just to set margins
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.store_mall_directory,
                    color: Colors.pinkAccent,
                    size: 160
                  ),
                  InputField(icon: Icons.person_outline,
                    obscure: false,
                    label: 'Usuário (a)',
                    stream: _loginBloc.outEmail,
                    onChanged: _loginBloc.changeEmail,
                  ),
                  InputField(icon: Icons.person_outline,
                    obscure: true,
                    label: 'Senha',
                    stream: _loginBloc.outPass,
                    onChanged: _loginBloc.changePass,
                  ),
                  SizedBox(height: 32), // space between column's items
                  StreamBuilder<bool>(
                    stream: _loginBloc.outSubmittedValid,
                    builder: (context, snapshot) {
                      return SizedBox( // just to set the button's height
                        child: ElevatedButton(
                          child: Text('Entrar'),
                          onPressed: snapshot.hasData ? () {} : null,
                          style: ElevatedButton.styleFrom(
                            onSurface: Colors.pinkAccent.withAlpha(140), // disabled color
                            primary: Colors.pinkAccent,
                            //onPrimary: Colors.grey[850],
                          )
                        ),
                        height: 50,
                      );
                    }
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            )
          ),
        ],
      ) // scrollable content
    );
  }
}



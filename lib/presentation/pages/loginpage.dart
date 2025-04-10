
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/authmodel.dart';
import '../bloc/authBloc/authbloc_bloc.dart';
import '../shared_widgets/authWidgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final AuthWidgets _authWidgets = AuthWidgets();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return BlocListener<AuthblocBloc, AuthblocState>(
    listener: (context, state) {
      if(state is AuthFailed){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
      else if(state is AuthSuccess){
        Navigator.pushNamed(context, '/homePage');
      }
    },
      child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Welcome', style: TextStyle(fontSize: 50),),
              _authWidgets.authFields('Email', false, _emailController),
              _authWidgets.authFields('Password', true,_passwordController),
              _authWidgets.authButton(sW, sH,'Login',() {
                if (_formKey.currentState?.validate() ?? false) {
                  AuthModel userInfo = AuthModel(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim());
                  context.read<AuthblocBloc>().add(
                      LoginUser(authModel: userInfo));
                }
              }),
              InkWell(
                child: Text('Register'),
                onTap: () => Navigator.pushNamed(context, '/registerPage'),
              )
            ],
          )
        ),
      ),
    ),
    );
  }
}

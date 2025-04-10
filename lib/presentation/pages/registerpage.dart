import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagementevolve/data/model/authmodel.dart';

import '../bloc/authBloc/authbloc_bloc.dart';
import '../shared_widgets/authWidgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Register', style: TextStyle(fontSize: 50),),
              _authWidgets.authFields('Email', false, _emailController),
              _authWidgets.authFields('Password', true, _passwordController),
              _authWidgets.authButton(sW, sH,'register',() {
                if (_formKey.currentState?.validate() ?? false) {
                  AuthModel userInfo = AuthModel(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim());
                  context.read<AuthblocBloc>().add(
                      LoginUser(authModel: userInfo));
                }
              }),
            ],
          )
        ),
      ),
    );
  }
}

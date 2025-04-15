import 'package:flutter/material.dart';

class ProfileWidgets {
  final _formKey = GlobalKey<FormState>();
  String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  Future<void> createUserDialog(nameControl, emailControl, context, titleString,
      VoidCallback event) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleString),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  customField('name',false, nameControl),
                  customField('email',false,emailControl)
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  event();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget customField(text, bool obscure, control) {
    return TextFormField(
      controller: control,
      obscureText: obscure,
      decoration: InputDecoration(
          hintText: text,
      ),
      validator: (value) {
        final trimmedValue = value?.trim();
        if (trimmedValue == null || trimmedValue.isEmpty) {
          return 'Fill the field';
        }
        if (text.toLowerCase() == 'email') {
          if (!RegExp(emailRegex).hasMatch(trimmedValue)) {
            return 'Enter a valid email';
          }
        }
        return null;
      },
    );
  }
}
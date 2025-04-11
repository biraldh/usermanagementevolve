
import 'package:flutter/material.dart';

class AuthWidgets{
  String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  Widget authFields(text, bool obscure, control){
    return TextFormField(
      controller: control,
      obscureText: obscure,
      decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder()
      ),
      validator: (value){
        final trimmedValue = value?.trim();
        if(trimmedValue == null || trimmedValue.isEmpty){
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
  Widget authButton(sW, sH, text, VoidCallback event){
    return InkWell(
      onTap: event,
      child: Container(
        width: sW/1,
        height: sH/12,
        decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}
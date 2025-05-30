import 'package:flutter/material.dart';

class HomeWidgets{
  final _formKey = GlobalKey<FormState>();
  Widget cardList(driverInfo){
    return Card(
      elevation: 0,
      color: Colors.blue[50],
      child: ListTile(
      title: Text('${driverInfo.firstName} ${driverInfo.lastName}'),
      subtitle: Text(driverInfo.email),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(driverInfo.avatar)),
      ),
    );
  }
  Future<void> createUserDialog(nameControl,jobControl,context,VoidCallback event){
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create user'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  formTextFields(nameControl, 'name'),
                  formTextFields(jobControl, 'email')
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
  Widget formTextFields(controller, String hintText){
    return TextFormField(
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Fill the field';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
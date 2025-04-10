import 'dart:convert';

import '../model/authmodel.dart';

import 'package:http/http.dart' as http;
class AuthRepo{
  Future<String> loginUser(AuthModel user)async {
    try{
      final response = await http.post(Uri.parse('https://reqres.in/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}),
      );
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        if(jsonResponse.containsKey('token')){
          return jsonResponse['token'];
        } else {
          throw Exception('invalid credentials');
        }
      }
      else{
        throw Exception('Something went wrong');
      }
    }
    catch(e){
      throw Exception('invalid credentials');
    }
  }
}
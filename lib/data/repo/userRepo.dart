import 'dart:convert';

import 'package:usermanagementevolve/data/model/usermodel.dart';

import 'package:http/http.dart' as http;

class UserRepo{
  Future<List<UserModel>> getUserList() async {
    print('sdfsdfsdf');
    try{
      final response = await http.get(Uri.parse('https://reqres.in/api/users'));
      var jsonResponse = json.decode(response.body);
      List users = jsonResponse['data'];
      return users.map((json) => UserModel.fromJson(json)).toList();
    }
    catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
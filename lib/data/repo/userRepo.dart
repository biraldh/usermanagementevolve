import 'dart:convert';

import 'package:usermanagementevolve/data/model/usermodel.dart';

import 'package:http/http.dart' as http;

import '../model/createmodel.dart';

class UserRepo{
  Future<List<UserModel>> getUserList() async {
    try{
      final response = await http.get(Uri.parse('https://reqres.in/api/users'));
      var jsonResponse = json.decode(response.body);
      List users = jsonResponse['data'];
      return users.map((json) => UserModel.fromJson(json)).toList();
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
  Future<String> createUser(CreateJobModel cjm) async {
    try{
      return 'success';
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
  Future<String> deleteUser(id) async {
    try{
      return 'success';
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
  Future<String> updateUser(CreateJobModel cjm) async {
    try{
      return 'success';
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  Future<UserModel> getUser(id) async {
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users/$id'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final userJson = jsonResponse['data'];
        return UserModel.fromJson(userJson);
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {

      throw Exception(e.toString());
    }
  }
}
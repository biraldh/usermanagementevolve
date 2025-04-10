import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usermanagementevolve/presentation/pages/homepage.dart';
import 'package:usermanagementevolve/presentation/pages/loginpage.dart';
import 'package:usermanagementevolve/presentation/pages/registerpage.dart';

class RouteGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/registerPage':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/loginPage':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/homePage':
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
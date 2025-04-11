import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagementevolve/presentation/bloc/authBloc/authbloc_bloc.dart';
import 'package:usermanagementevolve/presentation/bloc/crudbloc/crud_bloc.dart';
import 'package:usermanagementevolve/presentation/bloc/profliebloc/profile_bloc.dart';
import 'package:usermanagementevolve/presentation/bloc/userboc/user_bloc.dart';
import 'package:usermanagementevolve/presentation/pages/loginpage.dart';
import 'package:usermanagementevolve/routes.dart';

import 'data/repo/authRepo.dart';
import 'data/repo/userRepo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthblocBloc>(
          create:(context) => AuthblocBloc(AuthRepo()),
        ),
        BlocProvider<UserBloc>(
          create:(context) => UserBloc(UserRepo()),
        ),
        BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(UserRepo())
        ),
        BlocProvider<CrudBloc>(
            create: (context) => CrudBloc(UserRepo())
        ),
      ],
      child: MaterialApp(
        title: 'User Management',
        onGenerateRoute: RouteGen.generateRoute,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}

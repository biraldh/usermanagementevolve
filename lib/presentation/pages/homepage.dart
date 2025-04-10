
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagementevolve/presentation/bloc/userboc/user_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    context.read<UserBloc>().add(GetUsers());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state){
          if(state is UserLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is UserSuccess){
            var userList = state.userData.toList();
            return ListView.builder(
              itemCount:  userList.length,
              itemBuilder: (context, index){
                var driverInfo = userList[index];
                return Card(
                  child: ListTile(
                    title: Text('${driverInfo.firstName} ${driverInfo.lastName}'),
                    subtitle: Text(driverInfo.email),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                        child: Image.network(driverInfo.avatar)),
                  ),
                );
              }
            );
          }
          else if(state is UserFailed){
            Text(state.errMessage);
          }
          return Text("Something went wrong");
        }
      ),
    );
  }
}

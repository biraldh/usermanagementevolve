import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagementevolve/presentation/bloc/profliebloc/profile_bloc.dart';
import 'package:usermanagementevolve/presentation/shared_widgets/profileWidgets.dart';

import '../../data/model/usermodel.dart';
import '../bloc/crudbloc/crud_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String id;
  const ProfilePage({
    required this.id,
    super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileWidgets _profileWidgets = ProfileWidgets();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetSingleUser(id: widget.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return BlocListener<CrudBloc, CrudState>(
      listener: (context, state) {
        if(state is CrudDeleteSuccess){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("User deleted successfully!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.popAndPushNamed(context, '/homePage');
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }else if(state is CrudFailed){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Unsuccessful"),
                content: Text("Unsuccessful!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
        else if(state is CrudUpdateSuccess){
          _nameController.clear();
          _emailController.clear();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("User updated successfully!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Scaffold(
      appBar: AppBar(title: Text('Profile'),),
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state){
        if(state is ProfileFailed){
          return Text(state.errMessage);
        }
        else if(state is ProfileLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(state is GetProfileSuccess){
          var user = state.user;
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${user.firstName} ${user.lastName}', style: TextStyle(fontSize: 50),),
                    SizedBox(height: sH/3,
                      child: ClipRRect(
                          child: Image.network(
                            user.avatar,
                            fit: BoxFit.fill,)
                      ),
                    ),
                    Text(user.email, style: TextStyle(fontSize: 30),),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () => _profileWidgets.createUserDialog(
                          _nameController,
                          _emailController,
                          context,
                          'Edit user',
                              (){
                                final fullName = _nameController.text.trim();
                                final parts = fullName.split(' ');
                                final firstName = parts.isNotEmpty ? parts.first : '';
                                final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

                                UserModel data = UserModel(
                                    id: int.parse(widget.id),
                                    email: _emailController.text.trim(),
                                    firstName: firstName,
                                    lastName: lastName,
                                    avatar: user.avatar

                                );
                          context.read<CrudBloc>().add(EditUser(modified: data));
                      }),
                      child: Container(
                        width: sW/1,
                        height: sH/15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          color: Colors.blue[50]
                        ),
                        child: Center(child: Text('edit user', style: TextStyle(fontSize: 30),))),
                    ),
                    SizedBox(height: sH/5),
                    InkWell(
                      onTap: () => context.read<CrudBloc>().add(DeleteUser(id: widget.id)),
                      child: Container(
                        width: sW/1,
                        height: sH/15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red
                        ),
                          child: Center(child: Text('delete user'))),
                    ),
                  ],
                ),
              );
            }
          );
        }
        return Center(child: Text('Something went wrong'));
      })
    ),
  );
  }
}

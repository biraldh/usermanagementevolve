import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagementevolve/presentation/bloc/userboc/user_bloc.dart';
import 'package:usermanagementevolve/presentation/shared_widgets/homeWidgets.dart';

import '../../data/model/createmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeWidgets _homeWidgets = HomeWidgets();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  String searchText = '';

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<UserBloc>().add(GetUsers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailed) {
          _nameController.clear();
          _jobController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is UserCreatedSuccess) {
          _nameController.clear();
          _jobController.clear();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Success"),
                content: Text("User created successfully!"),
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("User Management"),
          actions: [
            IconButton(
              onPressed: () => _homeWidgets.createUserDialog(
                _nameController,
                _jobController,
                context,
                    () {
                  CreateJobModel data = CreateJobModel(
                    job: _nameController.text.trim(),
                    name: _jobController.text.trim(),
                  );
                  context.read<UserBloc>().add(CreateUser(user: data));
                },
              ),
              icon: Icon(Icons.add),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: sW / 1,
                height: sH / 15,
                child: SearchBar(
                  onChanged: (value) {
                    searchText = value;
                  },
                  hintText: 'Search',
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all(Colors.blue[50]),
                ),
              ),
              SizedBox(height: sH / 15),
              Flexible(
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is UserSuccess) {
                      var userList = state.userData.toList();
                      var filteredList = searchText.isEmpty
                          ? userList
                          : userList.where((user) => user.firstName
                          .toLowerCase()
                          .startsWith(searchText.toLowerCase())).toList();
                      return ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          var driverInfo = filteredList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/profilePage',
                                arguments: {'id': driverInfo.id.toString()},
                              );
                              context.read<UserBloc>().add(GetUsers());
                            },
                            child: _homeWidgets.cardList(driverInfo),
                          );
                        },
                      );
                    } else if (state is UserFailed) {
                      return Text(state.errMessage);
                    }
                    return Center(child: Text("Something went wrong"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

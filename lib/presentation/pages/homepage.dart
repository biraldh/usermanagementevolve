
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usermanagementevolve/presentation/bloc/userboc/user_bloc.dart';
import 'package:usermanagementevolve/presentation/shared_widgets/homeWidgets.dart';

import '../shared_widgets/homeWidgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeWidgets _homeWidgets = HomeWidgets();
  String searchText = '';
  @override
  void initState() {
    context.read<UserBloc>().add(GetUsers());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
       automaticallyImplyLeading: false,
        title: Text("User Management"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: sW/1,
              height: sH/15,
              child: SearchBar(
                onChanged: (value) {
                  searchText = value;
                },
                hintText: 'Search',
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(Colors.blue[50]),
              )),
            SizedBox(height: sH/15,),
            Flexible(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state){
                    if(state is UserLoading){
                      return Center(child: CircularProgressIndicator());
                    }
                    else if(state is UserSuccess){
                      var userList = state.userData.toList();
                      var filteredList = searchText.isEmpty
                          ? userList
                          : userList.where((user) => user.firstName
                          .toLowerCase()
                          .startsWith(searchText.toLowerCase())).toList();
                      return ListView.builder(
                        itemCount:  filteredList.length,
                        itemBuilder: (context, index){
                          var driverInfo = filteredList[index];
                          return _homeWidgets.cardList(driverInfo);
                        }
                      );
                    }
                    else if(state is UserFailed){
                      Text(state.errMessage);
                    }
                    return Text("Something went wrong");
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

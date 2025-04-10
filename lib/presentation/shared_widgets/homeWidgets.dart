import 'package:flutter/material.dart';

class HomeWidgets{
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
}
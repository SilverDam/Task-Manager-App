import 'package:budget_app/config/colors.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      backgroundColor: lightColor,
      body: Center(child: Text('Taskmanger'),)
       );
  }
}
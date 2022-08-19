
import 'package:budget_app/config/colors.dart';
import 'package:flutter/material.dart';
class ChatScreen extends StatelessWidget {
  
  
  const ChatScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: lightColor,
      body: Center(child: Text('Chatcreen'),),
    );
  }
}
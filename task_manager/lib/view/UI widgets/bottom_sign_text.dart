



// ignore_for_file: use_key_in_widget_constructors


import 'package:budget_app/config/colors.dart';
import 'package:budget_app/config/text.dart';
import 'package:budget_app/view/login_screen.dart';
import 'package:budget_app/view/multipage_signup/selectimage_signup.dart';
import 'package:flutter/material.dart.';




class BottomAction extends StatefulWidget {

  final Text btmText;
   final Text btmActn; 
   final bool  isSignUp;
  

const  BottomAction(this.btmText, this.btmActn, this.isSignUp);

  @override
  State<BottomAction> createState() => _BottomActionState();
}

class _BottomActionState extends State<BottomAction> {
  @override
  Widget build(BuildContext context) {
    return Row(
       mainAxisAlignment:  MainAxisAlignment.center,
      
      children: [

      widget.btmText,

      const SizedBox(width: 10,),

     GestureDetector (
       
        onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.isSignUp ? const LoginScreen() : const ImageSelection()));
        },
       
      
       child: Container( width: 100 , child: widget.btmActn)),


        
    ],);
  }

 
}



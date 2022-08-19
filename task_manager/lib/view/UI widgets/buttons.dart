// ignore_for_file: use_key_in_widget_constructors

import 'package:budget_app/config/colors.dart';

import 'package:flutter/material.dart';


class Button extends StatelessWidget {
   final  Widget buttonLabel;
   final Icon? icons;


   const Button(this.buttonLabel, this.icons);

  @override
  Widget build(BuildContext context) {
    return  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: primColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: 70,
                    width:  double.infinity,
                 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:   [
                       buttonLabel,
                       Container(child: icons)
                      ],
                    ),
           );
  }
}


// next button widget


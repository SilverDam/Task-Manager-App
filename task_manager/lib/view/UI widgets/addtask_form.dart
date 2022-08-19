
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddTaskForm extends StatelessWidget {
  final String? hint;
  final Widget? iconWidget;
  bool isDes = true;
  String? status;
  TextEditingController? textcontroller;
  bool isPassword;
  AddTaskForm(this.hint, this.iconWidget, this.isDes, this.status,
      this.textcontroller, this.isPassword,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return


        iconWidget == null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: TextFormField(
                      obscureText: isPassword == true ? true : false,
                      onChanged: (val) {
                        textcontroller!.text = val;
                      },
                      maxLines: isDes ? 10 : 1,
                    
                      decoration: InputDecoration(
                        labelText: hint,

                    
                      )),
                ),
               
              )
            : Container(
    
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: textcontroller,
                          readOnly: true,
                          maxLines: isDes ? 10 : 1,
                          maxLength: isDes ? 500 : null,
                          autofocus: false,
                          obscureText: isPassword == true ? true : false,
                          decoration: InputDecoration(
                              labelText: hint, suffixIcon: iconWidget
                          
                              )),
                    ),
                  ],
                ),
            
              );
  }
}

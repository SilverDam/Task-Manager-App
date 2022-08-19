import 'package:budget_app/config/utils.dart';
import 'package:budget_app/resources/auth_method.dart';
import 'package:budget_app/view/approot.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors.dart';
import '../config/text.dart';
import 'UI widgets/addtask_form.dart';
import 'UI widgets/bottom_sign_text.dart';
import 'UI widgets/buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController;
    _passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkgrColor,
      body: SafeArea(child: SingleChildScrollView(child: getBody())),
    );
  }

  Widget getBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 100),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

      Text('Hi, \nWelcome back!', style: latoheading1, textAlign: TextAlign.center,),

      const SizedBox(
          height: 40,
        ),

        AddTaskForm('Email', null, false, null, _emailController, false),
        const SizedBox(
          height: 40,
        ),
        AddTaskForm('password', null, false, null, _passwordController, true),
        const SizedBox(
          height: 40,
        ),
        InkWell(

          onTap:  loginUser,
          child: Button(
           isLoading ? const CircularProgressIndicator( color: lightColor,) :   Text(
                'Login',
                style: lightlatobody,
              ),
              null),
        ),
        const SizedBox(
          height: 40,
        ),
      
            Row(

              children: [
                const SizedBox(width: 50,),
                BottomAction(
                    Text(
                      "Don't have an account?",
                      style: latobody,
                    ),
                    Text("SignUp",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    false),
              ],
            )
      ]),
    );
  }

// login user

loginUser() async {
      
       setState(() {
          isLoading = true;
       }); 

        String res = await AuthMethod().loginUser(
        email: _emailController.text, password: _passwordController.text);
        print(res);

     if (res == "success") {
      //
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)  => const AppRoot()));
      
    } else {
      showSnackBar(res, context);
    }
        
      setState(() {
          isLoading = false;
       });
  }






 


  
}


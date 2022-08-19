

import 'dart:typed_data';

import 'package:budget_app/config/colors.dart';
import 'package:budget_app/config/text.dart';
import 'package:budget_app/config/utils.dart';
import 'package:budget_app/resources/auth_method.dart';
import 'package:budget_app/view/UI%20widgets/addtask_form.dart';
import 'package:budget_app/view/UI%20widgets/bottom_sign_text.dart';
import 'package:budget_app/view/UI%20widgets/buttons.dart';
import 'package:budget_app/view/approot.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool value = false;

  @override
  void dispose() {
    super.dispose();
    _emailController;
    _passwordController;
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = {};

    arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bkgrColor,
        foregroundColor: blackColor,
      ),
      backgroundColor: bkgrColor,
      body: SafeArea(child: SingleChildScrollView(child: getBody(arguments))),
    );
  }

  Widget getBody(Map argument) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 150,
              color: success,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 5,
              width: 150,
              color: unselected,
            )
          ],
        ),
        const SizedBox(
          height: 80,
        ),

        // AddTaskForm('Full name', null, false, null, _nameController),
        // const SizedBox(
        //   height: 40,
        // ),
        // AddTaskForm('Email', null, false, null, _emailController),
        // const SizedBox(
        //   height: 40,
        // ),

          Text('Great! \nChoose a password', style: latoheading1, textAlign: TextAlign.center,),

          const SizedBox(
          height: 40,
        ),

        AddTaskForm('Password', null, false, null, _passwordController, true),
        const SizedBox(
          height: 40,
        ),
        AddTaskForm(
            'Confirm password', null, false, null, _confirmPasswordController, true),
        const SizedBox(
          height: 40,
        ),
        InkWell(
            onTap: () {
              signUp(
                  email: argument["email"],
                  name: argument["name"],
                  profilePic: argument["profilePic"]);
            },
            child: Button(
                _isLoading
                    ? const CircularProgressIndicator(
                        color: lightColor,
                      )
                    : Text(
                        'SignUp',
                        style: lightlatobody,
                      ),
                null)),
        const SizedBox(
          height: 30,
        ),

        checkWidget()
      ]),
    );
  }

  // logic for signUp

  signUp(
      {required String name,
      required String email,
      required Uint8List profilePic}) async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethod().signUpUser(
      name: name,
      email: email,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      // file: profilePic
    );

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const AppRoot(),
          settings: RouteSettings(arguments: {"profilePic": profilePic})));
    }
  }

  Widget checkWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Checkbox(
            value: this.value,
            activeColor: primColor,
            onChanged: (val) {
              setState(() {
                this.value = val!;
              });
            },
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        RichText(
          text: TextSpan(
            text: 'I have read and agree to the ',
            style: latobody,
            children:  <TextSpan>[
              TextSpan(
                  text: '\nthe terms of use', style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                        ],
          ),
        ),
       
      ],
    );
  }
}

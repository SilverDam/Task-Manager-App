import 'dart:typed_data';

import 'package:budget_app/config/colors.dart';
import 'package:budget_app/config/imagepicker.dart';
import 'package:budget_app/config/text.dart';
import 'package:budget_app/view/UI%20widgets/bottom_sign_text.dart';
import 'package:budget_app/view/UI%20widgets/buttons.dart';
import 'package:budget_app/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../UI widgets/addtask_form.dart';

class ImageSelection extends StatefulWidget {
  const ImageSelection({Key? key}) : super(key: key);

  @override
  State<ImageSelection> createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  bool value = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Uint8List? image;

  @override
  void dispose() {
    super.dispose();
    _emailController;
  }

  void selectImage() async {
    Uint8List profilePic = await selectProfileImage(ImageSource.gallery);
    setState(() {
      image = profilePic;
    });
  }

  _selectProfileImage (BuildContext context)async {

      return showDialog(context: context, builder: (context) {

           return  SimpleDialog(

              // title:  Text('choose image', style: latobody2,), 

               children:  [
                 SimpleDialogOption(
                     padding:  const EdgeInsets.all(20),
                     child:   Center(child: Text('Select image from gallery', style: latobody,)),
                      onPressed: () async {
                       Navigator.of(context).pop();
                       Uint8List file = await selectProfileImage(ImageSource.gallery);

                                  setState(() {
                                     image = file;
                                  });

                     },
                 ),

                 const Divider(),

                  SimpleDialogOption(
                     padding: const  EdgeInsets.all(20),
                     child:   Center(child: Text('Take a photo', style: latobody)),
                     onPressed: () async {
                       Navigator.of(context).pop();
                       Uint8List file = await selectProfileImage(ImageSource.camera);

                       setState(() {

                         image = file;
                         
                       });
                     },
                 )

               ],


           );

      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkgrColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 150,
                      color: unselected,
                    ),
                    const SizedBox(
                      width:10,
                    ),
                    Container(
                      height: 5,
                      width: 150,
                      color: lightColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        image != null
                            ? CircleAvatar(
                                radius: 100,
                                backgroundImage: MemoryImage(image!))
                            : const  CircleAvatar(
                                radius: 100,
                                backgroundImage: AssetImage('asset/images/defaultimage.png'),),
                         Positioned(
                            right:10,
                            bottom: 10,
                            child: GestureDetector(

                              onTap: () {

                                _selectProfileImage(context);
                              },
                              child:  Icon(
                                Icons.camera_alt, color: unselected.withOpacity(0.5),
                                size: 40,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AddTaskForm(
                        'Name', null, false, null, _nameController, false),
                    const SizedBox(
                      height: 40,
                    ),
                    AddTaskForm('Email', null, false, null, _emailController,false),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(

                      onTap: () {

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen(),
                        settings: RouteSettings(
                         
                         arguments:  {
                           
                           "name": _nameController.text,
                           "email": _emailController.text,
                           "profilePic": image


                         }

                        )
                        
                        ));

                      },
                      child: Button(
                          Text(
                            'Next',
                            style: lightlatobody,
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: lightColor,
                          )),
                    )
                  ],
                ),
                      const SizedBox(height: 30,),
                 Row(

                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [

                    const  SizedBox(width: 50,),
                    
                     Center(
                       child: BottomAction(
            Text(
              "Already have an account?",
              style: latobody,
            ),
            Text("Login",
                style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 18)),
            true),
                     ),
                   ],
                 ),

               const  SizedBox(height: 20,),


                   

              ],
            ),
          ),
        ),
      ),
    );
  }


  
}

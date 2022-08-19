import 'dart:typed_data';

import 'package:budget_app/resources/firesbasemethod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart' as model;

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.Users> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return model.Users.fromSnap(snap);
  }

  //signUp user

  Future<String> signUpUser(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword,
    //  required Uint8List file
      
      }) async {
    String res = "some error ocurred ";

    try {
      if (name.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          confirmPassword.isNotEmpty) {
        if (password == confirmPassword) {
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          // String photoUrl = await ImageStorageMethod()
          //     .uploadImage('Profile pics', file, false);
          // add user to firebase

          model.Users user = model.Users(
            name: name,
            uid: cred.user!.uid,
            email: email,
            password: password,
           // profilePic: photoUrl
          );

          await _firestore
              .collection('users')
              .doc(cred.user!.uid)
              .set(user.toJson());

          res = 'success';
        } else {
          res = 'password do not match';
        }
      } else {
        res = "enter all your details";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // login Users

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "some error ocurred ";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        _auth.signInWithEmailAndPassword(email: email, password: password);

        res = "success";
      } else {
        res = 'Please enter a valid your details';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}

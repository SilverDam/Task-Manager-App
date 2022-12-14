import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' ;


class ImageStorageMethod {

 
 FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

 FirebaseAuth   _auth  = FirebaseAuth.instance;


 Future<String> uploadImage (String childName, Uint8List file, bool isFile)async{

    Reference ref = _firebaseStorage.ref().child(childName).child(_auth.currentUser!.uid);

   UploadTask uploadTask =  ref.putData(file);

     TaskSnapshot snap = await  uploadTask;

       String downloadUrl = await snap.ref.getDownloadURL();

       return downloadUrl;

   

 }






}
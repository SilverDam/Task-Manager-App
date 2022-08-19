import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String name;
  final String uid;
  final String email;
  final String password;
 // final String profilePic;

  const Users({
    required this.name,
    required this.uid,
    required this.email,
    required this.password,
   // required this.profilePic,
  });


  Map<String, dynamic> toJson() =>{
      
      "name" : name,
     "uid": uid, 
     "email": email,
     "password": password,

  };


static Users fromSnap(DocumentSnapshot snap ){

   var snapShot = snap.data() as Map<String, dynamic>;

   return Users(
     
     name: snapShot['name'], 
     uid: snapShot['uid'], 
     email: snapShot['email'], 
     password: snapShot['password'],
   //  profilePic: snapShot['profilePic']
   );
     
}




}

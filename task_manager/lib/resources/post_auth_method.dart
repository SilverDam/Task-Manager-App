import 'package:budget_app/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class PostAuth {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

String  postId = Uuid().v1();



// Future<Post> getUserTasks () async {
     
//      User currentUser = 
     


// }



  Future<String> storePost(
      {required String name,
      required String uid,
      required String title,
      required String description,
      required String date,
      required String status,
      required String startTime,
      required String endTime,
      required String reminder,
      required String repeat
      
      
      }) async {

      String  res = "something went wrong";
    try {
      Post post = Post(
        name: name,
        uid: uid,
        title: title,
        description: description,
        date: date,
        status: status,
        startTime: startTime,
        endTime: endTime,
        postId: postId,
        reminder:  reminder,
        repeat: repeat,
      );
      
       
       await _fireStore.collection("Posts").doc(postId).set(post.toJson());

       res = "succesful";

    } catch (err) {
            
        res = err.toString();

    }
     return res;
  } 



}

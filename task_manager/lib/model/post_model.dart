import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String name;
  final String uid;
  final String title;
  final String description;
  final String date;
  final String status;
  final String startTime;
  final String endTime;
  final String postId;
  final String reminder;
  final String repeat;

  const Post({
    required this.name,
    required this.uid,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.postId,
    required this.reminder,
    required this.repeat,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "title": title,
        "description": description,
        "date": date,
        "status": status,
        "startTime": startTime,
        "endTime": endTime,
        "postId": postId,
        "reminder": reminder,
        "repeat": repeat,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return Post(
      name: snapShot["name"],
      uid: snapShot["uid"],
      title: snapShot["ttitle"],
      description: snapShot["description"],
      date: snapShot["date"],
      status: snapShot["status"],
      startTime: snapShot["startTime"],
      endTime: snapShot["endTime"],
      postId: snapShot["postId"],
      reminder: snapShot["reminder"],
      repeat: snapShot["repeat"],
    );
  }
}

import 'package:budget_app/model/post_model.dart';
import 'package:budget_app/resources/post_auth_method.dart';
import 'package:flutter/material.dart';


class PostProvider with ChangeNotifier {


Post?  _post;

final PostAuth _postAuth = PostAuth();




Post? get getPost =>  _post;


// Future<void> refrehPost() asyc{





// }












}
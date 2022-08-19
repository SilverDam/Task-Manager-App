
import 'package:budget_app/model/user_model.dart';
import 'package:budget_app/resources/auth_method.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {

 Users? _user;
final AuthMethod _authMethod = AuthMethod();

Users? get getUser => _user;


Future<void> refreshUser()async{

    Users user = await _authMethod.getUserDetails();
    _user = user;

    notifyListeners();
 }  
}
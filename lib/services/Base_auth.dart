
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

abstract class BaseAuth{

  Future <void> resetPass(String email,BuildContext context){}
  /////////////////////////
  Future signInByEmail(String email,String pass , BuildContext context){}
  //////////////////
  Future signOut()async{
  }

  Future<AuthResult> register(String name ,String email , String pass , BuildContext context){}
}
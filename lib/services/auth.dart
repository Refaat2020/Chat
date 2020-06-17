
import 'package:chat/logic/user_model.dart';
import 'package:chat/services/Base_auth.dart';
import 'package:chat/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:toast/toast.dart';

class AuthServices extends BaseAuth {
  GetIt locator = GetIt.instance;

  FirebaseUser _firebaseUser;
  AuthResult _authResult;
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  UserModel _userFromFirebase(FirebaseUser user){
    return user !=null ? UserModel(uiid: user.uid) : null ;
  }

  Future<void> resetPass(String email, BuildContext context) async {
    String errorMessage;

    try {
      await _fireBaseAuth
          .sendPasswordResetEmail(email: email.trim());

    } catch (e) {
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          print(
              "handle_authentication_error_messagess.your_email_address_appears_to_be_malformed");
          Toast.show(
            errorMessage,
            context,
            duration: Toast.LENGTH_LONG,
          );
          break;

        case "ERROR_USER_NOT_FOUND":
          errorMessage =
              ("handle_authentication_error_messagess.user_not_found");
          Toast.show(
            errorMessage,
            context,
            duration: Toast.LENGTH_LONG,
          );
          break;
      }
    }
  }


@override
  Future<AuthResult> register(String name ,String email, String pass,BuildContext context)async {

try{
  _authResult = await _fireBaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
  _firebaseUser = _authResult.user;
  _userFromFirebase(_firebaseUser);

  Toast.show("Done", context,duration: Toast.LENGTH_LONG);
}catch(e){
print(e);
}
    return super.register(name,email, pass,context);
  }

@override
  Future signInByEmail(String email, String pass , BuildContext context)async {
  try{
    _authResult =
    await _fireBaseAuth.signInWithEmailAndPassword(
        email: email,
        password: pass);
    _firebaseUser = _authResult.user;
    print("done");
    return _userFromFirebase(_firebaseUser);
  }catch(e){
    print(e);
  }
    return super.signInByEmail(email, pass , context);
  }


  @override
  Future signOut()async {
    if (_fireBaseAuth.currentUser() != null) {
     await _fireBaseAuth.signOut();
      return Future.delayed(Duration.zero);
    } else {}    return super.signOut();
  }




}
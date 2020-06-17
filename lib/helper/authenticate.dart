

import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/views/chat_room_screen.dart';
import 'package:chat/views/signin.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = false ;

   toggelView()async{
     await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
       setState(() {
         showSignIn = value;
       });
     });

  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn = true){
      return ChatRoomScreen();
    }else{
      return LoginPage(toggelView());
    }
  }
}

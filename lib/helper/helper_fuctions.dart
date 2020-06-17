

import 'package:chat/helper/constant.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class HelperFunctions{

static String sharedPreferenceUserLoggedInKey = "IsLoggedIN";
static String sharedPreferenceUserNameKey = "USERNAMEKEY";
static String sharedPreferenceUserEmailKey = "USEREMAILKEY";


///this section to save data like username , email , logged in
static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIN)async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIN);
}

static Future<bool> saveUserNameSharedPreference(String username)async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(sharedPreferenceUserNameKey, username);
}

static Future<bool> saveUserEmailSharedPreference(String userEmail)async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
}
/// ******** end of section ********


/// get the saved date via sharedPreference/////

static Future<String> getUserEmailSharedPreference()async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString(sharedPreferenceUserEmailKey);
}

static Future<String> getUserNameSharedPreference()async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getString(sharedPreferenceUserNameKey);
}

static Future<bool> getUserLoggedInSharedPreference()async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.getBool(sharedPreferenceUserLoggedInKey);
}

///****end of this section ****///


GetIt locator = GetIt.instance;

///create room  and send user to room
/// to create  chat room we need id and the users name
createChatRoomAndStartConversation(String username,BuildContext context ){
  print("${Constants.myName}");
  if(username != Constants.myName){
    String chatRoomId =  getChatRoomId(username, Constants.myName);
    List<String>users = [username,Constants.myName];
    Map<String , dynamic> chatRoomMap = {
      "users" : users,
      "chatroomid":chatRoomId,
    };
    locator<DatabaseMethods>().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(context, MaterialPageRoute(builder: (_)=>ConversationScreen(chatRoomID: chatRoomId,)));
  }else{
    Toast.show("you can't send message to yourself", context);
  }

}
getChatRoomId(String a , String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";

  }else{
    return "$a\_$b";
  }
}

}
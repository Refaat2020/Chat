
import 'package:chat/helper/constant.dart';
import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/search.dart';
import 'package:chat/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}



class _ChatRoomScreenState extends State<ChatRoomScreen> {

  Stream chatRoomStream;

  Widget ChatRoomList(){
     StreamBuilder(
       stream: chatRoomStream,
         builder: (context , snap){

         return snap.hasData ? ListView.builder(
           itemCount: snap.data.documents.length,
           itemBuilder: (context , index){
             return
           },
         ):Container;
         },
     );
  }
  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    locator<DatabaseMethods>().getChatRooms(Constants.myName);
    super.initState();
  }
 GetIt locator = GetIt.instance;
  getUserInfo()async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Room"),
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
            locator<AuthServices>().signOut().then((value) {
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              HelperFunctions.saveUserNameSharedPreference("");
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginPage(null)));

            });
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SearchScreen()));
          },
        child: Icon(Icons.search),
      ),
    );
  }
}

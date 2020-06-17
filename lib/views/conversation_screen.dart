
import 'package:chat/helper/constant.dart';
import 'package:chat/services/database.dart';
import 'package:chat/widgets/messge_tile.dart';
import 'package:chat/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get_it/get_it.dart';

class ConversationScreen extends StatefulWidget {

  String chatRoomID;
  Stream chatMessageStream;

  ConversationScreen({this.chatRoomID,this.chatMessageStream});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

TextEditingController _messagesEditController = TextEditingController();

  GetIt locator = GetIt.instance;



QuerySnapshot snapshot;


Widget chatMessageList(){

  return StreamBuilder(
    stream: widget.chatMessageStream,
      builder: ( context , snapshot){
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context , index){
          return MessageTile(
              snapshot
              .data.documents[index].data["message"],
              snapshot
                  .data.documents[index].data["sendBy"] == Constants.myName,
          );
        },
      ):Container();
      },
  );
}
  sendMessages(){


    if(_messagesEditController.text.isNotEmpty)
      {
        Map<String , dynamic> messagesMap = {

          "message" : _messagesEditController.text,
          "sendBy": Constants.myName,
          "time": DateTime.now().millisecondsSinceEpoch
        };
        locator<DatabaseMethods>().addConversationMessage(widget.chatRoomID, messagesMap);
        print("${_messagesEditController.text}");
        _messagesEditController.clear();

      }
  }
@override
void initState() {
  // TODO: implement initState
  locator<DatabaseMethods>().getChats(widget.chatRoomID).then((value){
    setState(() {
      widget.chatMessageStream  = value;

    });
  });
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: <Widget>[
            chatMessageList(),
                Container(
                 alignment: AlignmentDirectional.bottomCenter,
                  child: Container(

                    color: Color(0x54FFFFFF),
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(24),vertical: ScreenUtil().setHeight(20)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                          controller: _messagesEditController,
                            style:  TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: "Messages",
                              hintStyle: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            sendMessages();
                          },

                          child: Container(
                              height: ScreenUtil().setHeight(105),
                              width: ScreenUtil().setWidth(105),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const  Color(0x36FFFFFF),
                                    const  Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(40),
                              ),

                              child: Image.asset("res/img/send.png"),),
                        )

                    ],
                    ),
                  ),
                ),

              ],

        ),
      ),
    );
  }
}

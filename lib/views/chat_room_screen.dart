import 'package:chat/helper/constant.dart';
import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/search.dart';
import 'package:chat/views/signin.dart';
import 'package:chat/widgets/history_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  String chatRoomId;
   String messageId;

  Stream chatRoomStream;
final items = List<String>.generate(20, (i) => "item ");

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snap) {
        return snap.hasData
            ? ListView.builder(
                itemCount: snap.data.documents.length,
                itemBuilder: (context, index) {
                  final String _item  = items[index];
                  return Dismissible(
                    key: Key(_item),

                    onDismissed:(DismissDirection dir){

                      setState(() {
                        this.items.removeAt(index);
                      });
                      locator<DatabaseMethods>().removeChat(chatRoomId:chatRoomId , chatId:messageId  );

                      Scaffold.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  dir == DismissDirection.startToEnd
                                      ?"item removed"
                                      :'deleted'
                              ),
                          ),
                      );
                      dispose();
                    } ,
                    direction: DismissDirection.endToStart,
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete,size: 35,),
                      alignment: Alignment.centerRight,
                    ),
                   background: Container(
                    ),
                    child: HistoryList(
                        snap.data.documents[index].data["chatroomId"]
                       .toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                 snap.data.documents[index].data["chatroomid"],
                        ),
                  );
                },
              )
            : Container();
      },
    );
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    locator<DatabaseMethods>().getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  GetIt locator = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Room"),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                locator<AuthServices>().signOut().then((value) {
                  HelperFunctions.saveUserLoggedInSharedPreference(false);
                  HelperFunctions.saveUserNameSharedPreference("");
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginPage(null)));
                });
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
      body: Container(
        child: ChatRoomList(),
      ),
    );
  }
}

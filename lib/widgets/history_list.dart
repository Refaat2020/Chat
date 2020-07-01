
import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/services/database.dart';
import 'package:chat/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get_it/get_it.dart';

class HistoryList extends StatelessWidget {
  final String username;
  String chatRoomId;
  String chatId;

  HistoryList(this.username , this.chatRoomId );
  GetIt locator = GetIt.instance;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return InkWell(
      highlightColor: Colors.blue,
      onLongPress: (){
        locator<DatabaseMethods>().removeChatRoom("chatRoom");
      },
      onTap: (){
          ///go to conversation
        locator<HelperFunctions>().createChatRoomAndStartConversation(username, context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(120),
              width: ScreenUtil().setWidth(130),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text("${username.substring(0,1).toUpperCase()}"),
            ),
            SizedBox(
              width: 8,
            ),
            Text(username , style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
            ),),
          ],
        ),
      ),
    );
  }
}

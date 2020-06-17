

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageTile extends StatelessWidget {
  final String messages;
  bool isSendByMe;

  MessageTile(this.messages,this.isSendByMe) ;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0 : 24 , right: isSendByMe ? 24 :0) ,
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(33)),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24 ,vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: isSendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2a76BC),
              ]
                  :[
                const Color(0x1AFFFFFF),
                const Color(0xA1AFAFFF)
              ],
          ),
          borderRadius: isSendByMe ?
          BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomLeft: Radius.circular(24),
          ):
          BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23),
          ),
        ),
        child: Text("$messages",style: TextStyle(
            color: Colors.white70,
            fontSize: ScreenUtil().setSp(50,allowFontScalingSelf: true),
          fontWeight: FontWeight.bold
        ),
        ),
      ),
    );
  }
}

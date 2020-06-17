

import 'package:chat/helper/constant.dart';
import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SearchTile extends StatelessWidget {
  final String userName;
  final String email;
   SearchTile({Key key, this.userName, this.email});

   GetIt locator = GetIt.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName , style:  simpleStyle(),),
              SizedBox(height: 7,),
              Text(email , style:  simpleStyle(),),
            ],
          ),
          Spacer(),

          GestureDetector(
            onTap: (){
              locator<HelperFunctions>().createChatRoomAndStartConversation(userName, context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),

              ),
              padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
              child: userName == Constants.myName ? Text("me") : Text("message"),
            ),
          )
        ],
      ),
    );
  }
}

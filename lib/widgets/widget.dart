
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget  appBarMain(BuildContext context){
  return AppBar(
    title: Text("Chat App" ,style: TextStyle(color: Colors.black),),
    centerTitle: true,
    elevation: 0,
  );
}
InputDecoration textFieldDecorition(String hintText){
return InputDecoration(

  prefixIcon:Icon(EvaIcons.heart,color: Colors.red.shade900,size: ScreenUtil().setHeight(80),) ,
  hintText: hintText,
  hintStyle: TextStyle(
    color: Colors.white54,
    fontSize: ScreenUtil().setSp(45,allowFontScalingSelf: true),

  ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
    ),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
);
}
TextStyle simpleStyle(){
  return TextStyle(
    color: Colors.white54,
    fontWeight: FontWeight.bold,
    fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
  );

}
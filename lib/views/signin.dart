

import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/chat_room_screen.dart';
import 'package:chat/views/signup.dart';
import 'package:chat/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  final Function toggel ;

  const LoginPage( this.toggel) ;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

QuerySnapshot snapshotUserInfo;

  final TextEditingController _emailEditController = TextEditingController();
  final TextEditingController _passEditController = TextEditingController();
  final  formKey = GlobalKey<FormState>();
bool isLoading = false;

  checkTxtField(){
    if(!formKey.currentState.validate()){
      return;
    }
    formKey.currentState.save();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      isLoading = true;
    });
  }
  GetIt auth = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(800)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24,),
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val){
                          if(val.isEmpty || val.contains('@'))
                            {
                              return "Please check your email";
                            }
                            return null;
                        },
                        controller: _emailEditController,
                        maxLines: 1,
                        autovalidate: true,
                        keyboardType: TextInputType.emailAddress,
                        style: simpleStyle(),
                        decoration: textFieldDecorition("Email"),
                      ),
                      TextFormField(
                        controller:_passEditController ,
                        maxLines: 1,
                        validator: (val){
                          if(val.isEmpty ){
                            return "Please Password Can't  be Empty";
                          }
                          return null;
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        style: simpleStyle(),
                        decoration: textFieldDecorition("Password"),
                      ),
                    ],
                  )
              ),

            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
              Container(
                alignment: Alignment.centerRight,
                child: FlatButton(onPressed: (){},child: Text("Forgot Password ?",style: simpleStyle(),),),
              ),
              SizedBox(height: ScreenUtil().setHeight(20),),
              Container(
                height: ScreenUtil.mediaQueryData.size.height/14,
                width: ScreenUtil.mediaQueryData.size.height*0.8,
                child: RaisedButton(
                  onPressed: (){
                    checkTxtField();
                    HelperFunctions.saveUserEmailSharedPreference(_emailEditController.text);

                    auth<DatabaseMethods>().getUserByEmail(_emailEditController.text).then((value) {
                      snapshotUserInfo = value;
                      HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data["name"]);
                    });
                    auth<AuthServices>().signInByEmail(_emailEditController.text, _passEditController.text, context).then((value) {
                      if(value != null)
                        {
                          HelperFunctions.saveUserLoggedInSharedPreference(true);

                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>ChatRoomScreen()));
                        }
                    });

                  },
                  child: Text("Login",style: TextStyle(
                    fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(55,allowFontScalingSelf: true)),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(ScreenUtil().setHeight(60))
                  ),
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(50),),
              Container(
                height: ScreenUtil.mediaQueryData.size.height/14,
                width: ScreenUtil.mediaQueryData.size.height*0.8,
                child: RaisedButton(
                  onPressed: (){
                    },
                  child: Text("Login with google",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(55,allowFontScalingSelf: true)),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(ScreenUtil().setHeight(60))
                  ),
                  color: Colors.white,
                ),
              ),
              SizedBox(height:ScreenUtil().setHeight(35),),
              GestureDetector(
                onTap: (){
//                  widget.toggel();
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SignUp(widget.toggel)));
                },
                child: RichText(
                  textAlign: TextAlign.center,
                    text: TextSpan(
                    text:"Don't have account ?  ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
                      ),
                      children: [
                        TextSpan(
                          text:"Register now",
                          style: TextStyle(
                            color: Colors.white,
                              fontSize: ScreenUtil().setSp(45,allowFontScalingSelf: true),
                              decoration: TextDecoration.underline,
                          ),

                        )
                      ],
                    ),
                ),
              ),
            SizedBox(height: ScreenUtil().setHeight(50),)
            ],
          ),
        ),
      ),
    );
  }
}

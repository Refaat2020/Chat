

import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/services/database.dart';
import 'package:chat/views/signin.dart';
import 'package:chat/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get_it/get_it.dart';

class SignUp extends StatefulWidget {
  final Function toggel ;
SignUp(this.toggel);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GetIt auth = GetIt.instance;

  final TextEditingController _userEditController = TextEditingController();
  final TextEditingController _emailEditController = TextEditingController();
  final TextEditingController _passEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  checkTxtField(){
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      isLoading = true;
    });
  }
  //todo Function get user details
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : SingleChildScrollView(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(700)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24,),
          child: Column(
            children: <Widget>[
              Form(
                autovalidate: true,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val){
                        if(val.isEmpty){ return"Please enter the username";
                        }
                        return null;
                      },
                      controller: _userEditController,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      style: simpleStyle(),
                      decoration: textFieldDecorition("Name"),
                    ),
                  ],
                ),
              ),
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
                keyboardType: TextInputType.emailAddress,
                style: simpleStyle(),
                decoration: textFieldDecorition("Email"),
              ),
              TextFormField(
                validator: (val){
                  if(val.isEmpty ){
                    return "Please Password Can't  be Empty";
                  }
                  return null;
                },
                controller: _passEditController,
                maxLines: 1,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                style: simpleStyle(),
                decoration: textFieldDecorition("Password"),
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
                    Map<String , String >userInfoMap = {
                      "name" : _userEditController.text,
                      "email":_emailEditController.text,
                    };
                    HelperFunctions.saveUserEmailSharedPreference(_emailEditController.text);
                    HelperFunctions.saveUserNameSharedPreference(_userEditController.text);

                    auth<AuthServices>().register(_userEditController.text,_emailEditController.text, _passEditController.text,context).then((value) {

                        auth<DatabaseMethods>().uploadUserInfo(userInfoMap);
                        HelperFunctions.saveUserLoggedInSharedPreference(true);

                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LoginPage(widget.toggel)));

                    });
                  },
                  child: Text("SignUp",style: TextStyle(
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
                  onPressed: (){},
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
                  widget.toggel();
//                  Navigator.of(context).push(MaterialPageRoute(builder:(_)=> LoginPage()));
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:"Already have account ?  ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(48,allowFontScalingSelf: true),
                    ),
                    children: [

                      TextSpan(
                        text:"SignIn now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(45,allowFontScalingSelf: true),
                          decoration: TextDecoration.underline,
                        ),

                      ),
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

import 'package:chat/helper/authenticate.dart';
import 'package:chat/logic/locator.dart';
import 'package:chat/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp(){
    setupLocator();
}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: "Chat App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black38,
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: Authenticate(),
    );
  }
}


import 'package:chat/helper/constant.dart';
import 'package:chat/services/database.dart';
import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/widgets/search_tile.dart';
import 'package:chat/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  QuerySnapshot searchSnapshot;
String _myName;
  GetIt locator = GetIt.instance;
  TextEditingController _searchEditingController  = TextEditingController();

  initiateSearch(){
    locator<DatabaseMethods>().getUserByName(_searchEditingController.text).then((val){
      setState(() {
        searchSnapshot = val;

      });
    });

  }

  getUserInfo()async{
    _myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {

    });
print("$_myName");
  }

  Widget searchList(){
    return searchSnapshot != null ?  ListView.builder(
      shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 1),
       addRepaintBoundaries: true,
        itemCount: searchSnapshot.documents.length,
        itemBuilder: (context , index){
          return SearchTile(
            userName: searchSnapshot.documents[index].data["name"],
            email: searchSnapshot.documents[index].data["email"],
          );
        },
    ): Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    initiateSearch();
    getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(24),vertical: ScreenUtil().setHeight(20)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                        controller: _searchEditingController,
                        style:  TextStyle(
                         color: Colors.white,
                          fontWeight: FontWeight.w600,
                         ),
                        decoration: InputDecoration(
                          hintText: "Search for Username",
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
                      initiateSearch();
                      },

                    child: Container(
                      height: ScreenUtil().setHeight(100),
                        width: ScreenUtil().setWidth(100),
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

                        child: Image.asset("res/img/search_white.png")),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            searchList(),
          ],
        ),
      ),
    );
  }
}


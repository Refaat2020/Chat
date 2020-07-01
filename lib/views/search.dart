
import 'package:chat/logic/searchMob.dart';
import 'package:chat/widgets/search_tile.dart';
import 'package:chat/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  TextEditingController _searchEditingController  = TextEditingController();


  GetIt locator = GetIt.instance;


  Widget searchList(){
    return locator<SearchStore>().searchSnapshot != null ?  ListView.builder(
      shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 1),
       addRepaintBoundaries: true,
        itemCount: locator<SearchStore>().searchSnapshot.documents.length,
        itemBuilder: (context , index){
          return SearchTile(
            userName: locator<SearchStore>().searchSnapshot.documents[index].data["name"],
            email: locator<SearchStore>().searchSnapshot.documents[index].data["email"],
          );
        },
    ): Container();
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
                      locator<SearchStore>().initiateSearch(_searchEditingController.text);
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
            Observer(
              builder: (_){
                 return searchList();
              },

            ),
          ],
        ),
      ),
    );
  }
}


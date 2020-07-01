
import 'package:chat/helper/helper_fuctions.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'searchMob.g.dart';

class SearchStore extends SearchMob with _$SearchStore{}



abstract class SearchMob with Store{

  GetIt locator = GetIt.instance;
  @observable
String myName ;

@observable
QuerySnapshot searchSnapshot;

@action
getUserInfo()async{
  myName = await HelperFunctions.getUserNameSharedPreference();

  print("$myName");
}

@action  ///for fetch user account

Future getUserByName(String username)async{
  return await Firestore.instance.collection("users")
      .where("name" , isEqualTo: username ).getDocuments();
}

@action
initiateSearch(String search)async{
  await getUserByName(search).then((val){

    searchSnapshot = val;
  });

}

}
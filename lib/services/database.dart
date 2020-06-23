import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  ///for upload user data
  Future uploadUserInfo(userMap )async{
    await  Firestore.instance.collection("users")
      .add(userMap);
  }

  ///for fetch user account
  Future getUserByName(String username)async{
    return await Firestore.instance.collection("users")
        .where("name" , isEqualTo: username ).getDocuments();

  }

  ///for fetch user account
  Future getUserByEmail(String email)async{
    return await Firestore.instance.collection("users")
        .where("email" , isEqualTo: email ).getDocuments();

  }

  //for create chatRoom
  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection("chatRoom")
        .document(chatRoomId).setData(chatRoomMap)
        .catchError((e){
          print(e.toString());
    });
  }

  addConversationMessage(String chatRoomID,messageMap){
    Firestore.instance.collection("chatRoom")
        .document(chatRoomID)
        .collection("chats")
        .add(messageMap).catchError((e){
          print(e.toString());
    });
  }

    getConversationMessage(String chatRoomID)async{
     return await Firestore.instance.collection("chatRoom")
        .document(chatRoomID)
        .collection("chats")
        .snapshots();

  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time',descending: false)
        .snapshots();
  }


   getChatRooms(String username)async {
     return await Firestore.instance.
     collection("chatRoom").
     where("users", arrayContains: username)

         .snapshots();
   }

  removeChat({String chatRoomId, String chatId})async {
    await Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .document(chatId)
        .delete();
  }

  Future<void> removeChatRoom(String chatRoomId) async {
    Firestore.instance.collection("chatRoom").document(chatRoomId).delete();
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .getDocuments()
        .then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
    });
  }
}
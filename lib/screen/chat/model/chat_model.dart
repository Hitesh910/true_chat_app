import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel
{
  String? msg,senderUID,uid;
  Timestamp? dateTime;

  ChatModel({this.msg, this.senderUID, this.dateTime, this.uid});

  factory ChatModel.mapToModel(Map m1)
  {
    return ChatModel(
      msg: m1['msg'],
      senderUID: m1['SenderUID'],
      dateTime: m1['date']
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/helper/db_helper.dart';
import '../../../utils/helper/auth_helper.dart';
import '../../profile/model/profile_model.dart';
import '../controller/chat_controller.dart';
import '../model/chat_model.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController controller = Get.put(ChatController());
  ProfileModel? model = Get.arguments;
  TextEditingController txtMsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
              stream: controller.sp,
              builder: (context, snapshot) {
                if(snapshot.hasError)
                {
                  Text("${snapshot.hasError}");
                }
                else if(snapshot.hasData)
                {
                  QuerySnapshot allChatData = snapshot.data;
                  List<ChatModel> chatList = [];

                  for(var x in allChatData.docs)
                  {
                    Map m1 = x.data() as Map;
                    ChatModel model = ChatModel.mapToModel(m1);
                    model.uid = x.id;
                    chatList.add(model);
                  }

                  return  Expanded(
                    child: ListView.builder(
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async{
                            await  FireDbHelper.helper.deleteData();
                          },
                          child: Container(
                            height: 50,
                            width: 10,
                            // color: Colors.red,
                            margin: const EdgeInsets.all(5),

                            alignment: chatList[index].senderUID == AuthHelper.helper.user!.uid
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              height: 50,
                              width: MediaQuery
                                  .sizeOf(context)
                                  .width * 0.50,
                              // color: Colors.red,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              alignment: Alignment.center,
                              child:  Text("${chatList[index].msg}"),
                              // margin: EdgeInsets.all(5),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return CircularProgressIndicator();
              }
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: txtMsg,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Write a message",
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    ChatModel chatModel = ChatModel(
                      msg: txtMsg.text,
                      dateTime: DateTime.now(),
                      senderUID: AuthHelper.helper.user!.uid,
                    );

                    FireDbHelper.helper.sentMsg(
                      AuthHelper.helper.user!.uid,
                      model!.uid!,
                      chatModel,
                    );
                  },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

/*
* ListView.builder(
          itemBuilder: (context, index) {
            return Container(
                height: 50,
                width: 10,
                alignment: index % 2 == 0
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: index % 2 == 0
                    ? Container(
                        height: 40,
                        width: MediaQuery.sizeOf(context).width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: index % 2 == 0
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )
                              : const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(0),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                        ),
                      )
                    : Row(
                        children: [
                          CircleAvatar(),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text("Name"),
                              SizedBox(height: 8,),
                              Container(
                                height: 35,
                                width: 20,
                                color: Colors.cyan,
                              )
                            ],
                          )
                        ],
                      )
                // : ListTile(
                //     leading:  const CircleAvatar(),
                //     title:  const Text("name"),
                //     subtitle: Container(
                //       width: 20,
                //       //width: MediaQuery.sizeOf(context).width * 0.50,
                //       decoration: const BoxDecoration(color: Colors.black),
                //       child: const Text("Hello"),
                //     ),
                //   ),
                );
            // return index % 2 == 1
            //     ? Container(
            //         alignment: Alignment.centerLeft,
            //         child: ListTile(
            //           title: Text("name"),
            //           leading: CircleAvatar(),
            //         ),
            //       )
            //     : Container(
            //         child: Text("User"),
            //         alignment: Alignment.centerRight,
            //       );
          },
        )*/

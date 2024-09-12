import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const CircleAvatar(),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.05,
              ),
              Text("${model!.name}"),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call_outlined,
                size: 28,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.video_call_outlined,
                size: 28,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            StreamBuilder(
              stream: controller.sp,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Text("${snapshot.hasError}");
                } else if (snapshot.hasData) {
                  QuerySnapshot allChatData = snapshot.data;
                  List<ChatModel> chatList = [];

                  for (var x in allChatData.docs) {
                    Map m1 = x.data() as Map;
                    ChatModel model = ChatModel.mapToModel(m1);
                    model.uid = x.id;
                    chatList.add(model);
                  }

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: MediaQuery.sizeOf(context).height * 0.098,
                            width: 10,
                            alignment: chatList[index].senderUID !=
                                AuthHelper.helper.user!.uid
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: chatList[index].senderUID !=
                                AuthHelper.helper.user!.uid
                                ? Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.all(10),
                                        height: 40,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.40,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff3D4A7A),
                                          borderRadius: chatList[index].senderUID !=
                                              AuthHelper.helper.user!.uid
                                              ? const BorderRadius.only(
                                                  topRight: Radius.circular(0),
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                )
                                              : const BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  topLeft: Radius.circular(0),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                ),
                                        ),
                                        child: Text("${chatList[index].msg}"),
                                      ),
                                      Text(
                                        "${chatList[index].dateTime?.toDate().hour}:${chatList[index].dateTime?.toDate().minute}",
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      CircleAvatar(
                                        child: Text("${model!.name![0]}"),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${model!.name}"),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            alignment: Alignment.centerLeft,
                                            height: 30,
                                            width: MediaQuery.sizeOf(context).width * 0.4,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                  10,
                                                ),
                                                topRight: Radius.circular(
                                                  10,
                                                ),
                                                bottomRight: Radius.circular(
                                                  10,
                                                ),
                                                bottomLeft: Radius.circular(
                                                  10,
                                                ),
                                              ),
                                              color: Color(0xffF2F7FB),
                                            ),
                                            child: Text(
                                                "${chatList[index].dateTime?.toDate().hour}"),
                                          ),
                                          Text(
                                              "${chatList[index].dateTime?.toDate().hour}:${chatList[index].dateTime?.toDate().minute}")
                                        ],
                                      )
                                    ],
                                  ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.add_link_rounded),
                  Expanded(
                    child: TextField(
                      controller: txtMsg,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: "Write a message",
                      ),
                    ),
                  ),
                  IconButton.filled(
                    onPressed: () {
                      ChatModel chatModel = ChatModel(
                        msg: txtMsg.text,
                        dateTime: Timestamp.now(),
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
        ));
  }
}


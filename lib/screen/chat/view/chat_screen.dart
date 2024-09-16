import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:true_chat_app/screen/home/controller/home_controller.dart';

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
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    controller.readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          homeController.theme.value == true ? Colors.white : Colors.black54,
      appBar: AppBar(
        backgroundColor:
            homeController.theme.value == true ? Colors.white : Colors.black54,
        title: Row(
          children: [
            CircleAvatar(
              child: Text(model!.name![0]),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.05,
            ),
            Text(
              "${model!.name}",
              style: TextStyle(
                  color: homeController.theme.value == true
                      ? Colors.black
                      : Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call_outlined,
              size: 28,
              color: homeController.theme.value == true
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.video_call_outlined,
              size: 28,
              color: homeController.theme.value == true
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 28,
            color: homeController.theme.value == true
                ? Colors.black
                : Colors.white,
          ),
        ),
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
                    child: SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(5),
                            alignment: chatList[index].senderUID ==
                                    AuthHelper.helper.user!.uid
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: chatList[index].senderUID ==
                                    AuthHelper.helper.user!.uid
                                ? Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              // width: MediaQuery.sizeOf(context).width * 0.50,
                                              alignment: Alignment.centerRight,
                                              padding: const EdgeInsets.all(10),
                                              height: 40,
                                              // width: MediaQuery.sizeOf(context).width,
                                              decoration: BoxDecoration(
                                                color: const Color(0xff3D4A7A),
                                                borderRadius: chatList[index]
                                                            .senderUID ==
                                                        AuthHelper
                                                            .helper.user!.uid
                                                    ? const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(0),
                                                        topLeft:
                                                            Radius.circular(20),
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        bottomRight:
                                                            Radius.circular(20),
                                                      )
                                                    : const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(20),
                                                        topLeft:
                                                            Radius.circular(0),
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        bottomRight:
                                                            Radius.circular(20),
                                                      ),
                                              ),
                                              child: Text(
                                                "${chatList[index].msg}",
                                                style: TextStyle(
                                                    color: homeController
                                                                .theme.value ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${chatList[index].dateTime?.toDate().hour}:${chatList[index].dateTime?.toDate().minute}",
                                          style: TextStyle(
                                            color: homeController.theme.value ==
                                                    true
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            child: Text(model!.name![0]),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${model!.name}",
                                                style: TextStyle(
                                                    color: homeController
                                                                .theme.value ==
                                                            true
                                                        ? Colors.black
                                                        : Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                // margin: EdgeInsets.all(5),
                                                alignment: Alignment.centerLeft,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                      0,
                                                    ),
                                                    topRight: Radius.circular(
                                                      10,
                                                    ),
                                                    bottomRight:
                                                        Radius.circular(
                                                      10,
                                                    ),
                                                    bottomLeft: Radius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                  color: Color(0xffF2F7FB),
                                                ),
                                                child: Text(
                                                    "${chatList[index].msg}",
                                                    style: const TextStyle(
                                                        color: Colors.black)),
                                              ),
                                              Text(
                                                "${chatList[index].dateTime?.toDate().hour}:${chatList[index].dateTime?.toDate().minute}",
                                                style: TextStyle(
                                                  color: homeController
                                                              .theme.value ==
                                                          true
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                          );
                        },
                      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.add_link_rounded,
                  color: homeController.theme.value == true
                      ? Colors.black
                      : Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SizedBox(
                    // height: MediaQuery.sizeOf(context).height - 200,
                    // width: MediaQuery.sizeOf(context).width,
                    child: TextField(
                      onSubmitted: (value) {
                        if(txtMsg.text.isNotEmpty) {
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
                        }
                        else if(txtMsg.text.isEmpty)
                        {
                          Get.snackbar("Empty data", "Please enter data");
                        }
                      },
                      style: TextStyle(
                          color: homeController.theme.value == true
                              ? Colors.black
                              : Colors.white),
                      controller: txtMsg,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: "Write a message",
                        fillColor: homeController.theme.value == true
                            ? Colors.white
                            : Colors.black,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    if(txtMsg.text.isNotEmpty) {
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
                      }
                      else if(txtMsg.text.isEmpty)
                        {
                          Get.snackbar("Empty data", "Please enter data");
                        }
                    },
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

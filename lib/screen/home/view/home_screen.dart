import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_chat_app/screen/chat/controller/chat_controller.dart';
import 'package:true_chat_app/screen/home/controller/home_controller.dart';

import '../../../utils/helper/auth_helper.dart';
import '../../../utils/helper/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    controller.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Home.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.filled(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.white.withOpacity(0.8),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "True Chat",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    controller.profileList.length,
                    (index) {
                      return Container(
                        height: 90,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.primaries[index],
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          height: 90,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "${controller.profileList[index]}",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  // color: Colors.white,
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color:controller.theme.value == true ?Colors.white :Colors.black54,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width - 350,
                          child: const Divider(
                            thickness: 5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: controller.chatUser,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            } else if (snapshot.hasData) {
                              controller.userList.clear();
                              QuerySnapshot? sq = snapshot.data;
                              List<QueryDocumentSnapshot> sqList = sq!.docs;

                              for (var x in sqList) {
                                Map m1 = x.data() as Map;
                                List uidList = m1["uids"];
                                String receiverID = "";
                                if (uidList[0] == AuthHelper.helper.user!.uid) {
                                  receiverID = uidList[1];
                                } else {
                                  receiverID = uidList[0];
                                }
                                controller.getChat(receiverID).then(
                                  (value) {
                                    controller.userList.add(controller.model!);
                                  },
                                );
                              }

                              return Obx(
                                () => ListView.builder(
                                  itemCount: controller.userList.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () async {
                                        await FireDbHelper.helper.getDocDataId(
                                            AuthHelper.helper.user!.uid,
                                            controller.userList[index].uid!);
                                        Get.toNamed("/chat",
                                            arguments:
                                                controller.userList[index]);
                                      },
                                      leading: CircleAvatar(
                                        child: Text(controller
                                            .userList[index].name![0]),
                                      ),
                                      title: Text(
                                          "${controller.userList[index].name}"),
                                      subtitle: Text(
                                          "${controller.userList[index].mobile}"),
                                      // trailing: Text("${controller.userList[index].}"),
                                    );
                                  },
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {

          Get.toNamed("/user");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

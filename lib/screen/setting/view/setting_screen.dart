import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_chat_app/screen/home/controller/home_controller.dart';
import 'package:true_chat_app/screen/profile/controller/profile_controller.dart';
import 'package:true_chat_app/utils/helper/shared_helper.dart';

import '../../../utils/helper/auth_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ProfileController controller = Get.put(ProfileController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
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
                height: 50,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.32,
                  ),
                  const Text(
                    "Setting",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  // color: Colors.white,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
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
                        ListTile(
                          leading: CircleAvatar(
                            child: Text(controller.model!.name![0]),
                          ),
                          title: Text("${controller.model!.name}"),
                          subtitle: Text("${controller.model!.bio}"),
                        ),
                        const Divider(
                          thickness: 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Theme"),
                              Obx(
                                () => Switch(
                                  value: homeController.theme.value,
                                  onChanged: (value) {
                                    print("===================$value");
                                    homeController.theme.value = value;
                                    SharedHelper helper = SharedHelper();
                                    helper.setTheme(homeController.theme.value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Get.toNamed("/profile");
                          },
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xffDEEBFF),
                            child: Icon(Icons.key),
                          ),
                          title: const Text("Account",style: TextStyle(color: Colors.black),),
                          subtitle:
                              const Text("Privacy, security, change number",style: TextStyle(color: Colors.black),),
                        ),
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xffDEEBFF),
                            child: Icon(Icons.message),
                          ),
                          title: Text("Chat"),
                          subtitle: Text("Chat history, theme, wallpapers",style: TextStyle(color: Colors.black),),
                        ),
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xffDEEBFF),
                            child: Icon(Icons.notification_important),
                          ),
                          title: Text("Notifications",style: TextStyle(color: Colors.black),),
                          subtitle: Text("Messages, group and others",style: TextStyle(color: Colors.black),),
                        ),
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xffDEEBFF),
                            child: Icon(Icons.help),
                          ),
                          title: Text("Help",style: TextStyle(color: Colors.black),),
                          subtitle:
                              Text("Help center, contact us, privacy policy",style: TextStyle(color: Colors.black),),
                        ),
                        const ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xffDEEBFF),
                            child: Icon(Icons.storage),
                          ),
                          title: Text("Storage and data",style: TextStyle(color: Colors.black),),
                          subtitle: Text("Network usage, storage usage"),
                        ),
                        ListTile(
                          onTap: () async {
                            Get.defaultDialog(
                              middleText: "Do you want to log out",
                              title: "Log out",
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pushNamed(context, '/login');
                                    await AuthHelper.helper.signOut();
                                    AuthHelper.helper.checkUser();
                                  },
                                  child: const Text("Yes"),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Get.back();
                                  },
                                  child: const Text("No"),
                                )
                              ],
                            );
                          },
                          leading: const CircleAvatar(
                            backgroundColor: Color(0xffDEEBFF),
                            child: Icon(Icons.logout),
                          ),
                          title: const Text("Log out",style: TextStyle(color: Colors.black)),
                          subtitle: const Text("Logout app",style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),)
                ),
            ],
          )
        ],
      ),
    );
  }
}

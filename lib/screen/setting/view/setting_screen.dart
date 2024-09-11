import 'package:flutter/material.dart';

import '../../../utils/helper/auth_helper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text("Setting"),
      // ),
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
                      const ListTile(
                        leading: CircleAvatar(),
                        title: Text("Name"),
                        subtitle: Text("New"),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffDEEBFF),
                          child: Icon(Icons.key),
                        ),
                        title: Text("Account"),
                        subtitle: Text("Privacy, security, change number"),
                      ),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffDEEBFF),
                          child: Icon(Icons.message),
                        ),
                        title: Text("Chat"),
                        subtitle: Text("Chat history, theme, wallpapers"),
                      ),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffDEEBFF),
                          child: Icon(Icons.notification_important),
                        ),
                        title: Text("Notifications"),
                        subtitle: Text("Messages, group and others"),
                      ),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffDEEBFF),
                          child: Icon(Icons.help),
                        ),
                        title: Text("Help"),
                        subtitle:
                            Text("Help center, contact us, privacy policy"),
                      ),
                      const ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffDEEBFF),
                          child: Icon(Icons.storage),
                        ),
                        title: Text("Storage and data"),
                        subtitle: Text("Network usage, storage usage"),
                      ),
                       ListTile(
                        onTap: () async {
                          Navigator.pushNamed(context, '/login');
                          await AuthHelper.helper.signOut();
                          AuthHelper.helper.checkUser();
                        },
                        leading: CircleAvatar(
                          backgroundColor: Color(0xffDEEBFF),
                          child: Icon(Icons.logout),
                        ),
                        title: Text("Log out"),
                        subtitle: Text("Logout app"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

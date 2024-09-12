import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_chat_app/screen/call/view/call_screen.dart';
import 'package:true_chat_app/screen/contact/view/contact_screen.dart';
import 'package:true_chat_app/screen/home/controller/home_controller.dart';
import 'package:true_chat_app/screen/home/view/home_screen.dart';
import 'package:true_chat_app/screen/profile/controller/profile_controller.dart';
import 'package:true_chat_app/screen/setting/view/setting_screen.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  HomeController controller = Get.put(HomeController());
  ProfileController profileController = Get.put(ProfileController());
 final List screen = [
    const HomeScreen(),
    const CallScreen(),
    const ContactScreen(),
    const SettingScreen(),
  ];

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return screen[controller.i.value];
        },
      ),
      bottomNavigationBar: Obx(
        () =>  BottomNavigationBar(
          currentIndex: controller.i.value,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.black,
          onTap: (value) {
            controller.i.value = value;
            print(value);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Contact"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}

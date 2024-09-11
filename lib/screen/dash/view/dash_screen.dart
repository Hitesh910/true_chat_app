import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_chat_app/screen/call/view/call_screen.dart';
import 'package:true_chat_app/screen/contact/view/contact_screen.dart';
import 'package:true_chat_app/screen/home/controller/home_controller.dart';
import 'package:true_chat_app/screen/home/view/home_screen.dart';
import 'package:true_chat_app/screen/setting/view/setting_screen.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
         return controller.i.value == 0
              ? const HomeScreen()
              : controller.i.value == 1
              ? const CallScreen()
              : controller.i.value == 2
              ? const ContactScreen()
              : const SettingScreen();
        }
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
          onTap: (value) {
            controller.i.value = value;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "Call"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Contact"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ]),
    );
  }
}

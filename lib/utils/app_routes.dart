import 'package:flutter/material.dart';
import 'package:true_chat_app/screen/call/view/call_screen.dart';
import 'package:true_chat_app/screen/chat/view/chat_screen.dart';
import 'package:true_chat_app/screen/contact/view/contact_screen.dart';
import 'package:true_chat_app/screen/dash/view/dash_screen.dart';
import 'package:true_chat_app/screen/home/view/home_screen.dart';
import 'package:true_chat_app/screen/login/view/login_screen.dart';
import 'package:true_chat_app/screen/login/view/login_home_screen.dart';
import 'package:true_chat_app/screen/login/view/signUp.dart';
import 'package:true_chat_app/screen/profile/view/profile_screen.dart';
import 'package:true_chat_app/screen/setting/view/setting_screen.dart';
import 'package:true_chat_app/screen/splash/view/splash_screen.dart';
import 'package:true_chat_app/screen/user/view/user_screen.dart';

Map<String,WidgetBuilder> app_routes = {
  "/home":(context) => const HomeScreen(),
  "/login":(context) => LoginHomeScreen(),
  "/login1":(context) => LoginScreen(),
  "/signup":(context) => const SignUpScreen(),
  "/chat":(context) => const ChatScreen(),
  "/call":(context) => CallScreen(),
  "/contact":(context) => ContactScreen(),
  "/setting":(context) => SettingScreen(),
  "/dash":(context) => DashScreen(),
  "/profile":(context) => ProfileScreen(),
  "/":(context) => SplashScreen(),
  "/user":(context) => UserScreen(),
  "/chat":(context) => ChatScreen(),
};
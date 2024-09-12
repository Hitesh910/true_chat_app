import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/helper/auth_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _Login1ScreenState();
}

class _Login1ScreenState extends State<LoginScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed("/login");
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Log in to Chatbox",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff3D4A7A),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Welcome back! Sign in using your social account or email to continue us ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/facebook.png"),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await AuthHelper.helper
                            .signInWithGoogleEmailAndPassword();
                        print("============================");
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/googlePay.png"),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/apple2.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.withOpacity(1.0),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your email",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff3D4A7A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: txtEmail,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid email";
                    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff3D4A7A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: txtPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      String? msg = await AuthHelper.helper
                          .signIn(txtEmail.text, txtPassword.text);

                      if (msg == "Success") {
                        AuthHelper.helper.checkUser();
                        print("Sucesss");
                        Get.toNamed("/profile");
                      } else {
                        Get.defaultDialog(title: "${msg}");
                        print("s");
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 330,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/container.png"),
                      ),
                    ),
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

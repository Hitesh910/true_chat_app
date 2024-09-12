import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginHomeScreen extends StatefulWidget {
  const LoginHomeScreen({super.key});

  @override
  State<LoginHomeScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage(
              //       "assets/images/Splash.jpg",
              //     ),
              //     fit: BoxFit.contain,
              //     opacity: 1.2),
              gradient: LinearGradient(
                colors: [
                  Color(0xff30396D),
                  Color(0xff151B35),
                  Color(0xff293250),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                 Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Connect friends easily  &  quickly ",
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width*0.16,
                      color: Colors.white,
                      wordSpacing: 2,
                      height: 1.2,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                 Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Our chat app is the perfect way to stay connected with friends and family .",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.sizeOf(context).width *0.048,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                 SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/facebook.png"),
                        ),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/googlePay.png"),
                        ),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/apple.png"),
                        ),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/signup");
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Sign up within mail",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                 SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Existing account?  ",
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed("/login1");
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

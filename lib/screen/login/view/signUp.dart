import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_chat_app/screen/home/controller/home_controller.dart';

import '../../../utils/helper/auth_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: controller.theme.value == true ?Colors.white:Colors.black,
      appBar: AppBar(
        // backgroundColor:
        // controller.theme.value == true ? Colors.white : Colors.black,
        actions: [],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Sign up with Email",
                  style: TextStyle(
                      fontSize: 20,
                      color: controller.theme.value == true
                          ? const Color(0xff3D4A7A)
                          : const Color(0xff6581BF),
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Get chatting with friends and family \n"
                  "today by signing up for our chat app!",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Your name",
                style: TextStyle(
                  fontSize: 15,
                  color: controller.theme.value == true
                      ? const Color(0xff3D4A7A)
                      : const Color(0xff6581BF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: txtName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid name";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Your email",
                style: TextStyle(
                  fontSize: 16,
                  color: controller.theme.value == true
                      ? const Color(0xff3D4A7A)
                      : const Color(0xff6581BF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Flexible(
                child: TextFormField(
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
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 16,
                  color: controller.theme.value == true
                      ? const Color(0xff3D4A7A)
                      : const Color(0xff6581BF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: txtPassword,
                  decoration: InputDecoration(
                    suffix: controller.isHide.value == true
                        ? IconButton(
                            onPressed: () {
                              controller.isHide.value = false;
                              print(controller.isHide.value);
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              controller.isHide.value = true;
                              print(controller.isHide.value);
                            },
                            icon: const Icon(
                              Icons.hide_source,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid password";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Confirm password",
                style: TextStyle(
                  fontSize: 16,
                  color: controller.theme.value == true
                      ? const Color(0xff3D4A7A)
                      : const Color(0xff6581BF),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: txtConfirmPassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid password";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      if(formKey.currentState!.validate()) {
                        String? msg = await AuthHelper.helper
                            .signUp(txtEmail.text, txtPassword.text);

                        if (msg == "Success") {
                          Get.toNamed("/login");
                        } else {
                          Get.defaultDialog(title: "${msg}");
                        }
                      }
                    },
                    child: Container(
                      height: 48,
                      width: MediaQuery.sizeOf(context).width - 60,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/container.png",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: const Text(
                        "Create an account",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
* Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Spacer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      "Log in to Chatbox",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff3D4A7A),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // SizedBox(height: MediaQuery.sizeOf(context).height *0.2,),
                  Text(
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
                          await AuthHelper.helper.signInWithGoogleEmailAndPassword();
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
                  Text(
                    "Your email",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff3D4A7A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: txtEmail,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff3D4A7A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: txtPassword,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Center(
                  child: InkWell(
                    onTap: () async{
                     String? msg = await AuthHelper.helper.signIn(txtEmail.text, txtPassword.text);

                     if(msg == "Success")
                       {
                         Get.toNamed("/home");
                       }
                     else
                       {
                         Get.defaultDialog(title: "${msg}");
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
                  ),
                ),
              ],
            )
          ],
        ),*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_chat_app/screen/profile/model/profile_model.dart';

import '../../../utils/helper/db_helper.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtBio = TextEditingController();
  ProfileController controller = Get.put(ProfileController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  Future<void> getData()
  async {
    controller.getData();
    if(controller.model!=null) {
      txtName.text = controller.model!.name!;
      txtEmail.text = controller.model!.email!;
      txtBio.text = controller.model!.bio!;
      txtMobile.text = controller.model!.mobile!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your name",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff3D4A7A),
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
                height: 10,
              ),
              const Text(
                "Your email",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff3D4A7A),
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
                height: 10,
              ),
              const Text(
                "Your mobile no",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff3D4A7A),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: txtMobile,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid number";
                    } else if (value.length<10) {
                      return "Invalid number";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Your bio",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff3D4A7A),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Flexible(
                child: TextFormField(
                  controller: txtBio,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid bio";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    if(formKey.currentState!.validate()) {
                      ProfileModel model = ProfileModel(
                        name: txtName.text,
                        email: txtEmail.text,
                        mobile: txtMobile.text,
                        bio: txtBio.text,
                      );
                      await FireDbHelper.helper.setProfile(model);
                      Get.toNamed("/dash");
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
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
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



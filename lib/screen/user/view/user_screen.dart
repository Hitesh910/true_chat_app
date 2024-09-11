import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/db_helper.dart';
import '../../../utils/helper/auth_helper.dart';
import '../controller/user_controller.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.profileList.length,
            itemBuilder: (context, index) {
              return  ListTile(
                onTap: () async {
                  await FireDbHelper.helper.getDocDataId(AuthHelper.helper.user!.uid, controller.profileList[index].uid!);
                  Get.toNamed(
                    '/chat',
                    arguments: controller.profileList[index],
                  );
                },
                title: Text("${controller.profileList[index].name}"),
                leading: SizedBox(
                  height: 120,
                  width: 50,
                  child: CircleAvatar(child: Text("${controller.profileList[index].name![0]}"),),
                ),
                subtitle: Text("How are you?"),
                trailing: Text(
                  "2 min ago",
                  style: TextStyle(fontSize: 14),
                ),
              );
            },
          ),
        ),
      ],
    ),

    );

  }
}

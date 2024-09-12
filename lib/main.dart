import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:true_chat_app/screen/home/controller/home_controller.dart';
import 'package:true_chat_app/utils/app_routes.dart';
import 'package:true_chat_app/utils/helper/app_theme.dart';

import 'firebase_options.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeController controller = Get.put(HomeController());
  controller.getTheme();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      Obx(
        () =>  GetMaterialApp(
          debugShowCheckedModeBanner: false,
        theme: controller.theme.value == true ?lightTheme :darkTheme,
        routes: app_routes,
            ),
      )
  );
}
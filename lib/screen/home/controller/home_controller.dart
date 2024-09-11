import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController
{
  RxList profileList = [
    "assets/images/profile.png",
    "assets/images/profile1.png",
    "assets/images/profile2.png",
    "assets/images/profile3.png",
    "assets/images/profile4.png",
    // "assets/images/profile5.png",
    "assets/images/profile6.png",
    "assets/images/profile7.png",
  ].obs;

  RxInt i = 0.obs;
}
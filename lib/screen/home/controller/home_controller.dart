import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../utils/helper/db_helper.dart';
import '../../../utils/helper/shared_helper.dart';
import '../../profile/model/profile_model.dart';

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
  RxBool theme = true.obs;
  Stream<QuerySnapshot>? chatUser;
  RxList<ProfileModel> userList = <ProfileModel>[].obs;
  ProfileModel? model;
  RxBool isHide = false.obs;
  RxBool isHide1 = false.obs;

  void getTheme() async {
    SharedHelper helper = SharedHelper();
    bool? theme1 = await helper.getTheme();
    theme.value = theme1 ?? false;
  }

  void getUser()  {
    chatUser =FireDbHelper.helper.getChat();
  }

  Future<void> getChat(String receiverID) async {
    model= await FireDbHelper.helper.userChat(receiverID);
  }

}
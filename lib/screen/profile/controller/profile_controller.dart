import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../utils/helper/db_helper.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController
{
  ProfileModel? model;

  Future<void> getData()
  async {
    model = await FireDbHelper.helper.getProfile();
  }
}
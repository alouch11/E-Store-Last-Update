import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_prefsname.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tasks_theme.dart';

class TasksThemecontroler extends GetxController{
  @override
  void onInit()
  {
    SharedPreferences.getInstance().then((value) {
      isdark = value.getBool(dailozDarkMode)!;
    });
    update();
    super.onInit();
  }

  var isdark = false;
  Future<void> changeThem (state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isdark = prefs.getBool(dailozDarkMode) ?? true;
    isdark = !isdark;

    if (state == true) {
      Get.changeTheme(TasksMythemes.darkTheme);
      isdark = true;
    }
    else {
      Get.changeTheme(TasksMythemes.lightTheme);
      isdark = false;
    }
    update();
  }

}
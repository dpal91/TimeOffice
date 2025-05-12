import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timeoffice/Consts/ApplicationRoutes.dart';
import 'package:timeoffice/Consts/ApplicationStorage.dart';

class SplashController extends GetxController {
  var version = "".obs;

  SplashController() {
    getProjectVersion();
    var name = ApplicationStorage.getData(ApplicationStorage.UserName) ?? "";
    var weeklyoff = ApplicationStorage.getData(ApplicationStorage.WeeklyOff) ?? [];
    print(weeklyoff);
    if (weeklyoff.isEmpty) ApplicationStorage.saveData(ApplicationStorage.WeeklyOff, ["Sat", "Sun"]);
    Future.delayed(Duration(seconds: 2), () {
      print(name);
      if (name == "") {
        Get.offAndToNamed(ApplicationRoutes.Signup);
      } else
        Get.offAllNamed(ApplicationRoutes.Home);
    });
  }

  getProjectVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionNumber = packageInfo.version;
    // String versionCode = await GetVersion.projectCode;

    // return "1.0";
    version.value = versionNumber;
  }
}

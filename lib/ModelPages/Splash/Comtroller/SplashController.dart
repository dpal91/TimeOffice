import 'package:get/get.dart';
import 'package:timeoffice/Consts/ApplicationRoutes.dart';
import 'package:timeoffice/Consts/ApplicationStorage.dart';

class SplashController extends GetxController {
  SplashController() {
    Future.delayed(Duration(seconds: 2), () {
      var name = ApplicationStorage.getData(ApplicationStorage.UserName) ?? "";
      print(name);
      if (name == "") {
        Get.offAndToNamed(ApplicationRoutes.Signup);
      } else
        Get.offAllNamed(ApplicationRoutes.Home);
    });
  }
}

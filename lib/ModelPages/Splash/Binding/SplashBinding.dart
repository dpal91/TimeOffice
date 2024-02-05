import 'package:get/get.dart';
import 'package:timeoffice/ModelPages/Splash/Comtroller/SplashController.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

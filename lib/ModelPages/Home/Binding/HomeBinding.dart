import 'package:get/get.dart';
import 'package:timeoffice/ModelPages/Home/Comtroller/HomeController.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeController());
  }
}

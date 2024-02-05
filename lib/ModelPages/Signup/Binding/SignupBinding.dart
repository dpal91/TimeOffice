import 'package:get/get.dart';
import 'package:timeoffice/ModelPages/Signup/Comtroller/SignupController.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SignupController());
  }
}

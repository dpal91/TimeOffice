import 'package:get/get.dart';
import 'package:timeoffice/ModelPages/History/Comtroller/HistoryController.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HistoryController());
  }
}

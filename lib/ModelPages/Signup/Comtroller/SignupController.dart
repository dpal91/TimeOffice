import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:timeoffice/Consts/ApplicationRoutes.dart';
import 'package:timeoffice/Consts/ApplicationStorage.dart';

class SignupController extends GetxController {
  TextEditingController nameEdit = TextEditingController();
  TextEditingController hourEdit = TextEditingController();
  TextEditingController inTimeEdit = TextEditingController();
  TextEditingController outTimeEdit = TextEditingController();

  SignupController() {
    nameEdit.text = ApplicationStorage.getData(ApplicationStorage.UserName) ?? "";
    hourEdit.text = ApplicationStorage.getData(ApplicationStorage.WorkingHour) ?? "";
    inTimeEdit.text = ApplicationStorage.getData(ApplicationStorage.InTime) ?? "";
    outTimeEdit.text = ApplicationStorage.getData(ApplicationStorage.OutTime) ?? "";
  }

  void updateData() async {
    if (valiate()) {
      await ApplicationStorage.saveData(ApplicationStorage.UserName, nameEdit.text.toString().trim());
      await ApplicationStorage.saveData(ApplicationStorage.InTime, inTimeEdit.text.toString().trim());
      await ApplicationStorage.saveData(ApplicationStorage.OutTime, outTimeEdit.text.toString().trim());
      await ApplicationStorage.saveData(ApplicationStorage.WorkingHour, hourEdit.text.toString().trim());
      Get.offAllNamed(ApplicationRoutes.Home);
    }
  }

  bool valiate() {
    return true;
  }
}

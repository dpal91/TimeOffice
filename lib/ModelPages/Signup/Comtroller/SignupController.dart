import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeoffice/Consts/ApplicationRoutes.dart';
import 'package:timeoffice/Consts/ApplicationStorage.dart';

class DayItem {
  var dayName = "".obs;
  var shortDayName = "".obs;
  var isSelected = false.obs;

  DayItem(day, shortName, {isSelected = false}) {
    dayName.value = day;
    shortDayName.value = shortName;
    this.isSelected.value = isSelected;
  }
}

class SignupController extends GetxController {
  TextEditingController nameEdit = TextEditingController();
  TextEditingController hourEdit = TextEditingController();
  TextEditingController inTimeEdit = TextEditingController();
  TextEditingController outTimeEdit = TextEditingController();

  var listOfDays = [
    DayItem("Saturday", "Sat"),
    DayItem("Sunday", "Sun"),
    DayItem("Monday", "Mon"),
    DayItem("Tuesday", "Tue"),
    DayItem("Wednesday", "Wed"),
    DayItem("Thursday", "Thu"),
    DayItem("Friday", "Fri"),
  ];
  var selectedDays = [].obs;

  var workingTime = DateTime(1, 1, 1, 8, 0).obs;

  SignupController() {
    nameEdit.text = ApplicationStorage.getData(ApplicationStorage.UserName) ?? "";
    hourEdit.text = ApplicationStorage.getData(ApplicationStorage.WorkingHour) ?? "";
    inTimeEdit.text = ApplicationStorage.getData(ApplicationStorage.InTime) ?? "";
    outTimeEdit.text = ApplicationStorage.getData(ApplicationStorage.OutTime) ?? "";
    getTheList();
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

  void updateIsSelected(DayItem item) {
    listOfDays.forEach((day) {
      if (day == item) {
        day.isSelected.value = !day.isSelected.value;
      }
    });
  }

  void updateSelectedDates() {
    selectedDays.clear();
    listOfDays.forEach((day) {
      if (day.isSelected.value) {
        selectedDays.add(day.shortDayName.value);
      }
    });
    ApplicationStorage.saveData(ApplicationStorage.WeeklyOff, selectedDays.value);
  }

  void getTheList() async {
    selectedDays.value = await ApplicationStorage.getData(ApplicationStorage.WeeklyOff) ?? [];
    listOfDays.forEach((day) {
      if (selectedDays.value.contains(day.shortDayName.value)) {
        day.isSelected.value = true;
      }
    });

    var workingH = int.parse(ApplicationStorage.getData(ApplicationStorage.WorkingHour) ?? "0");
    workingTime.value = DateTime(1, 1, 1, workingH ~/ 60, workingH % 60);
  }

  void updateWorkingHour() {
    hourEdit.text = (workingTime.value.hour * 60 + workingTime.value.minute).toString();
    ApplicationStorage.saveData(ApplicationStorage.WorkingHourUpdated, true);
  }
}

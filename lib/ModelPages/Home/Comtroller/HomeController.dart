import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeoffice/Consts/ApplicationRoutes.dart';
import 'package:timeoffice/Consts/ApplicationStorage.dart';
import 'package:timeoffice/Consts/GlobalFunctions.dart';

class HomeController extends GetxController {
  TextEditingController punchInTimeController = TextEditingController();
  TextEditingController punchInDateController = TextEditingController();
  var userName = ''.obs;
  var isPunchedIn = false.obs;
  var isPunchedOut = false.obs;
  var punchedInTime = ''.obs;
  var errorIn = ''.obs;
  var errorOut = ''.obs;
  var toDayMonthYear = '';
  var fullToday = '';

  HomeController() {
    userName.value = ApplicationStorage.getData(ApplicationStorage.UserName) ?? "";
    print(userName.value);
    if (userName.value == "") {
      Get.offAndToNamed(ApplicationRoutes.Signup);
    }
    DateTime dt = DateTime.now();
    toDayMonthYear = months[dt.month - 1] + "-" + dt.year.toString();
    fullToday = dt.day.toString().padLeft(2, '0') + "-" + months[dt.month - 1] + "-" + dt.year.toString();
    checkForAlreadyPunchedIn();
    checkForAlreadyPunchedOut();
  }

  void checkForAlreadyPunchedIn() {
    isPunchedIn.value = false;
    var thisMonthList = ApplicationStorage.getData(toDayMonthYear) ?? [];
    for (var item in thisMonthList) {
      if (item['date'] == fullToday) {
        isPunchedIn.value = true;
        punchedInTime.value = item['punchInTime'];
      }
    }
  }

  void checkForAlreadyPunchedOut() {
    isPunchedOut.value = false;
    var thisMonthList = ApplicationStorage.getData(toDayMonthYear) ?? [];
    for (var item in thisMonthList) {
      if (item['date'] == fullToday) {
        var pout = item['punchOutTime'] ?? "";
        if (pout != "") isPunchedOut.value = true;
      }
    }
  }

  void punchIn() {
    fullToday = punchInDateController.text;
    toDayMonthYear = fullToday.substring(3);
    checkForAlreadyPunchedIn();
    if (!isPunchedIn.value) {
      var thisMonthList = ApplicationStorage.getData(toDayMonthYear) ?? [];
      var recTime;
      if (updatePunchInTime())
        recTime = ApplicationStorage.getData(ApplicationStorage.InTime);
      else
        recTime = punchInTimeController.text;
      var data = {
        'date': punchInDateController.text,
        'punchInTime': recTime,
      };
      thisMonthList.add(data);
      thisMonthList = GlobalFunctions.sortList(thisMonthList);
      ApplicationStorage.saveData(toDayMonthYear, thisMonthList);
      isPunchedIn.value = true;
      punchedInTime.value = punchInTimeController.text;
      Get.back();
      Get.snackbar(
        "Saved!",
        "Data Saved Successfully!",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade400,
      );
    } else {
      Get.back();
      Get.snackbar("Oops!", "You already punched in for today!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.shade300, colorText: Colors.white);
    }
  }

  void punchOut() {
    fullToday = punchInDateController.text;
    var time = punchInTimeController.text;
    if (updatePunchOutTime()) time = ApplicationStorage.getData(ApplicationStorage.OutTime);

    checkForAlreadyPunchedOut();
    if (!isPunchedOut.value) {
      var thisMonthList = ApplicationStorage.getData(toDayMonthYear) ?? [];
      var newdata = [];
      var datafound = false;
      for (var item in thisMonthList) {
        if (item['date'] == fullToday) {
          DateTime dt = DateTime.now();
          datafound = true;
          var inTime = GlobalFunctions.getTimeVal(item['punchInTime'] ?? "");
          var outTime = GlobalFunctions.getTimeVal(time);
          var gain = 0;
          if (outTime != 0) {
            var timeDif = outTime - inTime;
            var stayTime = int.parse(ApplicationStorage.getData(ApplicationStorage.WorkingHour) ?? "0");
            gain = (timeDif - stayTime);
          }
          item['punchOutTime'] = time;
          item['gain'] = gain.toString();
        }
        newdata.add(item);
      }
      if (datafound) {
        ApplicationStorage.saveData(toDayMonthYear, newdata);
        isPunchedOut.value = true;
        Get.back();
        Get.snackbar("Done", "You have successfully punched out.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green.shade200, duration: Duration(seconds: 2));
      } else {
        Get.back();
        Get.snackbar("oops!", "You have not punched in for the day.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.shade200,
            duration: Duration(seconds: 2),
            colorText: Colors.white);
      }
    } else {
      Get.back();
      Get.snackbar("Oops!", "You already punched out for today!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red.shade300, colorText: Colors.white);
    }
  }

  assignDateTimeNow() {
    DateTime dt = DateTime.now();
    punchInDateController.text = dt.day.toString().padLeft(2, '0') + "-" + months[dt.month - 1] + "-" + dt.year.toString();
    var hr = dt.hour;
    if (hr > 12)
      punchInTimeController.text = (hr - 12).toString().padLeft(2, "0") + ":" + dt.minute.toString().padLeft(2, "0") + " PM";
    else {
      if (hr == 12)
        punchInTimeController.text = (hr).toString().padLeft(2, "0") + ":" + dt.minute.toString().padLeft(2, "0") + " PM";
      else
        punchInTimeController.text = (hr).toString().padLeft(2, "0") + ":" + dt.minute.toString().padLeft(2, "0") + " AM";
    }
  }

  updatePunchInTime() {
    errorIn.value = "";
    var times = punchInTimeController.text;
    var inTime = GlobalFunctions.getTimeVal(times);
    var maxInTimes = ApplicationStorage.getData(ApplicationStorage.InTime) ?? "";
    var maxInTime = GlobalFunctions.getTimeVal(maxInTimes);
    if (maxInTime > inTime) {
      errorIn.value = maxInTimes + " will be recorded as In time";
      return true;
    } else
      return false;
  }

  updatePunchOutTime() {
    errorOut.value = "";
    var times = punchInTimeController.text;
    var outTime = GlobalFunctions.getTimeVal(times);
    var maxOutTimes = ApplicationStorage.getData(ApplicationStorage.OutTime) ?? "";
    var maxOutTime = GlobalFunctions.getTimeVal(maxOutTimes);
    if (outTime > maxOutTime) {
      errorIn.value = maxOutTimes.toString() + " will be recorded as Out time";
      return true;
    } else
      return false;
  }
}

import 'dart:ffi';

import 'package:get/get.dart';
import 'package:timeoffice/Consts/ApplicationStorage.dart';
import 'package:timeoffice/Consts/GlobalFunctions.dart';

class HistoryController extends GetxController {
  var month = 0;
  var year = 0;
  var needRefresh = false.obs;

  var recordMonthYear = ''.obs;
  var gain = 0.obs;
  List historyList = [];
  HistoryController() {
    DateTime dt = DateTime.now();
    month = dt.month;
    year = dt.year;
    getRecordMonth();
    calculateGain();
  }

  calculateGain() {
    gain.value = 0;
    var fetchForMonth = months[month - 1] + "-" + year.toString();
    List list = ApplicationStorage.getData(fetchForMonth) ?? [];
    historyList = list.reversed.toList();
    for (var item in list) {
      print(item);
      var inTime = GlobalFunctions.getTimeVal(item['punchInTime'] ?? "");
      var outTime = GlobalFunctions.getTimeVal(item['punchOutTime'] ?? "");
      if (outTime != 0) {
        var timeDif = outTime - inTime;
        var stayTime = int.parse(ApplicationStorage.getData(ApplicationStorage.WorkingHour) ?? "0") * 60;
        gain += (timeDif - stayTime);
      }
    }
    print(gain);
  }

  void getRecordMonth() {
    recordMonthYear.value = months[month - 1] + ", " + year.toString();
    calculateGain();
    needRefresh.value = true;
  }

  void goPrev() {
    month--;
    if (month == 0) {
      month = 12;
      year--;
    }
    getRecordMonth();
  }

  void goNext() {
    month++;
    if (month == 13) {
      month = 1;
      year++;
    }
    getRecordMonth();
  }

  void delete(String date) {
    var fetchForMonth = months[month - 1] + "-" + year.toString();
    List list = ApplicationStorage.getData(fetchForMonth) ?? [];

    list.removeWhere((element) => element['date'].toString() == date);
    ApplicationStorage.saveData(fetchForMonth, list);
    calculateGain();
    needRefresh.value = true;
  }
}

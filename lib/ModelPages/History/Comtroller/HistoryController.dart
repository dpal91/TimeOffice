import 'package:get/get.dart';
import 'package:timeoffice/Consts/ApplicationStorage.dart';
import 'package:timeoffice/Consts/GlobalFunctions.dart';

class HistoryController extends GetxController {
  var month = 0;
  var year = 0;
  var needRefresh = false.obs;
  var presentDays = 0.obs;
  var absentDays = 0.obs;
  var avgWork = DateTime(1, 1, 1, 0, 0).obs;
  var avgLate = DateTime(1, 1, 1, 0, 0).obs;

  var recordMonthYear = ''.obs;
  var gain = 0.obs;
  List historyList = [];

  HistoryController() {
    DateTime dt = DateTime.now();
    month = dt.month;
    year = dt.year;
    updateGainOrLossIfRequired();
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
        var stayTime = int.parse(ApplicationStorage.getData(ApplicationStorage.WorkingHour) ?? "0");
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

  isPresent(String calDate) {
    try {
      var item = historyList.where((element) => element["date"] == calDate);
      // print(item.toList());
      // if (calDate.toUpperCase() == historyList[presentDays.value]["date"].toString().toUpperCase()) {
      if (item.isNotEmpty) presentDays.value++;
      return item.toList();

      return false;
    } catch (_) {
      return [];
    }
  }

  isAbsent(DateTime dt) {
    var now = DateTime.now();
    // print(now.millisecondsSinceEpoch.toString() + " ->now");
    // print(dt.millisecondsSinceEpoch.toString() + " -> $dt");
    if (now.millisecondsSinceEpoch > dt.millisecondsSinceEpoch && now.day != dt.day) {
      absentDays++;
      return true;
    } else
      return false;
  }

  void updateGainOrLossIfRequired() {
    var isUpdateNeeded = ApplicationStorage.getData(ApplicationStorage.WorkingHourUpdated) ?? false;
    if (isUpdateNeeded) {
      ApplicationStorage.saveData(ApplicationStorage.WorkingHourUpdated, false);
      DateTime dt = DateTime.now();
      var toDayMonthYear = months[dt.month - 1] + "-" + dt.year.toString();
      var fullToday = dt.day.toString().padLeft(2, '0') + "-" + months[dt.month - 1] + "-" + dt.year.toString();
      var thisMonthList = ApplicationStorage.getData(toDayMonthYear) ?? [];
      var newdata = [];
      for (var item in thisMonthList) {
        if (item['date'] == fullToday) {
          DateTime dt = DateTime.now();
          var inTime = GlobalFunctions.getTimeVal(item['punchInTime'] ?? "");
          var outTime = GlobalFunctions.getTimeVal(item['punchOutTime'] ?? "");
          var gain = 0;
          if (outTime != 0) {
            var timeDif = outTime - inTime;
            var stayTime = int.parse(ApplicationStorage.getData(ApplicationStorage.WorkingHour) ?? "0");
            gain = (timeDif - stayTime);
          }
          item['gain'] = gain.toString();
        }
        newdata.add(item);
      }
      if (newdata.isNotEmpty) {
        ApplicationStorage.saveData(toDayMonthYear, newdata);
      }
    }
    getRecordMonth();
    calculateGain();
  }

  void calculateAverageWork() {
    int totalMin = 0;
    int totalLate = 0;
    var lateDays = 0;
    var days = 0;
    var entryTime = GlobalFunctions.getTimeVal(ApplicationStorage.getData(ApplicationStorage.InTime) ?? "");
    for (var item in historyList) {
      var inTime = GlobalFunctions.getTimeVal(item['punchInTime'] ?? "");
      var outTime = GlobalFunctions.getTimeVal(item['punchOutTime'] ?? "");
      if (inTime != 0) {
        totalLate += inTime - entryTime;
        print(totalLate);
        lateDays++;
      }
      if (outTime != 0) {
        totalMin += outTime - inTime;
        days++;
      }
    }
    int avg = 0;
    if (totalMin != 0 && days != 0) avg = (totalMin / days).toInt();

    int lateAvg = 0;
    if (totalLate != 0 && lateDays != 0) lateAvg = (totalLate / lateDays).toInt();
    avgWork.value = DateTime(1, 1, 1, 0, avg);
    avgLate.value = DateTime(1, 1, 1, 0, lateAvg);
  }
}

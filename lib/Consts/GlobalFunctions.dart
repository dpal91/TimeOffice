import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeoffice/ModelPages/Home/Comtroller/HomeController.dart';

const months = <String>['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

class GlobalFunctions {
  static choseTime(context, TextEditingController editController, zone, {String val = ""}) async {
    var hr = 0, min = 0;
    switch (zone) {
      case 1:
        hr = 9;
        min = 15;
        break;
      case 2:
        hr = 18;
        min = 00;
        break;
      case 3:
        hr = DateTime.now().hour;
        min = DateTime.now().minute;
        break;
    }
    var newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hr, minute: min),
    );
    if (newTime != null) {
      var hr = newTime.hour;
      if (hr > 12)
        editController.text = (hr - 12).toString().padLeft(2, "0") + ":" + newTime.minute.toString().padLeft(2, "0") + " PM";
      else {
        if (hr == 12)
          editController.text = (hr).toString().padLeft(2, "0") + ":" + newTime.minute.toString().padLeft(2, "0") + " PM";
        else
          editController.text = (hr).toString().padLeft(2, "0") + ":" + newTime.minute.toString().padLeft(2, "0") + " AM";
      }
    }
    if (val.toLowerCase() == "in") {
      HomeController controller = Get.find();
      controller.updatePunchInTime();
    }
    if (val.toLowerCase() == "out") {
      HomeController controller = Get.find();
      controller.updatePunchOutTime();
    }
  }

  static selectDate(context, TextEditingController text) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime.now());
    if (picked != null)
      text.text =
          picked.day.toString().padLeft(2, '0') + "-" + months[picked.month - 1] + "-" + picked.year.toString().padLeft(2, '0');
  }

  static getTimeVal(String stringTime) {
    if (stringTime == "" || stringTime == "0")
      return 0;
    else {
      var anot = stringTime.substring(stringTime.length - 2).trim();
      var hr = stringTime.substring(0, 2).trim();
      var mn = stringTime.substring(3, 5).trim();

      if (anot.toLowerCase() == "am") {
        return int.parse(hr) * 60 + int.parse(mn);
      }
      if (anot.toLowerCase() == "pm") {
        if (int.parse(hr) == 12)
          return int.parse(hr) * 60 + int.parse(mn);
        else
          return (int.parse(hr) + 12) * 60 + int.parse(mn);
      }
    }
  }

  static sortList(List data) {
    return data
      ..sort(
        (a, b) {
          var aDate, bDate;
          aDate = a['date'].toString().substring(0, 2);
          bDate = b['date'].toString().substring(0, 2);
          return int.parse(aDate).compareTo(int.parse(bDate));
        },
      );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeoffice/Consts/ApplicationStorage.dart';
import 'package:timeoffice/Consts/GlobalFunctions.dart';
import 'package:timeoffice/ModelPages/History/Controller/HistoryController.dart';

class SummaryView extends GetWidget<HistoryController> {
  SummaryView({super.key});

  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  var listOfWeeklyOff = ApplicationStorage.getData(ApplicationStorage.WeeklyOff) ?? [];

  @override
  Widget build(BuildContext context) {
    // print(controller.historyList[0]);

    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    controller.absentDays.value = 0;
    controller.presentDays.value = 0;
    controller.calculateAverageWork();
    var list = List.generate(lastDayOfMonth.day, (index) {
      return getEachDayRow(now, index);
    });

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
            child: Column(
              children: [
                Center(
                    child: Text(
                  months[controller.month - 1] + " - " + controller.year.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Obx(() => Text(controller.presentDays.value.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                      SizedBox(height: 5),
                      Text("Present Days", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                    ]),
                    Column(children: [
                      Text(controller.absentDays.value.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Absent Days", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                    ]),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Text(
                          controller.avgWork.value.hour.toString().padLeft(2, '0') +
                              ":" +
                              controller.avgWork.value.minute.toString().padLeft(2, '0'),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Avg. Work Duration", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                    ]),
                    Column(children: [
                      Text(
                          controller.avgLate.value.hour.toString().padLeft(2, '0') +
                              ":" +
                              controller.avgLate.value.minute.toString().padLeft(2, '0'),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Avg. Late By", style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                    ]),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return list[index];
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: 31),
          )
        ],
      ),
    );
  }

  getEachDayRow(DateTime now, int index) {
    var dt = DateTime(now.year, now.month, index + 1);
    var dayNum = DateFormat('dd').format(dt);
    var month = DateFormat('MMM').format(dt);
    var day = DateFormat('E').format(dt);
    // print("${dayNum + "-" + month + "-" + now.year.toString()}");
    // print(controller.historyList[presentDays.value]["date"]);
    var item = controller.isPresent("${dayNum + "-" + month + "-" + now.year.toString()}");
    var outTime = item.isNotEmpty ? item[0]["punchOutTime"] ?? "Not Marked" : "Mot Marked";
    var weeklyOff = listOfWeeklyOff.contains(day) ? "Weekly Off" : "";
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${dayNum}"),
                  Text("${month}"),
                  Text("${day}"),
                  // Text("May"),
                  // Text("Fri"),
                ],
              ),
            )),
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (!item.isEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              "Present ",
                              style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            (weeklyOff != "")
                                ? Text(
                                    " (" + weeklyOff + ")",
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800),
                                  )
                                : SizedBox()
                          ]),
                          Row(children: [
                            Text(
                              item[0]["punchInTime"] ?? "",
                              style: TextStyle(color: Colors.indigo),
                            ),
                            Text(" -> ", style: TextStyle(color: Colors.indigo)),
                            Text(outTime, style: TextStyle(color: (outTime.contains("Not")) ? Colors.red : Colors.indigo)),
                          ])
                        ],
                      )
                    : listOfWeeklyOff.contains(day)
                        ? Text(
                            "Weekly Off",
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800),
                          )
                        : controller.isAbsent(dt)
                            ? Text(
                                "Absent",
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
                              )
                            : Text("N/A"),
                // listOfWeeklyOff.contains(day) ? SizedBox() : ,
                // Text("Fri"),
              ],
            )),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:timeoffice/ModelPages/History/Comtroller/HistoryController.dart';

class HistoryPage extends GetWidget<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.needRefresh.value == true) controller.needRefresh.toggle();
      return reBuild();
    });
  }

  reBuild() {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.goPrev();
                      },
                      child: Text(
                        "<- Prev",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Month of: " + controller.recordMonthYear.value,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.goNext();
                      },
                      child: Text(
                        "next ->",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: SfRadialGauge(enableLoadingAnimation: true, axes: [
                  RadialAxis(
                    minimum: -120,
                    maximum: 120,
                    interval: 60,
                    pointers: [
                      NeedlePointer(
                        enableAnimation: true,
                        value: controller.gain.value.toDouble(),
                        needleColor: controller.gain.value >= 0 ? Colors.green : Colors.red,
                        knobStyle: KnobStyle(color: controller.gain.value >= 0 ? Colors.green : Colors.red),
                      ),
                    ],
                    ranges: [
                      controller.gain.value > 0
                          ? GaugeRange(
                              startValue: 0,
                              endValue: controller.gain.value.toDouble(),
                              color: Colors.green,
                            )
                          : GaugeRange(
                              startValue: controller.gain.value.toDouble(),
                              endValue: 0,
                              color: Colors.red,
                            )
                    ],
                    annotations: [
                      GaugeAnnotation(
                        widget: Text(
                          controller.gain.value.toString() + " Min",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: controller.gain.value >= 0 ? Colors.green : Colors.red),
                        ),
                        positionFactor: 0.8,
                        angle: 90,
                      )
                    ],
                  )
                ]),
              ),
              Visibility(
                visible: controller.historyList.length == 0 ? false : true,
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return widgetListItem(controller.historyList[index], controller);
                    },
                    itemCount: controller.historyList.length,
                  ),
                ),
              ),
              Visibility(
                  visible: controller.historyList.length == 0 ? true : false,
                  child: Expanded(
                    child: Center(
                      child: Text(
                        "No records found!!!",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

widgetListItem(item, HistoryController controller) => Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: BoxDecoration(
            color: (item['gain'] ?? "") == ""
                ? Colors.yellow.shade300
                : ((item['gain'] ?? "").toString().contains("-"))
                    ? Colors.red.shade300
                    : Colors.green.shade300,
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black.withOpacity(0.5)), borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item["date"],
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                              title: "Delete?",
                              middleText: "Do you want to delete the record?",
                              confirm: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red)),
                                  onPressed: () {
                                    controller.delete(item['date'] ?? "");
                                    Get.back();
                                    // HomeController homeController = Get.find();
                                    // homeController.needRefresh.value = true;
                                  },
                                  child: Text("YES")),
                              cancel: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Cancel")));
                        },
                        child: Icon(Icons.delete_forever))
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  height: 1,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Punch In :", style: TextStyle(color: Colors.black.withOpacity(0.5))),
                      Text(item["punchInTime"] ?? "", style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Punch Out :", style: TextStyle(color: Colors.black.withOpacity(0.5))),
                      Text(item["punchOutTime"] ?? "Not Marked",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: (item["punchOutTime"] ?? "") == "" ? Colors.red : Colors.black)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Gain :", style: TextStyle(color: Colors.black.withOpacity(0.5))),
                      Text(item["gain"] ?? "0", style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

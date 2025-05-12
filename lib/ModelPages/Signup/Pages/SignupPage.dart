import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:timeoffice/Consts/GlobalFunctions.dart';
import 'package:timeoffice/ModelPages/Signup/Comtroller/SignupController.dart';

class SignupPage extends GetWidget<SignupController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Please Provide the details.",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: controller.nameEdit,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                      label: Text("Your Name"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Your Name:"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  keyboardType: TextInputType.text,
                  enableInteractiveSelection: false,
                  controller: controller.inTimeEdit,
                  canRequestFocus: false,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    GlobalFunctions.choseTime(context, controller.inTimeEdit, 1);
                  },
                  decoration: InputDecoration(
                      label: Text("Minimum In Time"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter minimum in time:"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  keyboardType: TextInputType.text,
                  enableInteractiveSelection: false,
                  controller: controller.outTimeEdit,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    GlobalFunctions.choseTime(context, controller.outTimeEdit, 2);
                  },
                  canRequestFocus: false,
                  decoration: InputDecoration(
                      label: Text("Maximum Out Time"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter maximum out time:"),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: TextField(
              //     keyboardType: TextInputType.number,
              //     controller: controller.hourEdit,
              //     decoration: InputDecoration(
              //         label: Text("Working Hour"),
              //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              //         hintText: "Enter working hour:"),
              //   ),
              // ),
              ListTile(
                onTap: () async {
                  await Get.defaultDialog(
                      barrierDismissible: false,
                      title: "Please set the Working Hour",
                      titlePadding: EdgeInsets.all(30),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "   Hour",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 50),
                              Text(
                                "Minute",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          TimePickerSpinner(
                            is24HourMode: true,
                            time: controller.workingTime.value,
                            normalTextStyle: TextStyle(fontSize: 24, color: Colors.yellow),
                            highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.indigo),
                            spacing: 50,
                            itemHeight: 80,
                            isForce2Digits: true,
                            onTimeChange: (time) {
                              controller.workingTime.value = time;
                            },
                          ),
                          Obx(() => Text(
                              "Time ${controller.workingTime.value.hour.toString().padLeft(2, '0')} Hour : ${controller.workingTime.value.minute.toString().padLeft(2, '0')} Min"))
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              controller.updateWorkingHour();
                              Get.back();
                            },
                            child: Text("Ok"))
                      ]);
                },
                title: Text("Working Hour"),
                subtitle: Obx(() => Text(
                    "${controller.workingTime.value.hour.toString().padLeft(2, '0')} Hour : ${controller.workingTime.value.minute.toString().padLeft(2, '0')} Minutes")),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  Get.defaultDialog(
                      title: "Weekly Off",
                      content: Column(
                        children: [
                          for (var item in controller.listOfDays)
                            Obx(() => ListTile(
                                  title: Text(item.dayName.value),
                                  trailing: Icon(item.isSelected.value ? Icons.check : Icons.check_box_outline_blank),
                                  onTap: () {
                                    controller.updateIsSelected(item);
                                  },
                                ))
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              controller.updateSelectedDates();
                              Get.back();
                            },
                            child: Text("Ok"))
                      ]);
                },
                title: Text("Weekly Off"),
                subtitle: Obx(() => Text(controller.selectedDays.join(", "))),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      controller.updateData();
                    },
                    child: Center(child: Container(child: Text("Update"))),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

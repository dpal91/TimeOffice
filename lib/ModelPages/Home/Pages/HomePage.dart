import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeoffice/Consts/ApplicationRoutes.dart';
import 'package:timeoffice/Consts/GlobalFunctions.dart';
import 'package:timeoffice/ModelPages/Home/Comtroller/HomeController.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text("Time Office"),
            actions: [
              IconButton(
                  onPressed: () {
                    // SignupController signupController;
                    // try {
                    //   signupController = Get.put(SignupController());
                    // } catch (e) {
                    //   signupController = Get.find();
                    // }

                    Get.toNamed(ApplicationRoutes.Signup);
                  },
                  icon: Icon(Icons.person)),
              IconButton(
                  onPressed: () {
                    Get.toNamed(ApplicationRoutes.History);
                  },
                  icon: Icon(Icons.bar_chart))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text(
                        "Hello " + controller.userName.value + "!",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      child: Text("Current Time"),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: Colors.indigo),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey, offset: Offset(5.0, 5.0), blurRadius: 10, spreadRadius: 2),
                          BoxShadow(color: Colors.grey, offset: Offset(0.0, 5.0), blurRadius: 10, spreadRadius: 2),
                        ],
                      ),
                      height: 200,
                      width: 200,
                      child: Container(
                        child: AnalogClock(
                          // decoration: BoxDecoration(color: Colors.blue),

                          showAllNumbers: true,
                          showDigitalClock: false,
                          hourHandColor: Colors.grey.shade600,
                          minuteHandColor: Colors.grey.shade900,
                          // datetime: DateTime(2022, 1, 1, 11, 10, 10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          elevation: 10,
                        ),
                        onPressed: () {
                          controller.assignDateTimeNow();
                          Get.dialog(showPunchInDialog(context));
                        },
                        child: Container(
                          width: 200,
                          child: Center(
                            child: Text("Punch In"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          elevation: 10,
                        ),
                        onPressed: () {
                          controller.assignDateTimeNow();
                          Get.dialog(showPunchOutDialog(context));
                          // if (controller.isPunchedOut.value == true) {
                          //   Get.snackbar("Oops!", "You already punched out for today!",
                          //       snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green.shade300);
                          // } else
                          //   Get.defaultDialog(
                          //       title: "Punch Out?",
                          //       middleText: "Do you want to punch out now? ",
                          //       confirm: ElevatedButton(
                          //           onPressed: () {
                          //             print(controller.isPunchedOut.value);
                          //             controller.punchOut();
                          //           },
                          //           child: Text("Yes")),
                          //       cancel: TextButton(
                          //         onPressed: () {
                          //           Get.back();
                          //         },
                          //         child: Text("No"),
                          //         style: ButtonStyle(
                          //             backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200)),
                          //       ));
                        },
                        child: Container(
                          width: 200,
                          child: Center(
                            child: Text("Punch Out"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  showPunchInDialog(context) {
    controller.errorOut.value = controller.errorIn.value = '';
    return Obx(() => Dialog(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Punch In",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: controller.punchInDateController,
                      canRequestFocus: false,
                      enableInteractiveSelection: false,
                      onTap: () {
                        GlobalFunctions.selectDate(context, controller.punchInDateController);
                      },
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), labelText: "Date"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: controller.punchInTimeController,
                      canRequestFocus: false,
                      onChanged: (value) => controller.updatePunchInTime(),
                      enableInteractiveSelection: false,
                      onTap: () {
                        GlobalFunctions.choseTime(context, controller.punchInTimeController, 3, val: "in");
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Time",
                          errorText: controller.errorIn.value == "" ? null : controller.errorIn.value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancel"),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200))),
                        ElevatedButton(
                            onPressed: () {
                              controller.punchIn();
                            },
                            child: Text("Done"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  showPunchOutDialog(context) {
    controller.errorOut.value = controller.errorIn.value = '';
    return Obx(() => Dialog(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Punch Out",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: controller.punchInDateController,
                      canRequestFocus: false,
                      enableInteractiveSelection: false,
                      onTap: () {
                        GlobalFunctions.selectDate(context, controller.punchInDateController);
                      },
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), labelText: "Date"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextField(
                      controller: controller.punchInTimeController,
                      onChanged: (value) => controller.updatePunchOutTime(),
                      canRequestFocus: false,
                      enableInteractiveSelection: false,
                      onTap: () {
                        GlobalFunctions.choseTime(context, controller.punchInTimeController, 3, val: "out");
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Time",
                          errorText: controller.errorIn.value == "" ? null : controller.errorIn.value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancel"),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.grey.shade200))),
                        ElevatedButton(
                            onPressed: () {
                              controller.punchOut();
                            },
                            child: Text("Done"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

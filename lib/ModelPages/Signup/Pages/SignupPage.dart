import 'package:flutter/material.dart';
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), hintText: "Enter Your Name:"),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), hintText: "Enter minimum in time:"),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), hintText: "Enter maximum out time:"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller.hourEdit,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), hintText: "Enter working hour:"),
                ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeoffice/ModelPages/Splash/Comtroller/SplashController.dart';

class SplashPage extends GetWidget<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                "assets/anim.gif",
                height: 200,
                width: 200,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text("Version: 2.0.1"),
            ),
          )
        ],
      ),
    );
  }
}

/*

SfRadialGauge(axes: [
              RadialAxis(
                minimum: 0,
                maximum: 12,
                startAngle: 270,
                endAngle: 270,
                interval: 1,
                pointers: [
                  NeedlePointer(
                    enableAnimation: true,
                    value: controller.hr.value.toDouble(),
                    needleLength: 0.4,
                    needleStartWidth: 0,
                    needleEndWidth: 5,
                    needleColor: Colors.grey.shade500,
                    knobStyle: KnobStyle(
                      knobRadius: 0.04,
                    ),
                  ),
                  NeedlePointer(
                    enableAnimation: true,
                    value: controller.min.value.toDouble(),
                    needleStartWidth: 0,
                    needleEndWidth: 3,
                    needleColor: Colors.grey.shade800,
                    knobStyle: KnobStyle(knobRadius: 0.04),
                  ),
                ],
                ranges: [
                  // controller.gain.value > 0
                  //     ? GaugeRange(
                  //         startValue: 0,
                  //         endValue: controller.gain.value.toDouble(),
                  //         color: Colors.green,
                  //       )
                  //     : GaugeRange(
                  //         startValue: controller.gain.value.toDouble(),
                  //         endValue: 0,
                  //         color: Colors.red,
                  //       )
                ],
                // annotations: [
                //   GaugeAnnotation(
                //     widget: Text(
                //       controller.gain.value.toString() + " Min",
                //       style: TextStyle(
                //           fontSize: 20, fontWeight: FontWeight.w700, color: controller.gain.value >= 0 ? Colors.green : Colors.red),
                //     ),
                //     positionFactor: 0.4,
                //     angle: 90,
                //   )
                // ],
              )
            ])
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timeoffice/Consts/ApplicationRoutes.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TimeOffice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        tabBarTheme: TabBarTheme(
            // dividerColor: Colors.blue,
            labelColor: Colors.indigo,
            indicatorColor: Colors.indigo),
        useMaterial3: false,
      ),
      initialRoute: ApplicationRoutes.Splash,
      getPages: ApplicationRoutes.pages,
    );
  }
}

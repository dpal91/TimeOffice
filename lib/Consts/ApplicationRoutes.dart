import 'package:get/get_navigation/get_navigation.dart';
import 'package:timeoffice/ModelPages/History/Binding/HistoryBinding.dart';
import 'package:timeoffice/ModelPages/History/Pages/HistoryPage.dart';
import 'package:timeoffice/ModelPages/Home/Binding/HomeBinding.dart';
import 'package:timeoffice/ModelPages/Home/Pages/HomePage.dart';
import 'package:timeoffice/ModelPages/Signup/Binding/SignupBinding.dart';
import 'package:timeoffice/ModelPages/Signup/Pages/SignupPage.dart';
import 'package:timeoffice/ModelPages/Splash/Binding/SplashBinding.dart';
import 'package:timeoffice/ModelPages/Splash/Pages/SplashPage.dart';

class ApplicationRoutes {
  static const String Splash = "/";
  static const String Home = "/home";
  static const String Signup = "/signUp";
  static const String History = "/history";

  static List<GetPage<dynamic>> pages = [
    GetPage(name: Splash, page: () => SplashPage(), transition: Transition.rightToLeft, binding: SplashBinding()),
    GetPage(name: Signup, page: () => SignupPage(), transition: Transition.rightToLeft, binding: SignupBinding()),
    GetPage(name: Home, page: () => HomePage(), transition: Transition.rightToLeft, binding: HomeBinding()),
    GetPage(name: History, page: () => HistoryPage(), transition: Transition.rightToLeft, binding: HistoryBinding()),
  ];
}

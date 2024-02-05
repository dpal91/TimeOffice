import 'package:get_storage/get_storage.dart';

class ApplicationStorage {
  static const String UserName = "userName";
  static const String InTime = "inTime";
  static const String OutTime = "outTime";
  static const String WorkingHour = "workingHour";
  // static const String UseraName = "userName";

  static saveData(String key, dynamic value) {
    GetStorage().write(key, value);
  }

  static getData(String key) {
    return GetStorage().read(key);
  }
}

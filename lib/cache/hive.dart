import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveCache {
  static Box? modeBox;
  static Box? favBox;
  static Box? cartBox;
  static Box? users;

  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
  }

  static Future<Box> favoriteBoxFun(String favBoxName) async {
    return favBox = await Hive.openBox(favBoxName);
  }

  static Future<Box> cartBoxFun(String favBoxName) async {
    return cartBox = await Hive.openBox(favBoxName);
  }

  static Future<Box> modeBoxFun(String modeName) async {
    return modeBox = await Hive.openBox(modeName);
  }

  static Future<Box> usersBoxFun(String userBoxName) async {
    return users = await Hive.openBox(userBoxName);
  }
}

import 'package:e_commerce_app/cache/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit()
    : super(
        HiveCache.modeBox?.get("isDark", defaultValue: false)
            ? ThemeMode.dark
            : ThemeMode.light,
      );

  void toggle() {
    if (state == ThemeMode.dark) {
      HiveCache.modeBox?.put("isDark", false);
      emit(ThemeMode.light);
    } else {
      HiveCache.modeBox?.put("isDark", true);
      emit(ThemeMode.dark);
    }
  }
}

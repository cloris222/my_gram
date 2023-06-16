import 'package:base_project/constant/theme/global_data.dart';
import 'package:base_project/models/app_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalThemeProvider =
    StateNotifierProvider<GlobalThemeNotifier, ThemeMode>((ref) {
  return GlobalThemeNotifier();
});

class GlobalThemeNotifier extends StateNotifier<ThemeMode> {
  GlobalThemeNotifier() : super(ThemeMode.dark);

  void init() async {
    // _setSharePrf(await AppSharedPreferences.getTheme());
  }

  void flipMode() {
    if (state == ThemeMode.dark) {
      _setSharePrf(ThemeMode.light);
    } else {
      _setSharePrf(ThemeMode.dark);
    }
  }

  void _setSharePrf(ThemeMode mode) {
    AppSharedPreferences.setTheme(mode);
    GlobalData.isDark = (mode == ThemeMode.dark);

    state = mode;
  }
}

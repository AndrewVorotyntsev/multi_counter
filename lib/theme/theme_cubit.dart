import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Занеси эту папку в слой блоков
class ThemeCubit extends Cubit<ThemeData> {

  ThemeCubit() : super(_lightTheme);

  static bool isLight = true;

  static final _lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    if (isLight == true) {
      isLight = false;
    } else {
      isLight = true;
    }
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
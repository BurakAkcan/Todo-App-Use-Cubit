import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TemaCubit extends Cubit<ThemeData> {
  TemaCubit() : super(lighTheme);

  static final lighTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(color: Colors.amber),
  );
  static final darkTheme = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(color: Colors.indigo));

  void changeTheme() {
    emit(state.brightness == Brightness.light ? darkTheme : lighTheme);
  }
}

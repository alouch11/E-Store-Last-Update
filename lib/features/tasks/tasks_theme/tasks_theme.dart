import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';


class TasksMythemes {
  static final lightTheme = ThemeData(

    primaryColor: TasksColor.appcolor,
    primarySwatch: Colors.grey,
    textTheme: const TextTheme(),
    fontFamily: 'HindSiliguriRegular',
    scaffoldBackgroundColor: TasksColor.white,

    appBarTheme: AppBarTheme(
      iconTheme:  const IconThemeData(color: TasksColor.black),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: hsMedium.copyWith(
        color: TasksColor.black,
        fontSize: 16,
      ),
      color: TasksColor.transparent,
    ),
  );

  static final darkTheme = ThemeData(

    fontFamily: 'HindSiliguriRegular',
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: TasksColor.white),
      centerTitle: true,
      elevation: 0,
      titleTextStyle: hsMedium.copyWith(
        color: TasksColor.white,
        fontSize: 15,
      ),
      color: TasksColor.transparent,
    ),
  );
}
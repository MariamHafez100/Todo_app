import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/datetime.dart';

import '../dataClass/dataClass.dart';
import '../firebase_details.dart';

class appProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  String lang = 'en';
  late CalendarDateTime selectTime;

  List<Tasks> tasksList = [];

  void getTasksDataFromFire() async {
    QuerySnapshot<Tasks> querySnapshot = await FireBase.getCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    tasksList = tasksList.where((task) {
      if (selectTime.day == task.dateTime?.day &&
          selectTime.month == task.dateTime?.month &&
          selectTime.year == task.dateTime?.year) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  void changeDate(CalendarDateTime newDate) {
    selectTime = newDate;
    getTasksDataFromFire();
    notifyListeners();
  }

  void changeLanguage(String newlocale) {
    if (newlocale == lang) {
      return;
    }
    lang = newlocale;
    notifyListeners();
  }

  void changeTheme(ThemeMode newMood) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (appTheme == newMood) {
      //sharedPreferences.setBool('is_dark', false);
      //saveThemeMode(newMood as String);
      return;
    }
    appTheme = newMood;
    //sharedPreferences.setBool('is_dark', true);

    //saveThemeMode(appTheme as String);
    notifyListeners();
  }

  bool isdark() {
    return appTheme == ThemeMode.dark;
  }
}

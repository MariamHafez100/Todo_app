import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../dataClass/dataClass.dart';
import '../firebase_details.dart';

class appProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  String lang = 'en';
  DateTime selectTime = DateTime.now();

  List<Tasks> tasksList = [];

  void getTasksDataFromFire(String uId) async {
    QuerySnapshot<Tasks> querySnapshot =
        await FireBase.getCollection(uId).get();
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

    FirebaseFirestore.instance
        .collection('Tasks')
        .orderBy('dateTime', descending: true);
    //tasksList.sort(
    //         (Tasks task1 , Tasks task2){
    //          return task1.dateTime!.compareTo(task2.dateTime!);
    //         }
    //     );
  }

  void changeDate(DateTime newDate, String uId) {
    selectTime = newDate;
    getTasksDataFromFire(uId);
    //notifyListeners();
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

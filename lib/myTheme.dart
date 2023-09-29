import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xff5D9CEC);
  static Color grey = Color(0xff808285);
  static Color lightbg = Color(0xffaac2a7);
  static Color checkgreen = Color(0xff61E757);
  static Color myred = Color(0xffEC4B4B);
  static Color lightblack = Color(0xff363636);
  static Color blacky = Color(0xff303030);
  static Color blackblue = Color(0xff141922);
  static Color primarydark = Color(0xff060E1E);
  static Color darkgray = Color(0xff63666A);

  //static Color blueindarkmood = Color(0xff5D9CEC);

  static ThemeData lightTheme = ThemeData(
    primaryColor: Color(0xffffffff),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: MyTheme.primaryLight),
    ),
    scaffoldBackgroundColor: lightbg,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: primaryLight,
      unselectedItemColor: grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        )),
  );
  static ThemeData darkTheme = ThemeData(
    //datePickerTheme: DatePickerThemeData(backgroundColor: primaryLight),
    primaryColor: Color(0xff141922),
    //primaryColorDark:Color(0xff141922) ,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: MyTheme.primaryLight),
    ),
    scaffoldBackgroundColor: primarydark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: primaryLight,
      unselectedItemColor: Colors.white,
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff141922)),
    bottomAppBarTheme: BottomAppBarTheme(color: blackblue),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
    ),
    iconTheme: IconThemeData(color: Colors.white),

    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        )),
  );
}

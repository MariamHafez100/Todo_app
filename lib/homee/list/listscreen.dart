import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:provider/provider.dart';
import 'package:todo/homee/list/tasklist.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/providerapp.dart';

import '../../providers/auth_provider.dart';

class listTap extends StatefulWidget {
  @override
  State<listTap> createState() => _listTapState();
}

class _listTapState extends State<listTap> {
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context);
    var provider = Provider.of<appProvider>(context);
    if (provider.tasksList.isEmpty) {
      provider.getTasksDataFromFire(authprovider.currentUser!.id!);
    } //var provider = Provider.of<appProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.23,
              color: MyTheme.primaryLight,
            ),
            Container(
              margin: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  provider.changeDate(date, authprovider.currentUser!.id!);
                  this.setState(() => date);
                },
                //dayButtonColor: Colors.black,
                daysTextStyle: TextStyle(color: Colors.black),
                headerTitleTouchable: true,
                headerTextStyle: Theme.of(context).textTheme.titleLarge,
                //weekDayBackgroundColor: Colors.white,
                weekdayTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                selectedDayButtonColor: MyTheme.primaryLight,
                weekendTextStyle: TextStyle(
                  color: Colors.black,
                ),
                thisMonthDayBorderColor: MyTheme.primaryLight,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
                customDayBuilder: (
                  /// you can provide your own build function to make custom day containers
                  bool isSelectable,
                  int index,
                  bool isSelectedDay,
                  bool isToday,
                  bool isPrevMonthDay,
                  TextStyle textStyle,
                  bool isNextMonthDay,
                  bool isThisMonthDay,
                  DateTime day,
                ) {
                  /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                  /// This way you can build custom containers for specific days only, leaving rest as default.

                  // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                },
                weekFormat: true,
                //markedDatesMap: _markedDateMap,
                height: 160,
                selectedDateTime: provider.selectTime,
                daysHaveCircularBorder: true,

                /// null for not rendering any border, true for circular border, false for rectangular border
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TasksList(
                task: provider.tasksList[index],
              );
            },
            itemCount: provider.tasksList.length,
          ),
        )
      ],
    );
  }
}

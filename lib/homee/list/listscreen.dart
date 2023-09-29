import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:todo/homee/list/tasklist.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/providerapp.dart';

class listTap extends StatefulWidget {
  @override
  State<listTap> createState() => _listTapState();
}

class _listTapState extends State<listTap> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appProvider>(context);
    if (provider.tasksList.isEmpty) {
      provider.getTasksDataFromFire();
    }
    //var provider = Provider.of<appProvider>(context);

    return Column(
      children: [
        TimelineCalendar(
          calendarType: CalendarType.GREGORIAN,
          //onInit: () => provider.selectTime,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.black26,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
              //weekDayUnselectedColor: CupertinoColors.destructiveRed,
              dayFontSize: 18,
              //todayBackgroundColor: MyTheme.myred,
              weekDayUnselectedColor: Colors.black,
              disabledTextColor: MyTheme.darkgray,
              //unselectedTextColor: MyTheme.grey,
              compactMode: true,
              weekDaySelectedColor: MyTheme.primaryLight,
              disableDaysBeforeNow: true),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.FULL,
              backgroundColor: MyTheme.primaryLight,
              headerTextColor: Colors.black),

          onChangeDateTime: (datetime) {
            //provider.changeDate(datetime);
            print(datetime.getDate());
          },
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

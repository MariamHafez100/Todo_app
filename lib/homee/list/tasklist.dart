import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/dataClass/dataClass.dart';
import 'package:todo/firebase_details.dart';
import 'package:todo/homee/list/editList.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/providerapp.dart';

import '../../providers/auth_provider.dart';

class TasksList extends StatefulWidget {
  Tasks task;

  TasksList({required this.task});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context);

    var provider = Provider.of<appProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditList.routeName,
            arguments: Tasks(
                title: widget.task.title,
                decription: widget.task.decription,
                dateTime: widget.task.dateTime,
                id: widget.task.id));
      },
      child: widget.task.Done == true
          ? Container(
        margin:
        EdgeInsets.all(MediaQuery.of(context).size.height * 0.020),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(25),
                onPressed: (context) {
                  FireBase.DeleteTask(
                                widget.task, authprovider.currentUser!.id!)
                            .timeout(Duration(milliseconds: 200),
                                onTimeout: () {
                          print('Deleted');
                          provider.getTasksDataFromFire(
                              authprovider.currentUser!.id!);
                        });
                },
                backgroundColor: MyTheme.myred,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            //padding: EdgeInsets.all(10),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).primaryColor,
            ),

            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 100,
                    child: VerticalDivider(
                      color: MyTheme.checkgreen,
                      thickness: 6,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.task.title ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                color: MyTheme.checkgreen,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox.square(
                        dimension:
                        MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.task.decription ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                fontSize: 16,
                                color: MyTheme.checkgreen),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: Text(
                      'DONE !',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: MyTheme.checkgreen),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
          : Container(
        margin:
        EdgeInsets.all(MediaQuery.of(context).size.height * 0.020),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                onPressed: (context) {
                  FireBase.DeleteTask(
                                widget.task, authprovider.currentUser!.id!)
                            .timeout(Duration(milliseconds: 200),
                                onTimeout: () {
                          print('Deleted');
                          provider.getTasksDataFromFire(
                              authprovider.currentUser!.id!);
                        });
                },
                backgroundColor: MyTheme.myred,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            //padding: EdgeInsets.all(10),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).primaryColor,
            ),

            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 100,
                    child: VerticalDivider(
                      color: MyTheme.primaryLight,
                      thickness: 6,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.alarm),
                          Text(
                            widget.task.title ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                color: MyTheme.primaryLight,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox.square(
                        dimension:
                        MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.task.decription ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.primaryLight),
                      //style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        widget.task.Done = true;

                        setState(() {});
                      },
                      child: Icon(
                        Icons.check,
                        size: 40,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

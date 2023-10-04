import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/alert_dialog.dart';
import 'package:todo/dataClass/dataClass.dart';
import 'package:todo/firebase_details.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/providerapp.dart';

import '../providers/auth_provider.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime chosen = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String dec = '';
  late appProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<appProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(AppLocalizations.of(context)!.add_task,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            Form(
                key: formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: AppLocalizations.of(context)!.tile,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 15),
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter the task';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        dec = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: AppLocalizations.of(context)!.description,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 15),
                      ),
                      maxLines: 4,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter the description';
                        }
                        return null;
                      },
                    ),
                    InkWell(
                      onTap: () {
                        showTime();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          AppLocalizations.of(context)!.selected_time,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        "${chosen.day}/${chosen.month}/${chosen.year}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: MyTheme.grey, fontSize: 18),
                      ),
                    ),
                    //Spacer(),
                    FloatingActionButton(
                      shape: CircleBorder(),
                      onPressed: () {
                        addTask();
                      },
                      child: Icon(Icons.check),
                    )
                    //Spacer(),
                  ],
                )),
            //Spacer(),
          ],
        ),
      ),
    );
  }

  void showTime() async {
    var result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 670)));
    if (result != null) {
      chosen = result;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Tasks task = Tasks(title: title, decription: dec, dateTime: chosen);
      // lw .then yb2a sh8len ll online w esm3e el 7eta de tane
      AlertDetails.showLoading(context, 'Loading...');
      var authprovider = Provider.of<AuthProvider>(context, listen: false);

      FireBase.AddTodoTask(task, authprovider.currentUser!.id!).then((value) {
        AlertDetails.hideLoading(context);
        Fluttertoast.showToast(
            msg: "YOU ADDED A NEW TASK SUCCESSFULLY",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: MyTheme.primaryLight,
            textColor: Colors.white,
            fontSize: 18.0);
        Navigator.pop(context);
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        provider.getTasksDataFromFire(authprovider.currentUser!.id!);
        print('Task added successfully');
        Navigator.pop(context);
      });
    }
  }
}

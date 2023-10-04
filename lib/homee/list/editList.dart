import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/dataClass/dataClass.dart';
import 'package:todo/firebase_details.dart';
import 'package:todo/providers/providerapp.dart';

import '../../myTheme.dart';
import '../../providers/auth_provider.dart';

class EditList extends StatefulWidget {
  static String routeName = 'edit List';

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  //late Tasks task = Tasks(title: '',decription: '',dateTime: chosen); // Initialize the task variable
  DateTime chosen = DateTime.now();
  String title = '';
  String dec = '';

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Tasks oldTask = ModalRoute.of(context)?.settings.arguments as Tasks;
    var authprovider = Provider.of<AuthProvider>(context);

    var provider = Provider.of<appProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        //toolbarHeight: MediaQuery.of(context).size.height*0.17,
        title: Text(
          'TODO LIST',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: MyTheme.primaryLight,
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor,
              ),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.height * 0.05,
                  right: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.05),
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                              hintText:
                                  AppLocalizations.of(context)!.description,
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
                          Text(
                            "${chosen.day}/${chosen.month}/${chosen.year}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: MyTheme.grey, fontSize: 18),
                          ),
                          //Spacer(),
                          SizedBox(
                            height: 90,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() == true) {
                                //print("Task ID: ${oldTask.id}");
                                if (oldTask.id != null &&
                                    oldTask.id!.isNotEmpty) {
                                  var taskCollection = FireBase.getCollection(
                                      authprovider.currentUser!.id!);
                                  var docRef = taskCollection.doc(oldTask.id);

                                  docRef.update({
                                    'title': title,
                                    // Update the 'title' field
                                    'description': dec,
                                    // Update the 'description' field
                                  }).timeout(Duration(milliseconds: 500),
                                      onTimeout: () {
                                    provider.getTasksDataFromFire(
                                        authprovider.currentUser!.id!);
                                    print('Task is EDITED');
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.save,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          )
                          //Spacer(),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
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
    if (formKey.currentState?.validate() == true) {}
  }
}

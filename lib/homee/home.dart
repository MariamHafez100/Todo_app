import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/authurization/login.dart';
import 'package:todo/homee/editbottomsheet.dart';
import 'package:todo/homee/settings/settingscreen.dart';

import '../providers/auth_provider.dart';
import '../providers/providerapp.dart';
import 'list/listscreen.dart';

class homescreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authprovider = Provider.of<AuthProvider>(context, listen: false);
    var provider = Provider.of<appProvider>(context);

    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: MediaQuery.of(context).size.height*0.17,
        title: Text(
          '${AppLocalizations.of(context)!.app_title} ${authprovider.currentUser!.name}',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                provider.tasksList = [];
                authprovider.currentUser = null;
                Navigator.pushReplacementNamed(context, Login.routeName);
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list_sharp), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Tabs[selectedIndex],
    );
  }

  List<Widget> Tabs = [
    listTap(),
    settingTap(),
  ];

  void showSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        context: context,
        builder: (context) => AddBottomSheet());
  }
}

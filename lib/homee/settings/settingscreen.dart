import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/providerapp.dart';

class settingTap extends StatefulWidget {
  @override
  State<settingTap> createState() => _settingTapState();
}

class _settingTapState extends State<settingTap> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appProvider>(context);

    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.mood,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                      provider.changeTheme(ThemeMode.light);
                      setState(() {});
                    },
                    child: Icon(Icons.sunny)),
                ElevatedButton(
                    onPressed: () {
                      provider.changeTheme(ThemeMode.dark);
                      setState(() {});
                    },
                    child: Icon(Icons.dark_mode_sharp)),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                      provider.changeLanguage('en');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.english,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                ElevatedButton(
                    onPressed: () {
                      provider.changeLanguage('ar');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.arabic,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

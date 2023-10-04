import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/authurization/login.dart';
import 'package:todo/authurization/register.dart';
import 'package:todo/homee/home.dart';
import 'package:todo/homee/list/editList.dart';
import 'package:todo/myTheme.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/providers/providerapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  // Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  //await Firebase.initializeApp();

  // final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => appProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<appProvider>(context);
    return MaterialApp(
      initialRoute: Login.routeName,
      routes: {
        homescreen.routeName: (context) => homescreen(),
        EditList.routeName: (context) => EditList(),
        Register.routeName: (context) => Register(),
        Login.routeName: (context) => Login(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.appTheme,
      locale: Locale(provider.lang),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

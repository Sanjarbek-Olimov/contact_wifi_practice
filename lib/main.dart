import 'package:contact_wifi/pages/contact/contact_access_page.dart';
import 'package:contact_wifi/pages/contact/phone_contact_page.dart';
import 'package:contact_wifi/pages/home_page.dart';
import 'package:contact_wifi/pages/lifecycle_page.dart';
import 'package:contact_wifi/pages/loadmore/load_more_auto.dart';
import 'package:contact_wifi/pages/loadmore/load_more_button.dart';
import 'package:contact_wifi/pages/loadmore/load_more_pages.dart';
import 'package:contact_wifi/pages/wifi/new_wifi_page.dart';
import 'package:contact_wifi/pages/wifi/wifi_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        WifiPage.id: (context) => WifiPage(),
        PhoneContactPage.id: (context) =>PhoneContactPage(),
        ContactAccessPage.id: (context) => ContactAccessPage(),
        NewWifiPage.id: (context) => NewWifiPage(),
        LoadButtonPage.id: (context) => LoadButtonPage(),
        LoadMorePage.id: (context) => LoadMorePage(),
        LoadAutoPage.id: (context) => LoadAutoPage(),
        LifeCyclePage.id: (context) =>LifeCyclePage()
      },
    );
  }
}
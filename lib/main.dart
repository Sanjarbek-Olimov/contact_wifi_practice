import 'package:contact_wifi/pages/contact_access_page.dart';
import 'package:contact_wifi/pages/contact_page.dart';
import 'package:contact_wifi/pages/home_page.dart';
import 'package:contact_wifi/pages/phone_contact_page.dart';
import 'package:contact_wifi/pages/wifi_page.dart';
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
        ContactPage.id: (context) => ContactPage(),
        WifiPage.id: (context) => WifiPage(),
        PhoneContactPage.id: (context) =>PhoneContactPage(),
        ContactAccessPage.id: (context) => ContactAccessPage()
      },
    );
  }
}
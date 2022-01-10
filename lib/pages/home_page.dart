import 'package:contact_wifi/pages/lifecycle_page.dart';
import 'package:contact_wifi/pages/loadmore/load_more_pages.dart';
import 'package:contact_wifi/pages/wifi/new_wifi_page.dart';
import 'package:contact_wifi/pages/wifi/wifi_page.dart';
import 'package:flutter/material.dart';

import 'contact/phone_contact_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              shape: const StadiumBorder(),
              height: 50,
              minWidth: 150,
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, PhoneContactPage.id);
              },
            child: const Text("Contacts", style: TextStyle(color: Colors.white, fontSize: 20),),),
            const SizedBox(height: 20,),
            MaterialButton(
              shape: const StadiumBorder(),
              height: 50,
              minWidth: 150,
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, WifiPage.id);
              },
            child: Text("Wi-Fi", style: const TextStyle(color: Colors.white, fontSize: 20),),),
            const SizedBox(height: 20,),
            MaterialButton(
              shape: const StadiumBorder(),
              height: 50,
              minWidth: 150,
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, NewWifiPage.id);
              },
              child: const Text("New Wi-Fi", style: TextStyle(color: Colors.white, fontSize: 20),),),
            const SizedBox(height: 20,),
            MaterialButton(
              shape: const StadiumBorder(),
              height: 50,
              minWidth: 150,
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, LoadMorePage.id);
              },
              child: const Text("Load more", style: TextStyle(color: Colors.white, fontSize: 20),),),
            const SizedBox(height: 20,),
            MaterialButton(
              shape: const StadiumBorder(),
              height: 50,
              minWidth: 150,
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, LifeCyclePage.id);
              },
              child: const Text("Lifecycle", style: TextStyle(color: Colors.white, fontSize: 20),),),
          ],
        ),
      ),
    ));
  }
}

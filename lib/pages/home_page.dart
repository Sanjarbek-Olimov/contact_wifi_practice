import 'package:contact_wifi/pages/contact_page.dart';
import 'package:contact_wifi/pages/phone_contact_page.dart';
import 'package:contact_wifi/pages/wifi_page.dart';
import 'package:flutter/material.dart';

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
        title: Text("Home", style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              shape: StadiumBorder(),
              height: 50,
              minWidth: 150,
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, PhoneContactPage.id);
              },
            child: Text("Contacts", style: TextStyle(color: Colors.white, fontSize: 20),),),
            SizedBox(height: 20,),
            MaterialButton(
              shape: StadiumBorder(),
              height: 50,
              minWidth: 150,
              color: Colors.blue,
              onPressed: (){
                Navigator.pushNamed(context, WifiPage.id);
              },
            child: Text("Wi-Fi", style: TextStyle(color: Colors.white, fontSize: 20),),),
          ],
        ),
      ),
    ));
  }
}

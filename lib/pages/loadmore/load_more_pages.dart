import 'package:contact_wifi/pages/loadmore/load_more_auto.dart';
import 'package:flutter/material.dart';
import 'load_more_button.dart';

class LoadMorePage extends StatefulWidget {
  static const String id = "load_more_page";

  const LoadMorePage({Key? key}) : super(key: key);

  @override
  _LoadMorePageState createState() => _LoadMorePageState();
}

class _LoadMorePageState extends State<LoadMorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "List more",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              height: 50,
              shape: StadiumBorder(),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoadButtonPage.id);
              },
            child: Text("Load more list with button", style: TextStyle(fontSize: 20, color: Colors.white),),

            ),
            SizedBox(height: 15,),
            MaterialButton(
              height: 50,
              shape: StadiumBorder(),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoadAutoPage.id);
              },
            child: Text("Load more list automatically", style: TextStyle(fontSize: 20, color: Colors.white),),

            ),
          ],
        ),
      ),
    ));
  }
}

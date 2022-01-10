import 'dart:async';

import 'package:flutter/material.dart';

class LifeCyclePage extends StatefulWidget {
  static const String id = "life_cycle_page";

  const LifeCyclePage({Key? key}) : super(key: key);

  @override
  _LifeCyclePageState createState() => _LifeCyclePageState();
}

class _LifeCyclePageState extends State<LifeCyclePage> with WidgetsBindingObserver {
  late Timer timer;
  int count = 0;
  bool isActive = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (isActive) {
        setState(() {
          count += 1;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      isActive = true;
      print("Resumed");
    }else if(state==AppLifecycleState.inactive){
      isActive = false;
      print("Inactive");
    } else if(state==AppLifecycleState.detached){
      print("Detached");
    } else if (state == AppLifecycleState.paused){
      isActive = false;
      print("Paused");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("App Lifecycle"),
        centerTitle: true,
      ),
      body: Center(
        child: Text('$count', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),),
      ),
    ));
  }
}

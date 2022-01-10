import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';

class NewWifiPage extends StatefulWidget {
  static const String id = "new_wifi_page";

  const NewWifiPage({Key? key}) : super(key: key);

  @override
  _NewWifiPageState createState() => _NewWifiPageState();
}

class _NewWifiPageState extends State<NewWifiPage> {
  List<WifiNetwork> _listWifi = [];
  bool _isEnabled = false;
  bool _isConnected = false;
  String ssid = "";
  bool _indicator = true;

  @override
  void initState() {
    super.initState();
    getWifi();
  }

  Future<void> _viewIndicator() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _indicator = false;
    });
  }

  Future<void> getWifi() async {
    setState(() async {
      _isEnabled = await WiFiForIoTPlugin.isEnabled();
      _isConnected = await WiFiForIoTPlugin.isConnected();
      _listWifi = await loadWifi();
    });
    if(_isConnected){
      await WiFiForIoTPlugin.getSSID().then((value) {
        setState(() {
         ssid = value??"";
        });
      });
    }
  }

  Future<List<WifiNetwork>> loadWifi() async {
    List<WifiNetwork> list;
    try {
      list = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      list = <WifiNetwork>[];
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wi-Fi"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          Switch(
              activeColor: Colors.white,
              value: _isEnabled,
              onChanged: (value) {
                if(_isEnabled){
                  WiFiForIoTPlugin.setEnabled(false);
                  _viewIndicator();
                } else {
                  WiFiForIoTPlugin.setEnabled(true);
                  getWifi();
                  _indicator = true;
                }
                setState(() {
                  _isEnabled = !_isEnabled;
                });
              }),
        ],
      ),
      body: _isEnabled&&!_indicator?ListView.builder(
          itemCount: _listWifi.length,
          itemBuilder: (context, index) {
            return itemOfList(index);
          })
          :_isEnabled&&_indicator?Container(
        padding: EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Turning on...", style: TextStyle(fontSize: 18),),
              SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ))
            ]),
      ):
      const Center(
      child: Text(
      "To see available networks, turn on Wi-Fi",
      style: TextStyle(fontSize: 16),
    )),
    );
  }

  Widget itemOfList(index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 10,
      child: ListTile(
        title: Text(_listWifi[index].ssid??"No name"),
        leading: Icon(Icons.wifi_lock_outlined),
      ),
    );
  }
}

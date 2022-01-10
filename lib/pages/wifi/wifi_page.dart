import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WifiPage extends StatefulWidget {
  static const String id = "wifi_page";

  const WifiPage({Key? key}) : super(key: key);

  @override
  _WifiPageState createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  bool _switchValue = false;
  bool _indicator = true;
  String _switchWord = "Off";

  List<String> wifi = [
    'Alibaba',
    'Ebay',
    'Microsoft',
    'PDP Academy',
    'PDP Academy 5G',
    'Cisco',
    'Free'
  ];

  Future<void> _viewIndicator() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _indicator = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wi-Fi",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          Center(
              child: Text(
            _switchWord,
            style: TextStyle(fontSize: 16),
          )),
          Switch(
            value: _switchValue,
            activeColor: Colors.white,
            onChanged: (value) {
              setState(() {
                _switchValue = value;
                if (_switchValue) {
                  _switchWord = "On";
                  _viewIndicator();
                } else {
                  _switchWord = "Off";
                  _indicator = true;
                }
              });
            },
          )
        ],
      ),
      body:
      // available networks
      _switchValue && !_indicator
          ? ListView.builder(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        itemCount: wifi.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemWifi(index);
        },
      )

      // searching networks
          : _switchValue && _indicator
              ? Container(
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
              )
      // turn on text
              : const Center(
                  child: Text(
                  "To see available networks, turn on Wi-Fi",
                  style: TextStyle(fontSize: 16),
                )),
    ));
  }

  Widget _itemWifi(int index) {
    return Card(
      child: ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.all(10),
          title: Text(
            wifi[index],
            style: const TextStyle(fontSize: 20),
          ),
          trailing: Container(
            width: 100,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Icon(
                  Icons.lock,
                  color: Colors.black,
                  size: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.wifi,
                  color: Colors.black,
                ),
              ],
            ),
          )),
    );
  }
}

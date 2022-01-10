import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadAutoPage extends StatefulWidget {
  static const String id = "load_auto_page";

  const LoadAutoPage({Key? key}) : super(key: key);

  @override
  _LoadAutoPageState createState() => _LoadAutoPageState();
}

class _LoadAutoPageState extends State<LoadAutoPage> {
  List myList = [];
  List<Contact> contact = [];
  List contacts = [];
  ScrollController _scrollController = ScrollController();
  int _currentMax = 20;
  List colors = Colors.primaries;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    contact = await ContactsService.getContacts();
    contacts = contact.where((element) => element.phones!.isNotEmpty).toList();
    setState(() {
      myList = List.generate(20, (i) => contacts.elementAt(i));
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    for (int i = _currentMax; i < _currentMax + 20; i++) {
      if (i == contacts.length) {
        break;
      } else {
        myList.add(contacts[i]);
      }
    }
    if (myList.length - _currentMax < 20) {
      _currentMax = contacts.length;
    } else {
      _currentMax = _currentMax + 20;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("List More Auto"),
        centerTitle: true,
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemHorizontalContacts(index);
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: contacts.length > _currentMax
                ? myList.length + 1
                : myList.length,
            itemBuilder: (context, index) {
              if (index == myList.length) {
                return const Center(child: CircularProgressIndicator());
              }
              return _itemContacts(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _itemHorizontalContacts(int index) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.17,
      onPressed: () {
        launch("tel://${contacts.elementAt(index).phones!.first.value}");
      },
      padding: EdgeInsets.zero,
      child: Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: colors[index % 18],
                maxRadius: MediaQuery.of(context).size.width * 0.07,
                child: Text(
                  contacts.elementAt(index).initials(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                  child: Text(
                contacts.elementAt(index).displayName ?? "No name",
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 13),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
              )),
            ],
          )),
    );
  }

  Widget _itemContacts(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors[index % 18],
          minRadius: 25,
          maxRadius: 25,
          child: Text(
            myList.elementAt(index).initials(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        title: Text(
          myList.elementAt(index).displayName ?? "No name",
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(myList.elementAt(index).phones!.first.value.toString()),
        trailing: IconButton(
          icon: Icon(
            Icons.phone,
            color: Colors.greenAccent[400],
            size: 25,
          ),
          onPressed: () {
            launch("tel://${myList.elementAt(index).phones!.first.value}");
          },
        ),
      ),
    );
  }
}

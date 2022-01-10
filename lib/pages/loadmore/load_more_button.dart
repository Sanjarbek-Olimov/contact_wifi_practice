import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadButtonPage extends StatefulWidget {
  static const String id = "lazy_load_page";

  const LoadButtonPage({Key? key}) : super(key: key);

  @override
  _LoadButtonPageState createState() => _LoadButtonPageState();
}

class _LoadButtonPageState extends State<LoadButtonPage> {
  int present = 0;
  int perPage = 20;

  List<Contact> originalItems = [];
  List<Contact> items = [];
  List colors = Colors.accents;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    Iterable<Contact> contact = await ContactsService.getContacts();
    setState(() {
      originalItems =
          contact.where((element) => element.phones!.isNotEmpty).toList();
      items.addAll(originalItems.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  void _loadMoreData() {
    setState(() {
      if ((present + perPage) > originalItems.length) {
        items.addAll(originalItems.getRange(present, originalItems.length));
      } else {
        items.addAll(originalItems.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("List More with Button"),
        centerTitle: true,
      ),
      body: ListView(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: originalItems.length,
            itemBuilder: (BuildContext context, int index) {
              return _itemHorizontalContacts(index);
            },
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: (present <= originalItems.length)
              ? items.length + 1
              : items.length,
          itemBuilder: (context, index) {
            return items.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (index == items.length)
                    ? Container(
                        color: Colors.greenAccent,
                        child: MaterialButton(
                          child: const Text("Load More"),
                          onPressed: _loadMoreData,
                        ),
                      )
                    : _itemContacts(index);
          },
        ),
      ]),
    );
  }

  Widget _itemHorizontalContacts(int index) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.17,
      onPressed: () {
        launch("tel://${originalItems.elementAt(index).phones!.first.value}");
      },
      padding: EdgeInsets.zero,
      child: Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: colors[index % 16],
                maxRadius: MediaQuery.of(context).size.width * 0.07,
                child: Text(
                  originalItems.elementAt(index).initials(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                  child: Text(
                originalItems.elementAt(index).displayName ?? "No name",
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
          backgroundColor: colors[index % 16],
          minRadius: 25,
          maxRadius: 25,
          child: Text(
            items.elementAt(index).initials(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        title: Text(
          items.elementAt(index).displayName ?? "No name",
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(items.elementAt(index).phones!.first.value.toString()),
        trailing: IconButton(
          icon: Icon(
            Icons.phone,
            color: Colors.greenAccent[400],
            size: 25,
          ),
          onPressed: () {
            launch("tel://${items.elementAt(index).phones!.first.value}");
          },
        ),
      ),
    );
  }
}

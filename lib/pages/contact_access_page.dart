import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactAccessPage extends StatefulWidget {
  static const String id = "contact_access_page";

  const ContactAccessPage({Key? key}) : super(key: key);

  @override
  _ContactAccessPageState createState() => _ContactAccessPageState();
}

class _ContactAccessPageState extends State<ContactAccessPage> {
  Iterable<Contact> _contacts = [];
  List<Color> colors = Colors.accents;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    Iterable<Contact> contact = await ContactsService.getContacts();
    setState(() {
      _contacts = contact.where((element) => element.phones!.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        // floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: const Text(
              "Contacts",
              style: TextStyle(fontSize: 25),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ),
        ],
        body:ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return _itemHorizontalContacts(index);
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: _contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemContacts(index);
              },
            ),
          ],
        ),
      ),
    ));
  }


  Widget _itemHorizontalContacts(int index) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.2,
      onPressed: () {
        launch("tel://${_contacts.elementAt(index).phones!.first.value}");
      },
      padding: EdgeInsets.zero,
      child: Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: colors[index%16],
                maxRadius: MediaQuery.of(context).size.width * 0.078,
                child: Text(
                  _contacts.elementAt(index).initials(),
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Flexible(
                  child: Text(
                _contacts.elementAt(index).displayName ?? "No name",
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
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
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundColor: colors[index%16],
          minRadius: 40,
          maxRadius: 40,
          child: Text(
            _contacts.elementAt(index).initials(),
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        title: Text(
          _contacts.elementAt(index).displayName ?? "No name",
          style: const TextStyle(fontSize: 18),
        ),
        subtitle: Text(_contacts.elementAt(index).phones!.first.value.toString()),
        trailing: IconButton(
          icon: Icon(
            Icons.phone,
            color: Colors.greenAccent[400],
            size: 30,
          ),
          onPressed: () {
            launch("tel://${_contacts.elementAt(index).phones!.first.value}");
          },
        ),
      ),
    );
  }
}

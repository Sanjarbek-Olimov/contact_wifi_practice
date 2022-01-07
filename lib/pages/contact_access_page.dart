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


  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
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
            body: ListView.builder(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 20),
                    itemCount: _contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _itemContacts(index);
                    },
                  )
                ));
  }

  Widget _itemContacts(int index) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          minRadius: 50,
          maxRadius: 50,
          child: Text(
            _contacts.elementAt(index).initials(),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        title: Text(
          _contacts.elementAt(index).displayName ?? '',
        ),
        subtitle: Text(
          _contacts.elementAt(index).phones!.first.value.toString(),
        ),
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

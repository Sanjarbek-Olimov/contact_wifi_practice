import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts {
  late String name;
  late String number;

  Contacts({required this.name, required this.number});
}

class ContactPage extends StatefulWidget {
  static const String id = "contact_page";

  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  List<Color> colors = [
    Colors.blue,
    Colors.greenAccent,
    Colors.pink,
    Colors.deepPurpleAccent,
    Colors.redAccent
  ];

  List<Contacts> contacts = [
    Contacts(name: "Sardorbek", number: "+998907997720"),
    Contacts(name: "Javlonbek", number: "+998908175292"),
    Contacts(name: "Fayozbek", number: "+998930000342"),
    Contacts(name: "Ravshanbek", number: "+998916321198"),
    Contacts(name: "Abdurahmon", number: "+998935869679"),
  ];
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
          style: const TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20),
        itemCount: contacts.length,
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
          backgroundColor: colors[index],
          minRadius: 50,
          maxRadius: 50,
          child: Text(
            contacts[index].name.substring(0,1),
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
        title: Text(
            contacts[index].name,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(contacts[index].number,),
        trailing: IconButton(
          icon: Icon(
            Icons.phone,
            color: Colors.greenAccent[400],
            size: 30,
          ),
          onPressed: () {
            launch("tel://${contacts[index].number}");
          },
        ),
      ),
    );
  }
}

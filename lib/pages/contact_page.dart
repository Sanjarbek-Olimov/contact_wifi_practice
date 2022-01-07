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
  List<Color> colors = Colors.accents;

  List<Contacts> contacts = [
    Contacts(name: "Sardorbek", number: "+998907997720"),
    Contacts(name: "Javlonbek", number: "+998908175292"),
    Contacts(name: "Fayozbek", number: "+998930000342"),
    Contacts(name: "Ravshanbek", number: "+998916321198"),
    Contacts(name: "Abdurahmon", number: "+998935869679"),
    Contacts(name: "Jamshidbek", number: "+998970046578"),
    Contacts(name: "USSD Balans", number: "*100#"),
    Contacts(name: "Ambulance", number: "*103#"),
    Contacts(name: "Police", number: "*102#"),
    Contacts(name: "Fire Brigade", number: "*101#"),
  ];

  @override
  Widget build(BuildContext context) {
    contacts.sort((a, b) => a.name.compareTo(b.name));
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        // floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) =>[
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
        body: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return _itemHorizContacts(index);
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemContacts(index);
              },
            ),
          ],
        ),
      ),
    ));
  }

  Widget _itemHorizContacts(int index) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width*0.2,
      onPressed: () {
        launch("tel://${contacts[index].number}");
      },
      padding: EdgeInsets.zero,
      child: Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: colors[index],
                maxRadius: MediaQuery.of(context).size.width*0.078,
                child: Text(
                  contacts[index].name.substring(0, 1),
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Flexible(
                  child: Text(
                contacts[index].name,
                style: TextStyle(fontWeight: FontWeight.normal),
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
          backgroundColor: colors[index],
          minRadius: 40,
          maxRadius: 40,
          child: Text(
            contacts[index].name.substring(0, 1),
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        title: Text(
          contacts[index].name,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          contacts[index].number,
        ),
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

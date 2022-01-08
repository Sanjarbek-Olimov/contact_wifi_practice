import 'package:contact_wifi/pages/contact_access_page.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'contact_page.dart';

class PhoneContactPage extends StatefulWidget {
  static const String id = "phone_contact_page";
  Iterable<Contact> _contacts = [];

  Iterable<Contact> get phoneContact => _contacts;

  PhoneContactPage({Key? key}) : super(key: key);


  @override
  _PhoneContactPageState createState() => _PhoneContactPageState();
}

class _PhoneContactPageState extends State<PhoneContactPage> {




  //Check contacts permission
  @override
  void initState() {
    super.initState();
    _askPermissions(null);
    // _getContacts();
  }

  Future<void> _getContacts() async{
    widget._contacts = await ContactsService.getContacts();
    setState(() {
      widget._contacts = widget._contacts.where((element) => element.givenName!=null&&element.phones!.first.value!=null);
    });
  }

  Future<void> _askPermissions(String? routeName) async{
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushReplacementNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: const Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
      SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
      body: Center(
        child: MaterialButton(
          shape: const StadiumBorder(),
          height: 50,
          color: Colors.lightBlueAccent,
          onPressed: () {
            _askPermissions(ContactAccessPage.id);
          },
          child: const Text('See Contacts', style: TextStyle(fontSize: 20, color: Colors.white),),
        ),
      ),
    ));
  }
}

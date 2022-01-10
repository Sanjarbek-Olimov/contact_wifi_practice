import 'package:contact_wifi/pages/contact/contact_access_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneContactPage extends StatefulWidget {
  static const String id = "phone_contact_page";

  const PhoneContactPage({Key? key}) : super(key: key);

  @override
  _PhoneContactPageState createState() => _PhoneContactPageState();
}

class _PhoneContactPageState extends State<PhoneContactPage> {
  //Check contacts permission
  @override
  void initState() {
    super.initState();
    _askPermissions(null);
  }

  Future<void> _askPermissions(String? routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
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
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Contacts", style: TextStyle(fontSize: 25),),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){},
            ),
          ),
            body: Center(
      child: MaterialButton(
        height: 50,
        shape: StadiumBorder(),
        color: Colors.blueAccent,
        onPressed: () => _askPermissions(ContactAccessPage.id),
        child: Text("See device contacts", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
    )));
  }
}

import 'package:contact_wifi/pages/contact_access_page.dart';
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
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
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
      const snackBar =
          SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: ContactAccessPage()));
  }
}

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safety/db/db_services.dart';
import 'package:women_safety/model/contacts.dart';
import 'package:women_safety/utils/constrins.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController searchControllar = TextEditingController();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  @override
  void initState() {
    super.initState();
    askPermission();
  }

//Copy Function
  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContacts() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);

    if (searchControllar.text.isNotEmpty) {
      _contacts.retainWhere((element) {
        String searchTerm = searchControllar.text.toLowerCase();
        String searchTermFlattren = flattenPhoneNumber(searchTerm);
        String contactName = element.displayName!.toLowerCase();
        bool nameMatch = contactName.contains(searchTerm);

        if (nameMatch == true) {
          return true;
        }

        if (searchTermFlattren.isEmpty) {
          return false;
        }
        var phone = element.phones!.firstWhere((p) {
          String phnFlattren = flattenPhoneNumber(p.value!);
          return phnFlattren.contains(searchTermFlattren);
        });
        return phone.value != null;
      });
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  Future<void> askPermission() async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getContactsAll();
      searchControllar.addListener(() {
        filterContacts();
      });
    } else {
      handleInvalidPermission(permissionStatus);
    }
  }

  handleInvalidPermission(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      ShowdailogBOX(context, "Accses to the Contact denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      ShowdailogBOX(context, "May contacts does not exits in this device");
    }
  }

  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
// Mobile Contact ke permissions  condition
    if (PermissionStatus != PermissionStatus.granted &&
        PermissionStatus != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getContactsAll() async {
    List<Contact> _contact = await ContactsService.getContacts();
    setState(() {
      contacts = _contact;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchControllar.text.isNotEmpty;
    bool listItemExit = (contactsFiltered.length > 0 || contacts.length > 0);
    return Scaffold(
        body: contacts.length == 0
            ? Center(child: progressIndicator(context))
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: searchControllar,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: "Search Contacts",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      listItemExit == true
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: isSearching == true
                                      ? contactsFiltered.length
                                      : contacts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Contact contact = isSearching == true
                                        ? contactsFiltered[index]
                                        : contacts[index];
                                    return ListTile(
                                      title: Text(contact.displayName!),
                                      //  subtitle: Text(contact.phones!.elementAt(0).value!),
                                      leading: contact.avatar != null &&
                                              contact.avatar!.length > 0
                                          ? CircleAvatar(
                                              backgroundColor: primaryColor,
                                              backgroundImage:
                                                  MemoryImage(contact.avatar!),
                                            )
                                          : CircleAvatar(
                                              child: Text(contact.initials()),
                                              backgroundColor: primaryColor,
                                            ),
                                      onTap: () {
                                        if (contact.phones!.length > 0) {
                                          final String phoneNum = contact
                                              .phones!
                                              .elementAt(0)
                                              .value!;
                                          final String name =
                                              contact.displayName!;
                                          _addContact(
                                              TContacts(phoneNum, name));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Oops! phone number of this contact does not exist');
                                        }
                                      },
                                    );
                                  }),
                            )
                          : Container(
                              child: Text("Searching"),
                            ),
                    ],
                  ),
                ),
              ));
  }

  void _addContact(TContacts newContact) async {
    int result = await _databaseHelper.insertContact(newContact);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact added Succsussfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to add Contact");
    }
    Navigator.of(context).pop(true);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:women_safety/Child/bottome_screen/contact_page.dart';
import 'package:women_safety/Components/primaryButton.dart';
import 'package:women_safety/db/db_services.dart';
import 'package:women_safety/model/contacts.dart';
import 'package:women_safety/utils/constrins.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<TContacts> contactList = [];
  int count = 0;

  void showList() {
    Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContacts>> contactListFuture =
          databaseHelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  @override
  void initState() {
    showList();

    super.initState();
  }

  void deleteContact(TContacts contact) async {
    int result = await databaseHelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact removed succsussfully");
      showList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              PrimaryButton(
                  title: "Add Trusted Contacts",
                  onPressed: () async {
                    bool result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactScreen()),
                    );
                    if (result == true) {
                      showList();
                    }
                  }),
              Expanded(
                child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: ListTile(
                          title: Text(contactList[index].name),
                          subtitle: Text(contactList[index].number),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    deleteContact(contactList[index]);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: primaryColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        contactList[index].number);
                                  },
                                  icon: Icon(
                                    Icons.phone,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                      );
                    })),
              )
            ],
          ),
        ),
      ),
    );
  }
}

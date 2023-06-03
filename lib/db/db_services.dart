import 'package:sqflite/sqflite.dart';
import 'package:women_safety/model/contacts.dart';

class DatabaseHelper {
  String contactTable = "contact_table";
  String contactid = "id";
  String colcontactname = "name";
  String colcontactnumber = "number";

//private consuctor is ka hum 1 he objectused kar sektay hain.
  DatabaseHelper._createInternce();

  static DatabaseHelper? _databaseHelper;

//simple or factory consuctor main yahe farq hota hai kuch na kuch value return karta hai.
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInternce();
    }
    return _databaseHelper!;
  }

  //lets intialize the database sqflite
  static Database? _database;
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String directorypath = await getDatabasesPath();
    String dbLocation = directorypath + "contact.db";

    var contactDatabase =
        await openDatabase(dbLocation, version: 1, onCreate: _createTable);
    return contactDatabase;
  }

  void _createTable(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $contactTable($contactid INTEGER PRIMARY KEY AUTOINCREMENT,$colcontactname TEXT, $colcontactnumber TEXT)');
  }

  //Datebase se agar data get karna hai tu MapList banege
  //Fetch operation: get contact object from database

  //database mai jitna bhe data para hai us ko get kar ne kay liya hum
  //GetContactMapList ka function bana hain gay.

  Future<List<Map<String, dynamic>>> getContactMapList() async {
    Database db = await this.database;

    List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT * FROM $contactTable order by $contactid ASC');
    return result;
  }

  //Insert a contact object
  Future<int> insertContact(TContacts contacts) async {
    Database db = await this.database;
    var result = await db.insert(contactTable, contacts.toMap());
    return result;
  }

  //update a contact object
  Future<int> updateContact(TContacts contacts) async {
    Database db = await this.database;
    var result = await db.update(contactTable, contacts.toMap(),
        where: '$contactid =?', whereArgs: [contacts.id]);
    return result;
  }

  //delete a contact object
  Future<int> deleteContact(int id) async {
    Database db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $contactTable WHERE $contactid = $id');
    return result;
  }

  //get number of contact object

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $contactTable');
    int result = Sqflite.firstIntValue(x)!;
    return result;
  }

  //get the 'Map List ' [List<Map>] and Convert is to 'contact list' [ List<Contact> ]
  Future<List<TContacts>> getContactList() async {
    var contactMapList =
        await getContactMapList(); //get 'Map list form database'
    int count =
        contactMapList.length; //count the number of map entries in db table

    List<TContacts> contactList = <TContacts>[];
    // FOR Loop to create a 'Contact List' form a 'Map List'

    for (int i = 0; i < count; i++) {
      contactList.add(TContacts.fromMapObject(contactMapList[i]));
    }
    return contactList;
  }
}

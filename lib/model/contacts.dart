class TContacts {
  int? _id;
  String? _name;
  String? _number;

  TContacts(this._number, this._name);
  TContacts.withId(this._id, this._number, this._name);

  //gatters
  int get id => _id!;
  String get number => _number!;
  String get name => _name!;

  @override
  String toString() {
    return 'Contact: {id: $_id, name: $_name, number: $_number}';
  }

  //satters
  set number(String newNumber) => this._number = newNumber;
  set name(String newName) => this._name = newName;

  //convert a contact object to a Map object
  //ToMAP KA FUNCTION ISLIYA ISTIMAL KIYA HAI
  // JAB HUM DATABASE MAIN DATA BAHJ NA CHAHA HAIN DATA DATABADE MAIN STORE HOJA HAI
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = this._id;
    map['number'] = this._number;
    map['name'] = this._name;

    return map;
  }

  //Extract  a Contact Object From a Map object
  //fromMapObject KA FUNCTION HUM JAB USED KAREIN JAB HUM
  //DATABASE MAIN DATA FETCH KAREIN GAY JAB ISTIMAL KAREIN GAY.

  TContacts.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._number = map['number'];
    this._name = map['name'];
  }
}

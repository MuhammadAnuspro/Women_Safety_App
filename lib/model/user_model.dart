class UserModel {
  String? name;
  String? id;
  String? phone;
  String? childEmail;
  String? guardianEmail;
  String? type;

  UserModel(
      {this.name,
      this.phone,
      this.id,
      this.childEmail,
      this.guardianEmail,
      this.type});

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'phone': phone,
        'childEmail': childEmail,
        'guardianEmail': guardianEmail,
        'type': type,
      };
}

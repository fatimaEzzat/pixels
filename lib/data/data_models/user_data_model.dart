import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String uId;
  late String firstName;
  late String lastName;
  late String email;
  String? phone;
  DocumentSnapshot<Map<String, dynamic>>? docSnapshot;

  UserModel.createAccountData(
      {required this.uId,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.phone});

  UserModel.fromJson(
      {required Map<String, dynamic> map,
        DocumentSnapshot<Map<String, dynamic>>? docSnapshotArg}) {
    docSnapshot = docSnapshotArg;
    uId = map['uId'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    phone = map['phone']?? '';
    }


  Map<String, dynamic> toCreateAccountMap() {
    Map<String, dynamic> map = {
      'uId': uId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
    if (phone != null) {
      map['phone'] = phone;
    }
    return map;
  }
}

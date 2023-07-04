class UserModel {
  late String uId;
  late String firstName;
  late String lastName;
  late String email;
  String? phone;

  UserModel.createAccountData(
      {required this.uId,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.phone});

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

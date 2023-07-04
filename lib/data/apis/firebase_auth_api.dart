import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/constants.dart';

class FirebaseAuthApi{


  Future<void> createAccountData(
      {required Map<String, dynamic> map,
        required String uId}) async {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(uId)
        .set(map);
  }
}
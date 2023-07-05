import 'package:cloud_firestore/cloud_firestore.dart';

import '../../shared/constants.dart';

class FirebaseAuthApi {
  Future<dynamic> getUserData({required String uId}) async {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(uId)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteWallpapers(
      {required String userId}) {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .collection(favoritesCollection)
        .snapshots();
  }

  Future<void> createAccountData(
      {required Map<String, dynamic> map, required String uId}) async {
    return FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(uId)
        .set(map);
  }
}

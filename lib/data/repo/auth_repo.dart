import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixels/data/data_models/user_data_model.dart';

import '../../shared/utilities.dart';
import '../apis/firebase_auth_api.dart';

abstract class AuthRepoInterface {

  Future<UserModel> getUserData(
      {required String uId});

  Future<void> createAccountData({
    required Map<String, dynamic> map,
    required String uId,
  });
}

class AuthRepo implements AuthRepoInterface {
  final FirebaseAuthApi _authApi;

  const AuthRepo(FirebaseAuthApi authApi) : _authApi = authApi;

  @override
  Future<UserModel> getUserData(
      {required String uId}) async {
    DocumentSnapshot<Map<String, dynamic>> res= await _authApi.getUserData(uId: uId);
    UserModel user=UserModel.fromJson(map: res.data()!);
    return user;
  }

  @override
  Future<void> createAccountData({
    required Map<String, dynamic> map,
    required String uId,
  }) async {
    printDebug("user created: ${map.toString()}");
    return await _authApi.createAccountData(
      uId: uId,
      map: map,
    );
  }
}

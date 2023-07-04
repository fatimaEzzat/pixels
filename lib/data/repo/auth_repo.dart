import 'package:firebase_auth/firebase_auth.dart';


import '../../shared/utilities.dart';
import '../apis/firebase_auth_api.dart';

abstract class AuthRepoInterface{
  Future<void> createAccountData(
      {required Map<String, dynamic> map,
        required String uId,});
}


class AuthRepo implements AuthRepoInterface{

  final FirebaseAuthApi _authApi;

  const AuthRepo(FirebaseAuthApi authApi) : _authApi = authApi;

  @override
  Future<void> createAccountData(
      {required Map<String, dynamic> map,
        required String uId,}) async {
    printDebug("user created: ${map.toString()}");
    return await _authApi.createAccountData(
      uId: uId,
      map: map,
    );
  }

}
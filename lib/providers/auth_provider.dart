import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:pixels/data/apis/firebase_auth_api.dart';
import '../data/data_models/gallery_data_model.dart';
import '../data/data_models/user_data_model.dart';
import '../data/repo/auth_repo.dart';
import '../network/local/cache_helper.dart';
import '../shared/utilities.dart';

enum DataStates { init, loading, success, error }

class AuthProvider with ChangeNotifier {
  final _authRepo = AuthRepo(FirebaseAuthApi());

  Widget suffix = const Icon(Icons.remove_red_eye_outlined);
  bool isPass = true;

  void changePassVisibility() {
    isPass = !isPass;
    suffix = isPass
        ? const Icon(Icons.remove_red_eye_outlined)
        : const Icon(Icons.visibility_off_outlined);
    notifyListeners();
  }

  late DataStates dataState = DataStates.init;

  void setDataState({required DataStates state}) {
    this.dataState = state;
    notifyListeners();
  }


  Future<void> getUserData({required String uId}) async {
    setDataState(state: DataStates.loading);
    try {
      currentUser = await _authRepo.getUserData(
          uId: uId );
      setDataState(state: DataStates.success);
      } catch (e) {
      printDebug('getUserDataError: ${e.toString()}');
      showToast(msg: e.toString(), state: ToastedStates.WARNING);
      setDataState(state: DataStates.error);
      return null;
      ;
    }
  }

  StreamSubscription? _consultationStream;
List<Wallpaper> favWallpaper=[];
  void listenFavoritesWallpaper() {
    print('faaaaa');
    // if (currentUser?.uId == null) return;
   setDataState(state: DataStates.loading);
    try {
      _consultationStream = _authRepo
          .getFavoriteWallpapers()
          .listen((event) {
        favWallpaper.clear();
        for (var wallpaper in event.docs) {
            favWallpaper.add(Wallpaper.fromJson(wallpaper.data()));
        }
        setDataState(state: DataStates.success);

      });
    } catch (e) {
      printDebug('Error in listenFavoritesWallpaper: ${e.toString()}');
      setDataState(state: DataStates.error);
    }
  }

  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges =>
      _firebaseAuth.idTokenChanges().map((event) => event!);

  Future<void> registerByFirebaseEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phone,
  }) async {
    setDataState(state: DataStates.loading);
    try {
      var res = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (res.user?.uid == null) {
        setDataState(state: DataStates.error);
        return;
      }
      printDebug('uIdIs: ${res.user?.uid}');
      createAccountData(
        uId: res.user?.uid ?? '',
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone!,
      );
    } on FirebaseAuthException catch (e) {
      printDebug('createUserWithEmailAndPasswordError: ${e.toString()}');
      showToast(msg: e.message.toString(), state: ToastedStates.WARNING);
      setDataState(state: DataStates.error);
      // emit(ErrorRegisterByFirebaseEmailAndPasswordState(error: e.toString()));
    } catch (e) {
      printDebug('registerByFirebaseEmailAndPasswordError: ${e.toString()}');
      showToast(msg: e.toString(), state: ToastedStates.WARNING);
      setDataState(state: DataStates.error);
    }
  }

  Future<void> loginByEmailAndPassword(
      {required String email, required String password}) async {
    setDataState(state: DataStates.loading);
    try {
      var res = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uId = res.user?.uid ?? '';
      await CacheHelper.saveData(key: 'uId', value: uId);
      setDataState(state: DataStates.success);
      getUserData(uId: uId);
    } catch (e) {
      printDebug('loginByEmailAndPasswordError: ${e.toString()}');
      showToast(
          msg: e.toString().substring(e.toString().indexOf(']') + 1),
          state: ToastedStates.WARNING);
      setDataState(state: DataStates.error);
    }
  }

  UserModel? currentUser;

  Future<void> createAccountData({
    required String uId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    try {
      UserModel user = UserModel.createAccountData(
          uId: uId,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone);
      await _authRepo.createAccountData(
        map: user.toCreateAccountMap(),
        uId: uId,
      );
      setDataState(state: DataStates.success);
      await CacheHelper.saveData(key: 'uId', value: uId);
      getUserData(uId: uId);
    } catch (e) {
      _firebaseAuth.currentUser?.delete();
      printDebug('createAccountDataError: ${e.toString()}');
      showToast(msg: e.toString(), state: ToastedStates.WARNING);
      setDataState(state: DataStates.error);
    }
  }

  Future<void> signOut(context) async {
    await CacheHelper.removeData(key: 'uId');
    _firebaseAuth
        .signOut()
        .then((value) => OneNotification.hardReloadRoot(context));
  }
}

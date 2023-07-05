import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../network/local/cache_helper.dart';
import '../../../providers/auth_provider.dart';
import '../../../shared/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    navigateHandler();
    super.initState();
  }

  void navigateHandler() async {
    if (CacheHelper.getString(key: 'uId').isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
        await  Provider.of<AuthProvider>(context,listen: false).getUserData(
          uId: CacheHelper.getString(key: 'uId'),
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
            context, loginScreen, (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      if (provider.dataState == DataStates.success) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, homeLayout);
        });
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            'assets/images/logo-transparent-png.png',
            width: 180.0,
          ),
        ),
      );
    });
  }
}

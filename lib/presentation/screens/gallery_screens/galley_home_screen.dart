import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../widgets/default_button_widget.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:DefaultButtonWidget(function: () {  
          context.read<AuthProvider>().signOut(context);
          // Navigator.pushNamed(context, splashScreen);
        },text: 'logout',),
      ),
    );
  }
}

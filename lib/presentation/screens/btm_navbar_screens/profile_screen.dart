import 'package:flutter/material.dart';
import 'package:pixels/presentation/widgets/default_button_widget.dart';
import 'package:pixels/presentation/widgets/user_info_widget.dart';
import 'package:pixels/providers/auth_provider.dart';
import 'package:pixels/shared/style/colors.dart';
import 'package:provider/provider.dart';

import '../../../shared/utilities.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserInfo()
          ],
        ),
      ),
    );
    ;
  }
}

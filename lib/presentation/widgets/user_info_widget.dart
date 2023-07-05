import 'package:flutter/material.dart';
import 'package:pixels/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../shared/style/colors.dart';
import '../../shared/utilities.dart';
import 'default_button_widget.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            SizedBox(
              height: 20,
              width: double.infinity,
            ),
            CircleAvatar(
              radius: 60,
              backgroundColor: MyColors.customGrey,
              child: Center(
                child: Text(
                  'F'.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Fatma Ezzat',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'fatmaezzat@gmail.com',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              height: 10.0,
            ),
            DefaultButtonWidget(
              function: () {
                showConfirmDialog(
                    context: context,
                    onConfirm: () {
                      provider.signOut(context);
                    });
              },
              text: 'logout',
              radius: 20,
            )
          ],
        );
      },
    );
  }
}

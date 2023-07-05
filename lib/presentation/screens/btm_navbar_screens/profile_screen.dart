import 'package:flutter/material.dart';
import 'package:pixels/presentation/widgets/default_button_widget.dart';
import 'package:pixels/shared/style/colors.dart';

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
              function: () {},
              text: 'logout',
              radius: 20,
            )
          ],
        ),
      ),
    );
    ;
  }
}

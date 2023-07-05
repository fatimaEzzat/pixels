import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

printDebug(String message) {
  if (kDebugMode) debugPrint(message);
}

enum ToastedStates { SUCCESS, ERROR, WARNING }

showToast(
    {required String msg,
      required ToastedStates state,
      ToastGravity gravity = ToastGravity.BOTTOM,
      Toast toastLength = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

Color chooseToastColor(ToastedStates states) {
  Color color;
  switch (states) {
    case ToastedStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastedStates.ERROR:
      color = Colors.red;
      break;
    case ToastedStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


shimmerSliverGridViewEffect(){
  return
  GridView.custom(
    gridDelegate: SliverWovenGridDelegate.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      pattern: [
        WovenGridTile(1),
        WovenGridTile(
          5 / 7,
          crossAxisRatio: 0.9,
          alignment: AlignmentDirectional.centerEnd,
        ),
      ],
    ),
    childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.0,
              width: 110.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          )
    ),
  );


  // return SliverGrid(
  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 2, childAspectRatio: 0.8,
  //     crossAxisSpacing: 16.0,
  //     mainAxisSpacing: 16.0,
  //   ),
  //   delegate: SliverChildBuilderDelegate(
  //         (context,index){
  //       return Shimmer.fromColors(
  //         baseColor: Colors.grey[350]!,
  //         highlightColor: Colors.grey[100]!,
  //         child: Container(
  //           height: 100.0,
  //           width: 110.0,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10.0),
  //             color: Colors.grey.withOpacity(0.3),
  //           ),
  //         ),
  //       );
  //     },
  //     childCount: 15,
  //   ),
  // );
}

Future<void> showConfirmDialog({required BuildContext context,required Function() onConfirm}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure to logout?'),
              // Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: onConfirm,
          ),

        ],
      );
    },
  );
}

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}


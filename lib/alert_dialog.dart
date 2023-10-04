import 'package:flutter/material.dart';
import 'package:todo/myTheme.dart';

class AlertDetails {
  static void showLoading(BuildContext context, String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shadowColor: MyTheme.primaryLight,
            //backgroundColor: MyTheme.primarydark,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox.square(
                  dimension: 12,
                ),
                Text(text),
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
    BuildContext context,
    String message, {
    String mytitle = '',
    String? ButtonNameAction,
    VoidCallback? actionOfAlert,
    String? negButtonNameAction,
    VoidCallback? negactionOfAlert,
  }) {
    List<Widget> actions = [];
    if (ButtonNameAction != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            actionOfAlert?.call();
          },
          child: Text(ButtonNameAction)));
    }
    //leh b2a hena neg tb ma negative aw postive na 75tar el action w title w message fo2 ??
    if (negButtonNameAction != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negactionOfAlert?.call();
          },
          child: Text(negButtonNameAction)));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(mytitle),
            content: Text(message),
            actions: actions,
          );
        });
  }
}

import 'package:flutter/material.dart';

Future<void> showCustomDialog(BuildContext context, String message,
    {bool? cancalButtion, bool? circularProgress, Widget? widget}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: cancalButtion != null
            ? [
                Center(
                  child: TextButton(
                      child: Text(
                        "الغاء",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                )
              ]
            : null,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (circularProgress != null) const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(message),
            if (widget != null) widget
          ],
        ),
      );
    },
  );
}

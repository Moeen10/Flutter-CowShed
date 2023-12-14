import 'package:flutter/material.dart';

Future PopupMessage(BuildContext context,String messageType,String message){
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(messageType),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}


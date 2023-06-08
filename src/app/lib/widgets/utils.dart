import 'package:flutter/material.dart';

Future<T> showLoading <T> (BuildContext context, Future<T> future, {String? text}) async {
  var children = <Widget>[const CircularProgressIndicator()];
  if (text != null) {
    children.add(const SizedBox(height: 16));
    children.add(Text(
      text,
      style: Theme.of(context).textTheme.titleLarge,
    ));
  }
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(          
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      );
    }
  );
  T rv = await future;
  if (context.mounted) {
    Navigator.pop(context);
  }
  return rv;
}
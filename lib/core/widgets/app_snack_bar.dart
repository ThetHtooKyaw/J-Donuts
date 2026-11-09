import 'package:flutter/material.dart';

void showComingSoonSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.error,
        content: Text(message),
      ),
    );
}

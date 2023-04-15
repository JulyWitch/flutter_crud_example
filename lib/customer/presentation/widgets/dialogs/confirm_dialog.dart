import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final res = await showDialog(
    context: context,
    builder: (context) => _ConfirmDialog(
      title: title,
      message: message,
    ),
  );

  if (res is bool) {
    return res;
  }
  return null;
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/chats/chat_page.dart';

/// loading dialog ///
Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          // onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8)),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const CircularProgressIndicator(strokeWidth: 3),
                  ),
                ],
              ),
            ),
          ),
        );
      }
  );
}

void showActionSheet(BuildContext context, List<MoreTypeInfo> listMore) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        for (final type in listMore) CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            type.onTap!();
          },
          child: Text(type.description),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context);
        },
        isDestructiveAction: true,
        child: const Text('Cancel', ),
      ),
    ),
  );
}

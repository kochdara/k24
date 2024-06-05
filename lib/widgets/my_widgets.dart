import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/config.dart';

class MyWidgets {

  final Config _config = Config();

  modalBottom(BuildContext context, { required Widget child }) {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(0.65),
      elevation: 10,
      enableDrag: true,
      isScrollControlled: true,
        useRootNavigator: false,
        isDismissible: true,
        useSafeArea: true,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  showNotification(
      String title,
      {
        Color text = Colors.white,
        Color background = Colors.red,
        Duration duration = const Duration(seconds: 3)
      }
    ) {
    BotToast.showNotification(
      leading: (_) => Icon(Icons.error, color: text,),
      title: (_) => Text(title, style: TextStyle(color: text),),
      backgroundColor: background,
      trailing: (cancel) => IconButton(onPressed: cancel, icon: const Icon(Icons.close), color: text,),
      duration: duration,
    );
  }

  showAlert(BuildContext context, String message, {String? title}) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(message),
        actions: <Widget>[
          // TextButton(
          //   onPressed: () => Navigator.pop(context, 'Cancel'),
          //   child: const Text('Cancel'),
          // ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  step(List items, int active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: (){
          List<Widget> list = [];
          int i = 1;
          for(var val in items) {
            if(list.isNotEmpty) list.add(Container(padding: const EdgeInsets.symmetric(horizontal: 20),child: const Icon(CupertinoIcons.forward, color: Colors.grey,),));
            list.add(Expanded(child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2, color: i <= active ? _config.primaryColor : Colors.grey))),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: i <= active ? (i == active ? _config.primaryColor : Colors.white) : Colors.white,
                        border: Border.all(width: 2, color: i <= active ? _config.primaryColor : Colors.white)
                      ),
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      child: Text(i.toString(), style: TextStyle(fontSize: 18, color: i <= active ? (i == active ? Colors.white : _config.primaryColor) : Colors.black54, fontWeight: FontWeight.w500),)
                  ),
                  const SizedBox(width: 14,),
                  Text(val["title"], style: TextStyle(fontSize: 20, color: i <= active ? _config.primaryColor : Colors.black),),
                ],
              ),
            )));
            i++;
          }
          return list;
        }(),
      ),
    );
  }

}
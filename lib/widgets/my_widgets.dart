// ignore_for_file: use_build_context_synchronously, empty_catches


import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/profiles/profile_page.dart';
import 'package:k24/pages/chats/chat_page.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/widgets/labels.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../helpers/config.dart';
import '../pages/accounts/check_login.dart';
import '../pages/details/details_post.dart';

class MyWidgets {

  final Config config = Config();
  final Labels labels = Labels();

  Widget bottomBarPage(BuildContext context, WidgetRef ref, StateProvider<int> selectedIndex) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notify'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.camera_fill), label: ''),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_text_fill), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_crop_circle_fill), label: 'Account'),
      ],
      iconSize: 32,
      selectedFontSize: 12,
      showSelectedLabels: true,
      selectedItemColor: config.primaryAppColor.shade600,
      unselectedFontSize: 12,
      showUnselectedLabels: true,
      unselectedItemColor: config.secondaryColor.shade200,
      currentIndex: ref.watch(selectedIndex),
      type: BottomNavigationBarType.fixed,
      onTap: (value) async {
        DateTime expDate = DateTime.now();
        final tokens = ref.watch(usersProvider);

        ref.read(selectedIndex.notifier).state = value;
        try {
          expDate = JwtDecoder.getExpirationDate('${tokens.tokens?.access_token}');
        } catch(e) {}

        if(value != 0 && expDate.compareTo(DateTime.now()) <= 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckLoginPage()));

        } else {
          switch (value) {
            case 3:
              routeNoAnimation(context, pageBuilder: ChatPageView(selectedIndex: selectedIndex));
              break;

            case 4:
              routeNoAnimation(context, pageBuilder: const ProfilePage());
              break;

            default:
              Navigator.of(context).popUntil((route) => route.isFirst);
          }
        }
      },
    );
  }

  void modalBottom(BuildContext context, { required Widget child }) {
    showModalBottomSheet(
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

  void showNotification(
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

  void showAlert(BuildContext context, String message, {String? title}) {
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

  Widget step(List items, int active) {
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
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2, color: i <= active ? config.primaryColor : Colors.grey))),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: i <= active ? (i == active ? config.primaryColor : Colors.white) : Colors.white,
                        border: Border.all(width: 2, color: i <= active ? config.primaryColor : Colors.white)
                      ),
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      child: Text(i.toString(), style: TextStyle(fontSize: 18, color: i <= active ? (i == active ? Colors.white : config.primaryColor) : Colors.black54, fontWeight: FontWeight.w500),)
                  ),
                  const SizedBox(width: 14,),
                  Text(val["title"], style: TextStyle(fontSize: 20, color: i <= active ? config.primaryColor : Colors.black),),
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

  Widget imageList(BuildContext context, WidgetRef ref, String thumbnail, List listImg, String title, {
    double heightImg = 300.0
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PreviewImage(title: title, list: listImg))
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(thumbnail != '') ...[
              SizedBox(
                height: heightImg,
                width: double.infinity,
                child: Image.network(thumbnail, fit: BoxFit.cover),
              ),
            ],

            if(listImg.isNotEmpty) ...[
              const SizedBox(height: 4),

              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final conf = responsiveImage(constraints.maxWidth);
                    var width = conf['width'];
                    var length = conf['length'] ?? 0;

                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        for(var v=0; v<length; v++) ... [
                          if(listImg.asMap().containsKey(v))
                            Stack(
                              children: [
                                Container(
                                  height: width ?? 120,
                                  width: width ?? 120,
                                  color: config.secondaryColor.shade50,
                                  child: Image.network(listImg[v], fit: BoxFit.cover),
                                ),

                                if((listImg.length - length) > 0 && v == (length - 1))
                                  Positioned(
                                    height: width ?? 120,
                                    width: width ?? 120,
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black.withOpacity(0.45),
                                      child: labels.label('+${(listImg.length - length)}', fontSize: 18, color: Colors.white,fontWeight: FontWeight.w500),
                                    ),
                                  )
                              ],
                            ),
                        ],
                      ],
                    );
                  }
              ),
            ],
          ],
        ),
      ),
    );
  }

}
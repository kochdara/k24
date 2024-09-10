// ignore_for_file: use_build_context_synchronously, empty_catches


import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/login/login_provider.dart';
import 'package:k24/pages/accounts/profiles/profile_page.dart';
import 'package:k24/pages/chats/chat_page.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/pages/notifys/notify_page.dart';
import 'package:k24/pages/posts/post_page.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';
import 'package:badges/badges.dart' as badges;

import '../helpers/config.dart';
import '../pages/accounts/check_login.dart';
import '../pages/details/details_post.dart';

final Config config = Config();
final Labels labels = Labels();
final myService = MyApiService();
final Buttons buttons = Buttons();

class MyWidgets {

  Widget bottomBarPage(BuildContext context, WidgetRef ref, int selectedIndex,
      ScrollController? scrollController, { bool visible = true, }) {
    final badgesPro = ref.watch(getBadgesProvider(ref));
    final badge = ref.watch(dataBadgeProvider);
    final datum = badgesPro.valueOrNull ?? badge;

    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        height: !visible ? 0 : null,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: BadgesPage(index: datum.notification ?? '', icon: Icons.notifications,), label: 'Notify'),
            const BottomNavigationBarItem(icon: Icon(CupertinoIcons.camera_fill), label: ''),
            BottomNavigationBarItem(icon: BadgesPage(index: datum.chat ?? '', icon: CupertinoIcons.chat_bubble_text_fill), label: 'Chat'),
            const BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_crop_circle_fill), label: 'Account'),
          ],
          iconSize: 32,
          selectedFontSize: 12,
          showSelectedLabels: true,
          selectedItemColor: config.primaryAppColor.shade600,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          unselectedItemColor: config.secondaryColor.shade200,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) async {
            final tokens = ref.watch(usersProvider);
            String? accessToken = tokens.tokens?.access_token;
            if(value != 0 && (accessToken == null)) {
              routeAnimation(context, pageBuilder: const CheckLoginPage());

            } else {
              Navigator.of(context).popUntil((route) => route.isFirst);
              switch (value) {
                case 1:
                  routeNoAnimation(context, pageBuilder: const NotifyPage());
                  break;
                case 2:
                  routeNoAnimation(context, pageBuilder: const PostProductPage());
                  break;
                case 3:
                  routeNoAnimation(context, pageBuilder: const ChatPageView(selectedIndex: 3));
                  break;
                case 4:
                  routeNoAnimation(context, pageBuilder: const ProfilePage(selectedIndex: 4));
                  break;
                default:
                  if(scrollController != null) {
                    scrollController.animateTo(
                      0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
              }
            }
          },
        ),
      ),
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
        content: SelectableText(message),
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
          for(final val in items) {
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

  Widget imageList(BuildContext context, WidgetRef ref, List listImg, String title, {
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
            if(listImg.isNotEmpty) ...[
              SizedBox(
                height: heightImg,
                width: double.infinity,
                child: FadeInImage.assetNetwork(placeholder: placeholder, image: listImg.first, fit: BoxFit.cover),
              ),
            ],

            if(listImg.isNotEmpty && listImg.length > 1) ...[
              const SizedBox(height: 4),

              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final conf = responsiveImage(constraints.maxWidth);
                    final width = conf['width'];
                    final length = conf['length'] ?? 0;

                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        for(int v=1; v<=length; v++) ... [
                          if(listImg.asMap().containsKey(v))
                            Stack(
                              children: [
                                Container(
                                  height: width ?? 120,
                                  width: width ?? 120,
                                  color: config.secondaryColor.shade50,
                                  child: FadeInImage.assetNetwork(placeholder: placeholder, image: listImg[v], fit: BoxFit.cover),
                                ),

                                if((listImg.length - (length + 1)) > 0 && v == length)
                                  Positioned(
                                    height: width ?? 120,
                                    width: width ?? 120,
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black.withOpacity(0.45),
                                      child: labels.label('+${(listImg.length - (length + 1))}', fontSize: 18, color: Colors.white,fontWeight: FontWeight.w500),
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

  Widget titleAds(WidgetRef ref, {
    String title = 'Latest Ads'
  }) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 55),
      padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0, bottom: 8.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Row(
            children: [
              labels.label(title, fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            ],
          ),

          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  buttons.buttonTap(
                    onTap: () {ref.read(viewPageProvider.notifier).state = ViewPage.view;},
                    icon: CupertinoIcons.list_bullet_below_rectangle,
                    color: ref.watch(viewPageProvider) == ViewPage.view ? config.secondaryColor.shade700 : null,
                    size: 23,
                  ),

                  buttons.buttonTap(
                    onTap: () {ref.read(viewPageProvider.notifier).state = ViewPage.list;},
                    icon: CupertinoIcons.list_bullet,
                    color: ref.watch(viewPageProvider) == ViewPage.list ? config.secondaryColor.shade700 : null,
                    size: 23,
                  ),

                  buttons.buttonTap(
                    onTap: () {ref.read(viewPageProvider.notifier).state = ViewPage.grid;},
                    icon: CupertinoIcons.square_grid_2x2,
                    color: ref.watch(viewPageProvider) == ViewPage.grid ? config.secondaryColor.shade700 : null,
                    size: 23,
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}

class BadgesPage extends StatelessWidget {
  const BadgesPage({super.key,
    required this.index,
    required this.icon,
  });

  final String index;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final currentIndex = (int.tryParse(index) ?? 0) > 99 ? '99+' : index;
    return (index.isNotEmpty && index != '0') ? badges.Badge(
      position: badges.BadgePosition.topEnd(top: -3, end: -3),
      badgeContent: Text(currentIndex, style: const TextStyle(color: Colors.white, fontSize: 9)),
      badgeAnimation: const badges.BadgeAnimation.fade(),
      badgeStyle: badges.BadgeStyle(
        shape: badges.BadgeShape.circle,
        badgeColor: config.warningColor.shade400,
        padding: const EdgeInsets.all(4),
        elevation: 0,
      ),
      child: Icon(icon),
    ) : Icon(icon);
  }
}



// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/chats/comments/comment_page.dart';
import 'package:k24/pages/chats/conversations/chat_conversation.dart';
import 'package:k24/pages/chats/chat_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

final Labels labels = Labels();
final Config config = Config();
final MyWidgets myWidgets = MyWidgets();
final MyCards myCards = MyCards();
enum MoreType { all, buy, sell, unread, block_user }

final Map<MoreType, MoreTypeInfo> moreTypeInfo = {
  MoreType.all: MoreTypeInfo('all', 'All', CupertinoIcons.chat_bubble_2, () { }),
  MoreType.buy: MoreTypeInfo('buy', 'Buy', CupertinoIcons.shopping_cart, () { }),
  MoreType.sell: MoreTypeInfo('sell', 'Sell', CupertinoIcons.money_dollar_circle, () { }),
  MoreType.unread: MoreTypeInfo('unread', 'Unread', CupertinoIcons.eye_slash, () { }),
  MoreType.block_user: MoreTypeInfo('block_user', 'Block User', Icons.block, () { }),
};
StateProvider<MoreType> moreTypeProvider = StateProvider<MoreType>((ref) => MoreType.all);

class ChatPageView extends ConsumerStatefulWidget {
  const ChatPageView({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  ConsumerState<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends ConsumerState<ChatPageView> {
  @override
  void initState() {
    super.initState();
    moreTypeProvider = StateProvider<MoreType>((ref) => MoreType.all);
  }

  @override
  Widget build(BuildContext context) {
    final username = ref.watch(usersProvider);
    final typePro = ref.watch(moreTypeProvider);
    final description = moreTypeInfo[typePro]?.description;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(CupertinoIcons.person_circle_fill, color: config.secondaryColor.shade50, size: 42),
          title: labels.label('${username.user?.name}', fontSize: 20, fontWeight: FontWeight.w500, maxLines: 1, overflow: TextOverflow.ellipsis),
          titleSpacing: 6,
          actions: [
            MoreButtonUI(ref: ref, moreTypeProvider: moreTypeProvider),
          ],
          bottom: TabBar(
            indicatorColor: config.primaryAppColor.shade200,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(icon: labels.label((typePro == MoreType.block_user) ? '$description' : 'Chat/$description', fontSize: 16, fontWeight: FontWeight.w500)),
              Tab(icon: labels.label('Comment', fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        backgroundColor: config.backgroundColor,
        body: const BodyChat(),
        bottomSheet: myWidgets.bottomBarPage(
          context, ref, widget.selectedIndex,
          null
        ),
      ),
    );
  }
}

class BodyChat extends StatelessWidget {
  const BodyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        /// tap 1 ///
        ChatPageBuilder(),

        /// tap 2 ///
        CommentPage(),
      ],
    );
  }
}

class ChatPageBuilder extends ConsumerStatefulWidget {
  const ChatPageBuilder({super.key});

  @override
  ConsumerState<ChatPageBuilder> createState() => _ChatPageBuilderState();
}

class _ChatPageBuilderState extends ConsumerState<ChatPageBuilder> {

  @override
  void initState() {
    super.initState();
    futureAwait(() => trigger());
  }

  trigger() {
    if(mounted) {
      final chatPro = chatPageProvider(ref, '${moreTypeInfo[ref.watch(moreTypeProvider)]?.name}');
      print("@# 1");
      ref.read(chatPro.notifier).refresh(load: false);
      Future.delayed(Duration(seconds: ref.read(delayed)), () => trigger());
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatPro = chatPageProvider(ref, '${moreTypeInfo[ref.watch(moreTypeProvider)]?.name}');
    final watchChat = ref.watch(chatPro);

    return RefreshIndicator(
      onRefresh: () async => {  },
      notificationPredicate: (val) => !watchChat.isLoading,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              watchChat.when(
                error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                loading: () => const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                data: (data) {
                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      for(final val in data)
                        ListTile(
                          tileColor: (val.last_message?.is_read == false && val.last_message?.folder != 'send') ? config.primaryAppColor.shade50 : Colors.white,
                          leading: SizedBox(
                            width: 55,
                            child: (val.user?.photo != null) ? Stack(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    '${val.user?.photo?.url}',
                                  ),
                                ),

                                if(val.user?.online_status!.is_active == true) Positioned(
                                  bottom: 2,
                                  right: 2,
                                  child: Icon(Icons.circle_rounded, color: Colors.greenAccent.shade700, size: 10),
                                )
                              ],
                            ) : Container(height: 55,
                              decoration: BoxDecoration(color: config.secondaryColor.shade50, borderRadius: BorderRadius.circular(60)),
                              child: Icon(Icons.person, size: 30, color: config.secondaryColor.shade200),
                            ),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: labels.label('${val.user?.name}', fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black87),
                              ),

                              Expanded(flex: 0,
                                child: labels.label('${stringToTimeAgoDay(date: '${val.updated_date}', format: 'dd, MMM yyyy')}', fontSize: 11, color: Colors.black45),
                              ),
                            ],
                          ),
                          subtitle: labels.label(val.last_message?.message ?? '', fontSize: 13, color: (val.last_message?.is_read == false) ? Colors.black87 : Colors.black45, maxLines: 2),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                          onTap: () {
                            routeAnimation(context, pageBuilder: ChatConversations(chatData: val));
                          },
                        ),

                    ],
                  );
                },
              ),

              const SizedBox(height: 58),
            ]),
          ),
        ],
      ),
    );
  }
}


class MoreButtonUI extends StatelessWidget {
  const MoreButtonUI({super.key,
    required this.ref,
    required this.moreTypeProvider,
  });

  final WidgetRef ref;
  final StateProvider<MoreType> moreTypeProvider;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showActionSheet(context),
      padding: const EdgeInsets.all(10.0),
      icon: const Icon(Icons.more_vert_rounded, color: Colors.white,),
    );
  }

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          for (final type in MoreType.values) CupertinoActionSheetAction(
            onPressed: () {
              ref.read(moreTypeProvider.notifier).update((state) => type);
              Navigator.pop(context);
            },
            child: Text(moreTypeInfo[type]?.description ?? 'N/A'),
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
}

class MoreTypeInfo {
  final String name;
  final String description;
  final IconData? icon;
  final void Function()? onTap;

  MoreTypeInfo(this.name, this.description, this.icon, this.onTap);
}

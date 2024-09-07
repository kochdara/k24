
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
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../more_provider.dart';

final Labels labels = Labels();
final Config config = Config();
final MyWidgets myWidgets = MyWidgets();
final MyCards myCards = MyCards();

class ChatPageView extends ConsumerStatefulWidget {
  const ChatPageView({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  ConsumerState<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends ConsumerState<ChatPageView> {
  late StateProvider<String?> newMap;

  @override
  void initState() {
    super.initState();
    newMap = StateProvider((ref) => 'all');
  }

  @override
  Widget build(BuildContext context) {
    final username = ref.watch(usersProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: config.secondaryColor.shade50,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: Colors.white,),
              ),
              child: (username.user?.photo?.url != null) ? CircleAvatar(
                backgroundColor: Colors.black12,
                backgroundImage: NetworkImage(username.user?.photo?.url ?? ''),
              ) : Icon(Icons.person, color: config.secondaryColor.shade200, size: 26),
            ),
          ),
          title: labels.label('${username.user?.name}', fontSize: 20, fontWeight: FontWeight.w500, maxLines: 1, overflow: TextOverflow.ellipsis),
          titleSpacing: 6,
          actions: [
            IconButton(
              onPressed: () => showActionSheet(context, [
                MoreTypeInfo('all', 'All', CupertinoIcons.chat_bubble_2, null, () => updateMap(ref, 'all')),
                MoreTypeInfo('buy', 'Buy', CupertinoIcons.shopping_cart, null, () => updateMap(ref, 'buy')),
                MoreTypeInfo('sell', 'Sell', CupertinoIcons.money_dollar_circle, null, () => updateMap(ref, 'sell')),
                MoreTypeInfo('unread', 'Unread', CupertinoIcons.eye_slash, null, () => updateMap(ref, 'unread')),
                MoreTypeInfo('block_user', 'Block User', Icons.block, null, () => updateMap(ref, 'block_user')),
              ]),
              padding: const EdgeInsets.all(10.0),
              icon: const Icon(Icons.more_vert_rounded, color: Colors.white,),
            ),
          ],
          bottom: TabBar(
            indicatorColor: config.primaryAppColor.shade200,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(icon: labels.label('Chat/${ref.watch(newMap)}', fontSize: 16, fontWeight: FontWeight.w500)),
              Tab(icon: labels.label('Comment', fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        backgroundColor: config.backgroundColor,
        body: BodyChat(
          newMap: newMap,
        ),
        bottomNavigationBar: myWidgets.bottomBarPage(
          context, ref, widget.selectedIndex,
          null
        ),
      ),
    );
  }

  void updateMap(WidgetRef ref, String val) {
    ref.read(newMap.notifier).update((state) {
      return val.toString();
    });
  }
}

class BodyChat extends StatelessWidget {
  const BodyChat({super.key,
    required this.newMap,
  });

  final StateProvider<String?> newMap;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        /// tap 1 ///
        ChatPageBuilder(
          newMap: newMap,
        ),

        /// tap 2 ///
        const CommentPage(),
      ],
    );
  }
}

class ChatPageBuilder extends ConsumerStatefulWidget {
  const ChatPageBuilder({super.key,
    required this.newMap,
  });

  final StateProvider<String?> newMap;

  @override
  ConsumerState<ChatPageBuilder> createState() => _ChatPageBuilderState();
}

class _ChatPageBuilderState extends ConsumerState<ChatPageBuilder> {
  final ScrollController scrollController = ScrollController();
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    futureAwait(duration: 5000, () => trigger());
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent-50 && pixels <= maxScrollExtent) {
        _fetchMoreData();
      }
    });
  }

  Future<void> _fetchMoreData() async {
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(chatPageProvider(ref, '${ref.watch(widget.newMap)}').notifier);
    fetchMore.fetchData(true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  trigger() {
    if(mounted) {
      final chatPro = chatPageProvider(ref, '${ref.watch(widget.newMap)}');
      print("@# 1");
      if(!ref.watch(isLoadingPro)) ref.read(chatPro.notifier).refresh(false);
      Future.delayed(Duration(seconds: ref.read(delayed)), () => trigger());
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatPro = chatPageProvider(ref, '${ref.watch(widget.newMap)}');
    final watchChat = ref.watch(chatPro);
    final isLoading = ref.watch(isLoadingPro);
    final length = ref.watch(lengthPro);

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(chatPro.notifier).refresh(true);
        ref.read(isLoadingPro.notifier).state = false;
        ref.read(lengthPro.notifier).state = 1;
      },
      notificationPredicate: (val) => !watchChat.isLoading,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              watchChat.when(
                error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                loading: () => const SizedBox(
                  height: 250,
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
                                  backgroundColor: Colors.black12,
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
                          subtitle: labels.label('${val.last_message?.folder == 'send' ? 'You: ' : ''}${val.last_message?.message ?? ''}', fontSize: 13, color: (val.last_message?.is_read == false) ? Colors.black87 : Colors.black45, maxLines: 2),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                          onTap: () {
                            routeAnimation(context, pageBuilder: ChatConversations(chatData: val));
                          },
                        ),

                      if(isLoading && length > 0) Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        child: const CircularProgressIndicator(),
                      ) else if(length <= 0) const NoMoreResult(),

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

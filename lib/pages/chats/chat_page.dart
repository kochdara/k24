
// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/chats/conversations/chat_conversation.dart';
import 'package:k24/pages/chats/chat_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../serialization/chats/chat_serial.dart';

final Labels labels = Labels();
final Config config = Config();
final MyWidgets myWidgets = MyWidgets();
final MyCards myCards = MyCards();

class ChatPageView extends ConsumerStatefulWidget {
  const ChatPageView({super.key, required this.selectedIndex});

  final StateProvider<int> selectedIndex;

  @override
  ConsumerState<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends ConsumerState<ChatPageView> {

  @override
  void initState() {
    super.initState();
    futureAwait(() => trigger());
  }

  trigger() {
    if(mounted) {
      print("@# 1");
      ref.read(chatPageProvider.notifier).refresh(loading: false);
      Future.delayed(Duration(seconds: ref.read(delayed)), () => trigger());
    }
  }

  @override
  Widget build(BuildContext context) {
    final username = ref.watch(usersProvider);
    final watchChat = ref.watch(chatPageProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.supervised_user_circle_sharp, size: 42),
          title: labels.label('${username.user?.name}', fontSize: 20, fontWeight: FontWeight.w500),
          titleSpacing: 6,
          actions: [
            IconButton(
              onPressed: () { },
              padding: const EdgeInsets.all(14),
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ],
          bottom: TabBar(
            indicatorColor: config.primaryAppColor.shade200,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(icon: labels.label('Chat/All', fontSize: 16, fontWeight: FontWeight.w500)),
              Tab(icon: labels.label('Comment', fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        backgroundColor: config.backgroundColor,
        body: BodyChat(
          ref,
          watchChat: watchChat,
        ),
        bottomSheet: myWidgets.bottomBarPage(
            context, ref, widget.selectedIndex
        ),
      ),
    );
  }
}

class BodyChat extends StatelessWidget {
  const BodyChat(this.ref, {super.key, required this.watchChat});

  final WidgetRef ref;
  final AsyncValue<List<ChatData>> watchChat;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        /// tap 1 ///
        RefreshIndicator(
          onRefresh: () async => await ref.read(chatPageProvider.notifier).refresh(),
          notificationPredicate: (val) => !watchChat.isLoading,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  watchChat.when(
                    error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    data: (data) {
                      return Flex(
                        direction: Axis.vertical,
                        children: [
                          for(final val in data)
                            ListTile(
                              tileColor: Colors.white,
                              leading: SizedBox(
                                width: 55,
                                child: (val.user?.photo != null) ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    '${val.user?.photo?.url}',
                                  ),
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
                                    child: labels.label('${stringToString(date: '${val.updated_date}', format: 'dd MMM yyyy')}', fontSize: 13, color: Colors.black45),
                                  ),
                                ],
                              ),
                              subtitle: labels.label(val.last_message?.message ?? '', fontSize: 13, color: Colors.black45),
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
                ]),
              )
            ],
          ),
        ),

        /// tap 2 ///
        Text("Tab 2"),
      ],
    );
  }
}





// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/chats/chat_provider.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../serialization/chats/chat_serial.dart';
import '../../../serialization/chats/conversation/conversation_serial.dart';

final Labels labels = Labels();
final Config config = Config();
final Forms forms = Forms();
final MyCards myCards = MyCards();

class ChatConversations extends ConsumerStatefulWidget {
  const ChatConversations({super.key, required this.chatData});

  final ChatData chatData;

  @override
  ConsumerState<ChatConversations> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends ConsumerState<ChatConversations> {
  final scrollController = ScrollController();
  StateProvider<bool> hiddenProvider = StateProvider((ref) => false);
  StateProvider<Map<String, dynamic>> dataProvider = StateProvider((ref) => {});
  final chatServiceProvider = Provider((ref) => ChatApiService());

  @override
  void initState() {
    super.initState();
    scrollDown();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void scrollDown({int duration = 500}) {
    futureAwait(duration: duration, () {
      trigger();
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  trigger() {
    if(mounted) {
      print("@# 2");
      ref.read(conversationPageProvider('${widget.chatData.id}').notifier).refresh(load: false);
      Future.delayed(Duration(seconds: ref.read(delayed)), () => trigger());
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
    final watchHin = ref.watch(hiddenProvider);
    final watchConversation = ref.watch(conversationPageProvider('${widget.chatData.id}'));
    final text = ref.watch(dataProvider)['message']??'';

    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: BodyChatDetails(
        ref,
        chatData: widget.chatData,
        watchConversation: watchConversation,
        scrollController: scrollController,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 4, bottom: bottomHeight + 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(bottomHeight <= 10 || watchHin) ...[
              button(Icons.add_circle, onPressed: () { }),
              button(CupertinoIcons.location_solid, onPressed: () { }),
              button(Icons.photo_rounded, onPressed: () { }),

            ] else button(Icons.chevron_right,
                onPressed: () { ref.read(hiddenProvider.notifier).update((state) => true); }
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: forms.formField(
                  hintText: 'Type your message',
                  controller: (text.isEmpty) ? TextEditingController(text: '$text') : null,
                  fillColor: config.secondaryColor.shade50,
                  onTap: () => ref.read(hiddenProvider.notifier).update((state) => false),
                  onChanged: (val) => ref.read(dataProvider.notifier).update((state) => {...state, ...{'message': val}}),
                ),
              ),
            ),

            if(text.isNotEmpty) ...[
              button(
                  Icons.send,
                  onPressed: () async {
                    ref.read(dataProvider.notifier).update((state) =>
                    {...state, ...{'topic_id': '${widget.chatData.id}'}});

                    /// submit data ///
                    await ref.read(chatServiceProvider).submitData(ref.watch(dataProvider),
                      ref, context: context);

                    /// clear ///
                    ref.read(dataProvider.notifier).update((state) => {});
                    scrollDown(duration: 500);
                  }
              ),

            ] else button(
                Icons.mic,
                onPressed: () { }
            ),

          ],
        ),
      ),
    );
  }

  Widget button(IconData? icon, {
    required void Function()? onPressed,
  }) {
    return SizedBox(
      width: 38,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 26, color: config.primaryAppColor.shade600),
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    );
  }
}

class BodyChatDetails extends StatelessWidget {
  const BodyChatDetails(this.ref, {super.key, required this.chatData, required this.watchConversation,
  required this.scrollController});

  final WidgetRef ref;
  final ChatData chatData;
  final AsyncValue<List<ConData>> watchConversation;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
      /// app bar ///
      SliverAppBar(
        pinned: true,
        title: ListTile(
          leading: SizedBox(
            width: 40,
            child: (chatData.user?.photo != null) ? CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('${chatData.user?.photo?.url}'),
            ) : Container(height: 40,
              decoration: BoxDecoration(color: config.secondaryColor.shade50, borderRadius: BorderRadius.circular(60)),
              child: Icon(Icons.person, color: config.secondaryColor.shade200),
            ),
          ),
          title: labels.label(chatData.user?.name??'', fontSize: 18, fontWeight: FontWeight.w500),
          subtitle: labels.label(chatData.user?.online_status?.last_active??'', fontSize: 14),
          contentPadding: EdgeInsets.zero,
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () { },
            padding: const EdgeInsets.all(14),
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),

      SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 1, (context, index) {
            return watchConversation.when(
              error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      for(final val in data)
                        Row(
                          mainAxisAlignment: (val.folder == 'send') ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: (val.folder == 'send') ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                // text //
                                if(val.type == 'text') typeText(val)
                                else if(val.type == 'photos') typeImage(val)
                                else typeText(val),

                                const SizedBox(height: 6),

                                labels.labelIcon(
                                  rightTitle: '${stringWithNow(date: '${val.send_date}', format: 'dd, MMM yyyy HH:mm')}',
                                  rightIcon: (val.is_read == true) ? Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Icon(Icons.check, size: 12, color: config.secondaryColor.shade200),
                                  ) : null,
                                  style: TextStyle(fontSize: 11, color: config.secondaryColor.shade200)
                                ),

                                const SizedBox(height: 14),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    ]);
  }

  Widget typeText(ConData val ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular((val.folder == 'send') ? 20 : 0),
          bottomRight: Radius.circular((val.folder == 'send') ? 0 : 20),
        ),
        color: Colors.white,
      ),
      constraints: const BoxConstraints(maxWidth: 450),
      child: labels.label('${val.message}', fontSize: 13, color: Colors.black87),
    );
  }

  Widget typeImage(ConData val) {
    List data = val.data ?? [];

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20),
        topRight: const Radius.circular(20),
        bottomLeft: Radius.circular((val.folder == 'send') ? 20 : 0),
        bottomRight: Radius.circular((val.folder == 'send') ? 0 : 20),
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          for(final values in data)
            Container(
              constraints: const BoxConstraints(maxWidth: 450, minWidth: 200, maxHeight: 450, minHeight: 200),
              child: Image.network('${values['thumbnail']}', fit: BoxFit.cover),
            ),
        ],
      ),
    );
  }
}



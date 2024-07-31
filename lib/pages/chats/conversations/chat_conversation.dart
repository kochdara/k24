
// ignore_for_file: unused_result

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/chats/chat_provider.dart';
import 'package:k24/pages/chats/conversations/chat_conversation_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../serialization/chats/chat_serial.dart';
import '../../../serialization/chats/conversation/conversation_serial.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/dialog_builder.dart';
import '../../accounts/profile_public/another_profile.dart';

final Labels labels = Labels();
final Config config = Config();
final Forms forms = Forms();
final MyCards myCards = MyCards();
final Buttons buttons = Buttons();

class ChatConversations extends ConsumerStatefulWidget {
  const ChatConversations({super.key, required this.chatData});

  final ChatData chatData;

  @override
  ConsumerState<ChatConversations> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends ConsumerState<ChatConversations> {
  final scrollController = ScrollController();
  StateProvider<bool> hiddenProvider = StateProvider((ref) => false);
  StateProvider<bool> moreProvider = StateProvider((ref) => false);
  StateProvider<int> lengthProvider = StateProvider((ref) => 1);
  StateProvider<Map<String, dynamic>> dataProvider = StateProvider((ref) => {});
  final apiServiceProvider = Provider((ref) => MarkApiService());

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setupPage() {
    scrollDown();
    scrollController.addListener(() => onScroll(
      ref,
      scrollController,
      lengthProvider,
      widget.chatData,
    ));
  }

  void scrollDown({int duration = 1000, bool trig = true}) {
    futureAwait(duration: duration, () {
      if(trig) trigger(widget.chatData);
      scrollController.jumpTo(0);
    });
  }

  void trigger(ChatData chatData) {
    if(mounted) {
      print("@# 2");
      ref.read(conversationPageProvider(
        ref,
        chatData.id,
        jsonEncode(chatData.last_message?.toJson() ?? {}),
          chatData.to_id
      ).notifier).getNew();
      // mark to as read
      if(chatData.last_message?.is_read == false) {
        ref.watch(apiServiceProvider).submitMarkRead({
          'topic_id': '${chatData.id}',
          'to_id': '${chatData.to_id}',
          'id': '${chatData.last_message_id}'
        }, ref); print('object:');
      }

      Future.delayed(Duration(seconds: ref.read(delayed)), () => trigger(chatData));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
    final watchHin = ref.watch(hiddenProvider);
    final watchConversation = ref.watch(conversationPageProvider(
      ref,
      widget.chatData.id,
      jsonEncode(widget.chatData.last_message?.toJson() ?? {}),
      widget.chatData.to_id
    ));
    final text = ref.watch(dataProvider)['message']??'';
    final watchMore = ref.watch(moreProvider);

    final List<Map<String, dynamic>> items = [
      {'id': '0', 'icon': Icons.location_on, 'label': 'Location'},
      {'id': '1', 'icon': Icons.chat, 'label': 'Quick chat'},
      {'id': '2', 'icon': Icons.business, 'label': 'Business card'},
      {'id': '4', 'icon': Icons.attach_file, 'label': 'Attach file'},
      {'id': '5', 'icon': Icons.description, 'label': 'Resume (CV)'},
      {'id': '6', 'icon': Icons.local_shipping, 'label': 'Shipping / Billing Address'},
      {'id': '7', 'icon': Icons.ads_click, 'label': 'sumsongly\'s ads'},
      {'id': '8', 'icon': Icons.my_library_books, 'label': 'My ads'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          onTap: () => routeAnimation(context, pageBuilder: AnotherProfilePage(userData: User_.fromJson((widget.chatData.user?.toJson() ?? {}) as Map<String, dynamic>))),
          leading: SizedBox(
            width: 40,
            child: (widget.chatData.user?.photo != null) ? CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage('${widget.chatData.user?.photo?.url}'),
            ) : Container(height: 40,
              decoration: BoxDecoration(color: config.secondaryColor.shade50, borderRadius: BorderRadius.circular(60)),
              child: Icon(Icons.person, color: config.secondaryColor.shade200),
            ),
          ),
          title: labels.label(widget.chatData.user?.name??'', fontSize: 18, fontWeight: FontWeight.w500),
          subtitle: labels.label(widget.chatData.user?.online_status?.last_active??'', fontSize: 14),
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
      backgroundColor: config.backgroundColor,
      body: BodyChatDetails(
        ref,
        chatData: widget.chatData,
        watchConversation: watchConversation,
        scrollController: scrollController,
        fetching: ref.watch(lengthProvider),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 4, bottom: bottomHeight + 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(bottomHeight <= 10 || watchHin) ...[
                  button(watchMore ? Icons.close : Icons.add_circle, onPressed: () {
                    ref.read(moreProvider.notifier).update((state) => !watchMore);
                  }),

                  button(CupertinoIcons.location_solid, onPressed: () { }),

                  button(Icons.photo_rounded, onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                    if(image != null && image.path.isNotEmpty) {
                      final multipartImage = MultipartFile.fromFileSync(image.path,filename: image.name);
                      final filePath = await ref.read(apiServiceProvider).uploadData({
                        "file": multipartImage
                      }, ref);

                      ref.read(dataProvider.notifier).update((state) => {"data": {
                        "type": filePath.type ?? '',
                        "file": filePath.file ?? '',
                      }});

                      onSubmit();
                    }
                  }),

                ] else button(Icons.chevron_right,
                    onPressed: () { ref.read(hiddenProvider.notifier).update((state) => true); }
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: forms.formField(
                      hintText: 'Type your message',
                      controller: (text.isEmpty) ? TextEditingController(text: '$text') : null,
                      fillColor: config.backgroundColor,
                      onTap: () {
                        ref.read(hiddenProvider.notifier).update((state) => false);
                        ref.read(moreProvider.notifier).update((state) => false);
                        scrollDown(duration: 500, trig: false);
                      },
                      onChanged: (val) => ref.read(dataProvider.notifier).update((state) => {'message': val}),
                      onSubmitted: (val) => onSubmit,
                      maxLines: 2,
                      style: const TextStyle(height: 1.45, fontSize: 13)
                    ),
                  ),
                ),

                if(text.isNotEmpty) ...[
                  button(
                      Icons.send,
                      onPressed:onSubmit
                  ),

                ] else button(
                    Icons.mic,
                    onPressed: () { }
                ),

              ],
            ),

            if(watchMore) Divider(height: 12, color: config.secondaryColor.shade50),

            if(watchMore) Container(
              padding: const EdgeInsets.only(top: 10.0),
              constraints: const BoxConstraints(maxHeight: 225, minHeight: 200),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount;
                  double width = constraints.maxWidth;
                  if (width < 300) {
                    crossAxisCount = 2;
                  } else if (width < 350) {
                    crossAxisCount = 3;
                  } else if (width < 500) {
                    crossAxisCount = 4;
                  } else {
                    crossAxisCount = 5;
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final datum = items[index];
                      return InkWell(
                        onTap: () async {
                          // on tap to display
                          if(datum['id'] == '4') {
                            FilePickerResult? result = await FilePicker.platform.pickFiles();

                            if (result != null) {
                              final files = result.files.single;
                              final multipartImage = MultipartFile.fromFileSync('${files.path}',filename: files.name);
                              final filePath = await ref.read(apiServiceProvider).uploadData({
                                "file": multipartImage
                              }, ref);

                              ref.read(dataProvider.notifier).update((state) => {"data": {
                                "type": filePath.type ?? '',
                                "file": filePath.file ?? '',
                                "name": files.name,
                              }});

                              onSubmit();
                            }
                          }
                        },
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Card(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Icon(datum['icon'], size: 26, color: config.secondaryColor.shade400),
                              ),
                            ),

                            labels.label('${datum['label']}', color: Colors.black87, fontSize: 13, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onSubmit() async {

    // Define topic as Map<String, String>
    Map<String, String> topic = {};

    // Consolidate conditions to determine topic
    if (widget.chatData.id != '0') {
      topic = {'topic_id': '${widget.chatData.id}'};
    } else if (widget.chatData.to_id != '0') {
      topic = {'to_id': '${widget.chatData.to_id}'};
    } else if (widget.chatData.adid != '0') {
      topic = {'adid': '${widget.chatData.adid}'};
    }

    // Update state immutably
    ref.read(dataProvider.notifier).update((state) => {
      ...state,
      ...topic,
    });

    print(ref.watch(dataProvider));

    /// submit data ///
    await ref.read(apiServiceProvider).submitData(ref.watch(dataProvider), ref);

    /// clear ///
    ref.read(dataProvider.notifier).update((state) => {});
    scrollDown(trig: false);
  }

  Widget button(IconData? icon, {
    required void Function()? onPressed,
  }) {
    return SizedBox(
      width: 38,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 24, color: config.primaryAppColor.shade600),
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    );
  }
}

class BodyChatDetails extends StatelessWidget {
  const BodyChatDetails(this.ref, {super.key, required this.chatData, required this.watchConversation,
  required this.scrollController, required this.fetching});

  final WidgetRef ref;
  final ChatData chatData;
  final AsyncValue<List<ConData>> watchConversation;
  final ScrollController scrollController;
  final int fetching;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      reverse: true,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1, (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 14),
                  if(!watchConversation.isLoading && fetching > 1) const Center(child: CircularProgressIndicator(strokeWidth: 3)),
                  const SizedBox(height: 14),

                  watchConversation.when(
                    error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                    loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 3)),
                    data: (data) {
                      return Flex(
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
                                    generateType(context, val),

                                    const SizedBox(height: 6),

                                    labels.labelIcon(
                                        rightTitle: '${stringToTimeAgoDay(date: '${val.send_date}', format: 'dd, MMM yyyy HH:mm')}',
                                        rightIcon: (val.is_read == true) ? Padding(
                                          padding: const EdgeInsets.only(left: 4.0),
                                          child: Icon(Icons.check, size: 12, color: config.secondaryColor.shade200),
                                        ) : null,
                                        style: TextStyle(fontSize: 11, color: config.secondaryColor.shade200, fontFamily: 'en')
                                    ),

                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                  ),

                ],
              ),
            );
          }),
        ),
      ]
    );
  }

  Widget generateType(BuildContext context, ConData val) {
    switch(val.type) {
      case 'text':
        return typeText(val);
      case 'photos' || 'photo':
        return typeImage(context, val);
      case 'post':
        return typePost(val);
      case 'map':
        return typeMap(val);
      case 'file':
        return typeFile(val);
      default:
        return typeText(val);
    }
  }

  Widget typeText(ConData val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular((val.folder == 'send') ? 20 : 0),
          bottomRight: Radius.circular((val.folder == 'send') ? 0 : 20),
        ),
        color: Colors.white,
        border: Border.all(color: config.secondaryColor.shade50),
      ),
      constraints: const BoxConstraints(maxWidth: 250),
      child: labels.selectLabel('${val.message}', fontSize: 15, color: Colors.black87),
    );
  }

  Widget typeImage(BuildContext context, ConData val) {

    if(val.type == 'photos') {
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
              InkWell(
                onTap: () { if(values['image'] != null) viewImage(context, '${values['image']}'); },
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300, minWidth: 200, maxHeight: 300, minHeight: 200),
                  color: Colors.white,
                  child: Image.network('${values['image']}', fit: BoxFit.cover),
                ),
              ),
          ],
        ),
      );
    }

    /// single image ///
    final img = ConImage.fromJson(val.data ?? {});
    return InkWell(
      onTap: () { if(img.image != null) viewImage(context, '${img.image}'); },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular((val.folder == 'send') ? 20 : 0),
          bottomRight: Radius.circular((val.folder == 'send') ? 0 : 20),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300, minWidth: 200, maxHeight: 300, minHeight: 200),
          color: Colors.white,
          child: Image.network('${img.image}', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget typePost(ConData val) {
    final data = ChatPost.fromJson(val.data ?? {});

    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular((val.folder == 'send') ? 20 : 0),
            bottomRight: Radius.circular((val.folder == 'send') ? 0 : 20),
          ),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network('${data.thumbnail}', fit: BoxFit.cover),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labels.selectLabel('${data.title}', color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
                  labels.selectLabel('\$${data.price??0.00}', color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget typeMap(ConData val) {
    final data = ChatPost.fromJson(val.data ?? {});

    BorderRadiusGeometry borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular((val.folder == 'send') ? 20 : 0),
      bottomRight: Radius.circular((val.folder == 'send') ? 0 : 20),
    );

    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Image.asset('assets/img/maps.png', fit: BoxFit.cover),
            ),
          ),

          Positioned(
            child: Container(
              width: double.infinity,
              height: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(25),
              child: buttons.textButtons(
                title: 'Show Location on Map',
                onPressed: () { },
                padSize: 10,
                textSize: 14,
                textColor: config.secondaryColor.shade400,
                textWeight: FontWeight.w500,
                prefixIcon: Icons.location_pin,
                prefColor: config.secondaryColor.shade400,
                prefixSize: 20,
                bgColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget typeFile(ConData val) {
    final data = ChatPost.fromJson(val.data ?? {});

    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: ListTile(
        onTap: () {},
        leading: Icon(Icons.file_copy_rounded, size: 34, color: config.secondaryColor.shade400),
        tileColor: Colors.white,
        title: labels.label('${data.name}', fontSize: 15, maxLines: 1, color: Colors.black87),
        subtitle: labels.label('${data.size}', fontSize: 12, color: Colors.black54),
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular((val.folder == 'send') ? 20 : 0),
            bottomRight: Radius.circular((val.folder == 'send') ? 0 : 20),
          ),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
    );
  }
}



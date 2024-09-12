
// ignore_for_file: unused_result

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/chats/chat_provider.dart';
import 'package:k24/pages/chats/conversations/chat_conversation_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../helpers/functions.dart';
import '../../../serialization/chats/chat_serial.dart';
import '../../../serialization/chats/conversation/conversation_serial.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/dialog_builder.dart';
import '../../accounts/profile_public/another_profile.dart';
import '../../details/details_post.dart';

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
  late TextEditingController controller;
  StateProvider<bool> hiddenProvider = StateProvider((ref) => false);
  StateProvider<bool> moreProvider = StateProvider((ref) => false);
  StateProvider<int> lengthProvider = StateProvider((ref) => 1);
  StateProvider<double> pixelsPro = StateProvider((ref) => 0);
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
    controller = TextEditingController();
    scrollDown(duration: 5000);
    scrollController.addListener(() => onScroll(
      ref,
      scrollController,
      lengthProvider,
      widget.chatData,
      pixelsPro,
    ));
  }

  void scrollDown({int duration = 1000, bool trig = true}) {
    futureAwait(duration: duration, () {
      if(trig) trigger(widget.chatData);
      if(mounted) scrollController.jumpTo(0);
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
    final provider = conversationPageProvider(
        ref,
        widget.chatData.id,
        jsonEncode(widget.chatData.last_message?.toJson() ?? {}),
        widget.chatData.to_id
    );
    final watchConversation = ref.watch(provider);
    final text = ref.watch(dataProvider)['message']??'';
    final watchMore = ref.watch(moreProvider);

    final List<Map<String, dynamic>> items = [
      {'id': '0', 'icon': Icons.location_on, 'label': 'Location'},
      {'id': '1', 'icon': Icons.chat, 'label': 'Quick chat'},
      {'id': '2', 'icon': Icons.business, 'label': 'Business card'},
      {'id': '4', 'icon': Icons.attach_file, 'label': 'Attach file'},
      {'id': '5', 'icon': Icons.description, 'label': 'Resume (CV)'},
      {'id': '6', 'icon': Icons.local_shipping, 'label': 'Shipping / Billing Address'},
      {'id': '7', 'icon': Icons.ads_click, 'label': '${widget.chatData.user?.username??'N/A'} ads'},
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
          title: labels.label(widget.chatData.user?.name??'', fontSize: 18, fontWeight: FontWeight.w500, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: labels.label(widget.chatData.user?.online_status?.last_active??'', fontSize: 14, maxLines: 1),
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
      floatingActionButton: (ref.watch(pixelsPro) > 1000) ? IconButton(
        onPressed: () { scrollDown(duration: 100, trig: false); },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
          elevation: WidgetStateProperty.all<double>(5.0),
          shadowColor: WidgetStateProperty.all<Color>(Colors.black),
        ),
        icon: const Icon(Icons.arrow_downward, size: 20,),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

                      await onSubmit(provider);
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
                      controller: controller,
                      fillColor: config.backgroundColor,
                      onTap: () {
                        ref.read(hiddenProvider.notifier).update((state) => false);
                        ref.read(moreProvider.notifier).update((state) => false);
                        scrollDown(duration: 500, trig: false);
                      },
                      onChanged: (val) => ref.read(dataProvider.notifier).update((state) => {'message': val}),
                      onSubmitted: (val) => onSubmit,
                      maxLines: 2,
                      style: const TextStyle(height: 1.45, fontSize: 15),
                    ),
                  ),
                ),

                if(text.isNotEmpty) ...[
                  button(
                      Icons.send,
                      onPressed: () => onSubmit(provider)
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
              color: config.backgroundColor,
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

                              await onSubmit(provider);
                            }
                          }
                        },
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Card(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              surfaceTintColor: Colors.grey.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
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

  Future<void> onSubmit(ConversationPageProvider provider) async {
    // Define topic as Map<String, String>
    Map<String, String> topic = {};

    // Consolidate conditions to determine topic
    final chat = widget.chatData;
    if (chat.id != null && chat.id!.isNotEmpty && chat.id != '0') {
      topic = {'topic_id': '${chat.id}'};
    } else if (chat.to_id != null && chat.to_id!.isNotEmpty && chat.to_id != '0') {
      topic = {'to_id': '${chat.to_id}'};
    } else {
      topic = {'adid': '${chat.adid}'};
    }

    // Update state immutably
    ref.read(dataProvider.notifier).update((state) => {
      ...state,
      ...topic,
    });

    print(ref.watch(dataProvider));

    /// submit data ///
    final result = await ref.read(apiServiceProvider).submitData(ref.watch(dataProvider), ref);
    if(result.id != null) ref.read(provider.notifier).addNew(result);

    /// clear ///
    controller.clear();
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

                                    Tooltip(
                                      message: '${stringToString(date: '${val.send_date}', format: 'dd, MMM yyyy HH:mm')}',
                                      waitDuration: const Duration(milliseconds: 1),
                                      showDuration: const Duration(seconds: 3),
                                      verticalOffset: 10,
                                      child: labels.labelIcon(
                                          rightTitle: '${stringToTimeAgoDay(date: '${val.send_date}', format: 'dd, MMM yyyy HH:mm')}',
                                          rightIcon: Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: FaIcon(
                                              (val.is_read == true) ? FontAwesomeIcons.checkDouble : FontAwesomeIcons.check,
                                              size: 12,
                                              color: config.secondaryColor.shade200,
                                            ),
                                          ),
                                          style: TextStyle(fontSize: 11, color: config.secondaryColor.shade200, fontFamily: 'en')
                                      ),
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
        return typePost(context, val);
      case 'map':
        return typeMap(context, val);
      case 'file':
        return typeFile(context, val);
      case 'business_card':
        return typeBusiness(context, val);
      case 'resume':
        return typeResume(context, val);
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

  Widget typeBusiness(BuildContext context, ConData val) {
    final usePro = ref.watch(usersProvider);
    final dataMore = DataMore.fromJson(val.data ?? {});

    return Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          /// header ///
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              backgroundImage: NetworkImage('${(val.folder == 'send') ? usePro.user?.photo?.url : chatData.user?.photo?.url}'),
            ),
            dense: true,
            horizontalTitleGap: 10,
            contentPadding: const EdgeInsets.only(left: 14),
            title: labels.label((val.folder == 'send') ? usePro.user?.name??'N/A' : chatData.user?.name??'N/A', fontSize: 15, color: Colors.black87),
            subtitle: labels.label('@${(val.folder == 'send') ? usePro.user?.username??'N/A' : chatData.user?.username}', fontSize: 12, color: Colors.black54),
            trailing: IconButton(
              onPressed: () { },
              icon: const Icon(Icons.more_vert_rounded, size: 20, color: Colors.black54,),
            ),
          ),
          Divider(height: 2, color: config.secondaryColor.shade50,),

          /// header ///
          Container(
            // width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              children: [
                ListUI(icon: Icons.business_outlined, title: dataMore.company ?? 'N/A',),
                const SizedBox(height: 4,),
                ListUI(icon: Icons.call, title: (dataMore.phone ?? []).join(', '),),
                const SizedBox(height: 4,),
                ListUI(icon: Icons.email, title: dataMore.email ?? 'N/A',),
                const SizedBox(height: 4,),
                ListUI(icon: CupertinoIcons.location_solid, title: '${dataMore.address??''}${(dataMore.address??'').isNotEmpty ? ', ':''}${dataMore.location?.long_location ?? 'N/A'}',),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget typeResume(BuildContext context, ConData val) {
    final dataMore = ResumeData.fromJson(val.data ?? {});

    return Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          /// header ///
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              backgroundImage: NetworkImage(dataMore.photo?.url ?? ''),
            ),
            dense: true,
            horizontalTitleGap: 10,
            contentPadding: const EdgeInsets.only(left: 14),
            title: labels.label('Resume', fontSize: 12, color: Colors.black54,),
            subtitle: labels.label(dataMore.name??'N/A', fontSize: 15, color: Colors.black87,),
            trailing: IconButton(
              onPressed: () { },
              icon: const Icon(Icons.more_vert_rounded, size: 20, color: Colors.black54,),
            ),
          ),

          /// text descriptions ///
          Container(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                labels.labelRich(dataMore.education_level?.title??'N/A', title2: 'Education Level: ', fontSize: 14, color: Colors.black87,),
                labels.labelRich('${dataMore.work_experience??'N/A'}+ Year', title2: 'Working Experience: ', fontSize: 14, color: Colors.black87,),
                labels.labelRich(dataMore.position??'N/A', title2: 'Current Position: ', fontSize: 14, color: Colors.black87,),
                const SizedBox(height: 8,),

                buttons.textButtons(
                  title: 'View Resume(CV)',
                  onPressed: () {},
                  radius: 24.0,
                ),

              ],
            ),
          )
        ],
      ),
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

  Widget typePost(BuildContext context, ConData val) {
    final data = ChatPost.fromJson(val.data ?? {});

    return InkWell(
      onTap: () {
        routeAnimation(context, pageBuilder: DetailsPost(
          title: '${data.title}',
          data: GridCard(data: Data_.fromJson(data.toJson()),),
        ));
      },
      child: Container(
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
                  child: (data.thumbnail != null) ? Image.network('${data.thumbnail}', fit: BoxFit.cover)
                  : Container(
                    color: config.primaryAppColor.shade50,
                    alignment: Alignment.center,
                    child: labels.label('${data.title}', color: config.primaryAppColor.shade600, fontSize: 15, fontWeight: FontWeight.w500, maxLines: 2),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labels.label('${data.title}', color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
                    labels.label('\$${data.price??0.00}', color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget typeMap(BuildContext context, ConData val) {
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
                onPressed: () {
                  openMap('${data.lat ?? mapX}', '${data.lng ?? mapY}');
                },
                padSize: 10,
                textSize: 13,
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

  Widget typeFile(BuildContext context, ConData val) {
    final data = ChatPost.fromJson(val.data ?? {});

    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: ListTile(
        onTap: () {
          openLinkFunction(data.file ?? mainUrl);
        },
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

class ListUI extends StatelessWidget {
  const ListUI({super.key,
    required this.icon,
    required this.title,
  });

  final IconData? icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Icon(icon, size: 18, color: Colors.black54,),
        ),
        const SizedBox(width: 8,),
        Expanded(child: labels.selectLabel(title ?? 'N/A', fontSize: 15, color: Colors.black54)),
      ],
    );
  }
}




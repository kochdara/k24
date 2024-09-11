
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/functions.dart';
import 'package:k24/pages/accounts/profile_public/another_profile.dart';
import 'package:k24/pages/chats/comments/comments_provider.dart';
import 'package:k24/pages/details/details_post.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/chats/comments/comments_serial.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../helpers/helper.dart';
import '../../../serialization/users/user_serial.dart';

final config = Config();
final labels = Labels();
final forms = Forms();
final myCards = MyCards();

late StateProvider<CommentDatum?> replyIdPro;

class ConversationCommentPage extends ConsumerStatefulWidget {
  const ConversationCommentPage({super.key, this.commentData, required this.comObject});

  final CommentDatum? commentData;
  final CommentObject comObject;

  @override
  ConsumerState<ConversationCommentPage> createState() => _ConversationCommentPageState();
}

class _ConversationCommentPageState extends ConsumerState<ConversationCommentPage> {
  final commentApi = Provider((ref) => CommentApiService());
  late TextEditingController controller;
  late FocusNode focusNode;
  final ScrollController _scrollController = ScrollController();
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final pixels = _scrollController.position.pixels;
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent-50 && pixels <= maxScrollExtent) {
        _fetchMoreData();
      }
    });
    setupPage();
  }

  Future<void> _fetchMoreData() async {
    final objectData = widget.comObject;
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(conversationCommentsProvider(
      ref,
      '${objectData.data?.id}', 'oldest',
    ).notifier);
    fetchMore.fetchComments();
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  setupPage() {
    replyIdPro = StateProvider((ref) => null);
    controller = TextEditingController();
    focusNode = FocusNode();
    futureAwait(() async {
      final objectData = widget.commentData;
      await submitMarkReadComment('${objectData!.id}', ref);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final objectData = widget.comObject;
    final sendComment = ref.watch(commentApi);
    final replyId = ref.watch(replyIdPro);
    final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
    final conversation = conversationCommentsProvider(ref, '${objectData.data?.id}', 'oldest',);
    final watchConversation = ref.watch(conversation);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          onTap: () {
            routeAnimation(context, pageBuilder: DetailsPost(
              title: '${objectData.data?.title}',
              data: GridCard(
                data: Data_.fromJson(objectData.data?.toJson() ?? {})
              ),
            ));
          },
          leading: SizedBox(
            width: 40,
            height: 40,
            child: (objectData.data?.thumbnail != null) ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(placeholder: placeholder, image: '${objectData.data?.thumbnail}', fit: BoxFit.cover),
            ) : Container(
              decoration: BoxDecoration(color: config.secondaryColor.shade50, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.shopping_cart, color: config.secondaryColor.shade200),
            ),
          ),
          title: labels.label('${objectData.data?.title ?? 'N/A'} >', fontSize: 18, fontWeight: FontWeight.w500, maxLines: 1),
          subtitle: labels.label('\$${objectData.data?.price ?? 0}', fontSize: 14, maxLines: 1),
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
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(conversation.notifier).refresh();
          ref.read(isLoadingPro.notifier).state = false;
          ref.read(lengthPro.notifier).state = 1;
        },
        child: BodyComments(
          ref,
          watchConversation: watchConversation,
          objectData: objectData,
          scrollController: _scrollController,
          isLoadingPro: isLoadingPro,
          lengthPro: lengthPro,
          focusNode: focusNode,
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 4, bottom: bottomHeight + 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            if(replyId != null && replyId.id != null) Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  labels.label('Reply to ', color: Colors.black54, fontSize: 13),
                  labels.label(replyId.profile?.data?.name ?? 'N/A', color: Colors.black87, fontSize: 13),
                  IconButton(
                    onPressed: () { ref.read(replyIdPro.notifier).state = null; },
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    icon: const Icon(Icons.close, size: 18, color: Colors.black87,),
                    iconSize: 18,
                  )
                ],
              ),
            ),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: forms.formField(
                        hintText: 'Type your message',
                        fillColor: config.backgroundColor,
                        controller: controller,
                        focusNode: focusNode,
                        maxLines: 2,
                        style: const TextStyle(height: 1.45, fontSize: 15)
                    ),
                  ),
                ),

                button(Icons.send, onPressed: () async {
                  if(controller.text.trim().isNotEmpty) {
                    Map<String, dynamic> data = {
                      if(replyId != null && replyId.id != null) 'reply_id': replyId.id ?? ''
                      else 'id': '${objectData.data?.id}',
                      'comment': controller.text,
                    };
                    futureAwait(duration: 250, () {
                      controller.clear();
                      ref.read(replyIdPro.notifier).state = null;
                    });
                    final result = await sendComment.submitAddComment(data, ref);
                    print(result.toJson());
                    print(data);
                  }
                },),

              ],
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
        icon: Icon(icon, size: 24, color: config.primaryAppColor.shade600),
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    );
  }
}

class BodyComments extends StatelessWidget {
  const BodyComments(this.ref, {super.key,
    required this.watchConversation,
    required this.objectData,
    required this.scrollController,
    required this.isLoadingPro,
    required this.lengthPro,
    required this.focusNode,
  });

  final WidgetRef ref;
  final AsyncValue<List<CommentDatum>> watchConversation;
  final CommentObject objectData;
  final ScrollController scrollController;
  final StateProvider<bool> isLoadingPro;
  final StateProvider<int> lengthPro;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: watchConversation.when(
            error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
            loading: () => const Padding(
              padding: EdgeInsets.all(14.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            data: (data) {
              return Flex(direction: Axis.vertical,
                children: [
                  for(final datum in data) CardUIComments(
                    datum: datum, objectData: objectData,
                    focusNode: focusNode,
                    oldDatum: datum,
                  ),

                  if(ref.watch(isLoadingPro) && ref.watch(lengthPro) > 0) Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: const CircularProgressIndicator(),
                  ) else if(ref.watch(lengthPro) <= 0) const NoMoreResult(),
                ],
              );
            }
        ),
      ),
    );
  }
}

class CardUIComments extends ConsumerStatefulWidget {
  const CardUIComments({super.key, required this.datum,
    required this.objectData,
    required this.oldDatum,
    required this.focusNode,
  });

  final CommentDatum datum;
  final CommentDatum oldDatum;
  final CommentObject objectData;
  final FocusNode focusNode;

  @override
  ConsumerState<CardUIComments> createState() => _CardUICommentsState();
}

class _CardUICommentsState extends ConsumerState<CardUIComments> {
  late StateProvider<CommentDatum> datumPro;

  @override
  void initState() {
    super.initState();
    datumPro = StateProvider((ref) => CommentDatum());
  }

  @override
  Widget build(BuildContext context) {
    final objectData = widget.objectData;
    final datum = widget.datum;
    final result = ref.watch(replyCommentsProvider(
      ref,
      '${objectData.data?.id}', 'newest', '${datum.id}',
    ));

    final watchReply = ref.watch(datumPro);

    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => routeAnimation(context, pageBuilder: AnotherProfilePage(
              userData: User_(
                name: datum.profile?.data?.name,
                username: datum.profile?.data?.username,
                online_status: datum.profile?.data?.online_status,
                photo: CoverProfile(
                  url: datum.profile?.data?.photo,
                ),
              )),
            ),
            child: Stack(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: (datum.profile?.data?.photo != null) ? ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: placeholder,
                      image: '${datum.profile?.data?.photo}',
                      fit: BoxFit.cover,
                    ),
                  ) : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: config.secondaryColor.shade50),
                    ),
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),

                if(datum.profile?.data?.online_status?.is_active == true) Positioned(
                  bottom: -1,
                  right: -1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Icon(Icons.circle_rounded, color: Colors.greenAccent.shade700, size: 8),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                color: Colors.white,
                border: Border.all(color: config.secondaryColor.shade50),
              ),
              constraints: const BoxConstraints(maxWidth: 250),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 40, top: 5, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => routeAnimation(context, pageBuilder: AnotherProfilePage(
                              userData: User_(
                                name: datum.profile?.data?.name,
                                username: datum.profile?.data?.username,
                                online_status: datum.profile?.data?.online_status,
                                photo: CoverProfile(
                                  url: datum.profile?.data?.photo,
                                ),
                              ),),
                            ),
                            child: labels.label(datum.profile?.data?.name ?? 'User: N/A', fontSize: 14, color: Colors.black87, maxLines: 1)),
                        ),
                        labels.selectLabel(datum.comment ?? 'Text: N/A', fontSize: 14, color: Colors.black54),
                      ],
                    ),
                  ),

                  Positioned(
                    top: -4,
                    right: -2,
                    child: MoreButtonUI(listData: [
                      MoreTypeInfo('copy', 'Copy', Icons.copy, null, () {
                        copyFunction(context, datum.comment ?? '');
                      }),
                      if(datum.actions != null && datum.actions!.contains('delete'))
                        MoreTypeInfo('delete', 'Delete', CupertinoIcons.trash, null, () { }),
                    ],),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Tooltip(
                        message: '${stringToString(date: '${datum.date}', format: 'dd, MMM yyyy HH:mm')}',
                        waitDuration: const Duration(milliseconds: 10),
                        showDuration: const Duration(seconds: 3),
                        verticalOffset: 10,
                        child: labels.label('${stringToTimeAgoDay(date: '${datum.date}', format: 'dd, MMM yyyy')}', fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(width: 14),
                      if(datum.actions != null && datum.actions!.contains('reply')) InkWell(
                        onTap: () {
                          widget.focusNode.unfocus();
                          ref.read(replyIdPro.notifier).state = widget.oldDatum;
                          futureAwait(duration: 250, () {
                            widget.focusNode.requestFocus();
                          });
                        },
                        child: labels.label('Reply', fontSize: 12, color: config.warningColor.shade400),
                      ),
                    ],
                  ),

                  if(datum.last_replies != null) ...[
                    const SizedBox(height: 8),

                    if(watchReply.id != null)
                      for(final datum2 in watchReply.last_replies ?? []) CardUIComments(datum: datum2, objectData: objectData,
                        oldDatum: widget.oldDatum,
                        focusNode: widget.focusNode,
                      ),

                    InkWell(
                      onTap: () async {
                        (watchReply.id != null) ?
                        ref.read(datumPro.notifier).update((state) => CommentDatum()) :
                        ref.read(datumPro.notifier).update((state) => result.valueOrNull ?? CommentDatum());
                      },
                      child: labels.label('${watchReply.id != null ? 'Hide' : 'View' } previous reply (${datum.total_reply})', fontSize: 12, color: Colors.blue),
                    ),

                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class MoreButtonUI extends StatelessWidget {
  const MoreButtonUI({super.key,
    required this.listData,
  });

  final List<MoreTypeInfo> listData;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      surfaceTintColor: Colors.white,
      iconSize: 20,
      onSelected: (item) { },
      popUpAnimationStyle: AnimationStyle.noAnimation,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        for (final type in listData) PopupMenuItem(
          height: 34,
          value: 0,
          onTap: () {
            type.onTap!();
          },
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(type.icon, size: 15, color: Colors.black87),
              labels.label(type.description, fontSize: 13, color: Colors.black87),
            ],
          ),
        ),
      ],
    );
  }
}


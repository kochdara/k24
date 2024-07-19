
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/pages/chats/comments/comments_provider.dart';
import 'package:k24/pages/details/details_post.dart';
import 'package:k24/serialization/chats/comments/comments_serial.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../helpers/helper.dart';

final config = Config();
final labels = Labels();
final forms = Forms();
final myCards = MyCards();

enum MoreCommentType { copy, delete }

final Map<MoreCommentType, MoreCommentTypeInfo> moreCommentTypeInfo = {
  MoreCommentType.copy: const MoreCommentTypeInfo('copy', 'Copy'),
  MoreCommentType.delete: const MoreCommentTypeInfo('delete', 'Delete'),
};

class ConversationCommentPage extends ConsumerStatefulWidget {
  const ConversationCommentPage({super.key, this.commentData, required this.comObject});

  final CommentDatum? commentData;
  final CommentObject comObject;

  @override
  ConsumerState<ConversationCommentPage> createState() => _ConversationCommentPageState();
}

class _ConversationCommentPageState extends ConsumerState<ConversationCommentPage> {

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  setupPage() {
    futureAwait(() async {
      final objectData = widget.commentData;
      await submitMarkReadComment('${objectData!.id}', ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final objectData = widget.comObject;
    final bottomHeight = MediaQuery.of(context).viewInsets.bottom;
    final watchConversation = ref.watch(conversationCommentsProvider(
      '${objectData.data?.id}', '0', 'oldest', '0'
    ));

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
      body: BodyComments(
        ref,
        watchConversation: watchConversation,
        objectData: objectData,
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

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: forms.formField(
                        hintText: 'Type your message',
                        controller: TextEditingController(),
                        fillColor: config.backgroundColor,
                        onTap: () {},
                        maxLines: 2,
                        style: const TextStyle(height: 1.45, fontSize: 13)
                    ),
                  ),
                ),

                button(Icons.send, onPressed: () => { },),

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
  });

  final WidgetRef ref;
  final AsyncValue<List<CommentDatum>> watchConversation;
  final CommentObject objectData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  for(final datum in data) CardUIComments(datum: datum, objectData: objectData,),
                ],
              );
            }
        ),
      ),
    );
  }
}

class CardUIComments extends ConsumerWidget {
  CardUIComments({super.key, required this.datum, required this.objectData});

  final CommentDatum datum;
  final StateProvider<CommentDatum> datumPro = StateProvider((ref) => CommentDatum());
  final CommentObject objectData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(replyCommentsProvider(
      '${objectData.data?.id}', '0', 'oldest', '${datum.id}',
    ));

    final watchReply = ref.watch(datumPro);

    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(width: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
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
                        labels.label(datum.profile?.data?.name ?? 'N/A', fontSize: 14, color: Colors.black87, maxLines: 1),
                        labels.selectLabel(datum.comment ?? 'N/A', fontSize: 14, color: Colors.black54),
                      ],
                    ),
                  ),

                  const Positioned(
                    top: -4,
                    right: -2,
                    child: MoreButtonUI(),
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
                      labels.selectLabel('${stringToTimeAgoDay(date: '${datum.date}', format: 'dd, MMM yyyy')}', fontSize: 12, color: Colors.black54),
                      const SizedBox(width: 14),
                      InkWell(
                        onTap: () { },
                        child: labels.label('Reply', fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),

                  if(datum.last_replies != null) ...[
                    const SizedBox(height: 8),

                    if(watchReply.id != null)
                      for(final datum2 in watchReply.last_replies ?? []) CardUIComments(datum: datum2, objectData: objectData),

                    InkWell(
                      onTap: () async {
                        (watchReply.id != null) ?
                        ref.read(datumPro.notifier).update((state) => CommentDatum()) :
                        ref.read(datumPro.notifier).update((state) => result.valueOrNull ?? CommentDatum());
                      },
                      child: labels.label('View previous reply (${datum.total_reply})', fontSize: 12, color: Colors.black87),
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
  const MoreButtonUI({super.key
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      surfaceTintColor: Colors.white,
      iconSize: 20,
      onSelected: (item) { },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        for (final type in MoreCommentType.values) PopupMenuItem(
          height: 42,
          value: 0,
          onTap: () { },
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            horizontalTitleGap: 8,
            title: labels.label('${moreCommentTypeInfo[type]?.description}', fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

class MoreCommentTypeInfo {
  final String name;
  final String description;

  const MoreCommentTypeInfo(this.name, this.description);
}

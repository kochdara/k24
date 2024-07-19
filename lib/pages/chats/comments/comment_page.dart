
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/chats/comments/comments_provider.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../helpers/converts.dart';
import '../../../serialization/chats/comments/comments_serial.dart';
import 'conversation_comment.dart';

final myCards = MyCards();
final labels = Labels();
final config = Config();

class CommentPage extends ConsumerStatefulWidget {
  const CommentPage({super.key});

  @override
  ConsumerState<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends ConsumerState<CommentPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchComment =  ref.watch(commentsPagesProvider(ref));

    return RefreshIndicator(
      onRefresh: () => ref.read(commentsPagesProvider(ref).notifier).refresh(),
      notificationPredicate: (val) => !watchComment.isLoading,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              watchComment.when(
                error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                loading: () => const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
                data: (data) {
                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      for(final datum in data) InkWell(
                        onTap: () {
                          routeAnimation(context, pageBuilder: ConversationCommentPage(commentData: datum, comObject: datum.object ?? CommentObject()));
                        },
                        child: Card(
                          surfaceTintColor: Colors.white,
                          shadowColor: Colors.black38,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: config.secondaryColor.shade50),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(datum.object?.data?.thumbnail != null) Container(
                                  width: 89,
                                  height: 89,
                                  margin: const EdgeInsets.only(right: 10.0),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: placeholder,
                                    image: '${datum.object?.data?.thumbnail}',
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flex(direction: Axis.horizontal,
                                        children: [
                                          Expanded(
                                            child: labels.label(datum.object?.data?.title ?? 'N/A', fontSize: 15, color: Colors.black87, maxLines: 1),
                                          ),
                                          if(datum.unread != "0") Icon(Icons.circle_rounded, color: config.primaryAppColor.shade600, size: 8),
                                        ],
                                      ),
                                      labels.label('Total Comments: ${datum.total ?? 0}', color: (datum.unread != "0") ? Colors.black87 : Colors.black54, fontSize: 12),
                                      labels.label('Unread: ${datum.unread ?? 0}', color: (datum.unread != "0") ? Colors.black87 : Colors.black54, fontSize: 12),
                                      labels.label('Date: ${stringToTimeAgoDay(date: '${datum.date}', format: 'dd, MMM yyyy')}', color: (datum.unread != "0") ? Colors.black87 : Colors.black54, fontSize: 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 100),
            ]),
          ),
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/chats/comments/comments_provider.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../helpers/converts.dart';
import '../../../serialization/chats/comments/comments_serial.dart';
import '../../more_provider.dart';
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
  }

  Future<void> _fetchMoreData() async {
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(commentsPagesProvider(ref).notifier);
    fetchMore.fetchComments(ref);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchComment =  ref.watch(commentsPagesProvider(ref));

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(commentsPagesProvider(ref).notifier).refresh();
        ref.read(isLoadingPro.notifier).state = false;
        ref.read(lengthPro.notifier).state = 1;
      },
      notificationPredicate: (val) => !watchComment.isLoading,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              watchComment.when(
                error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                loading: () => const SizedBox(
                  height: 250,
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
                          surfaceTintColor: (datum.unread != "0") ? config.primaryAppColor : Colors.white,
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
                                Container(
                                  width: 89,
                                  height: 89,
                                  margin: const EdgeInsets.only(right: 10.0),
                                  color: config.infoColor.shade50,
                                  child: (datum.object?.data?.thumbnail != null) ? FadeInImage.assetNetwork(
                                    placeholder: placeholder,
                                    image: '${datum.object?.data?.thumbnail}',
                                    fit: BoxFit.cover,
                                  ) : Center(child: labels.label(datum.object?.data?.title ?? 'N/A', color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center, maxLines: 2,)),
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
                                          if(datum.unread != "0") Icon(Icons.circle_rounded, color: config.primaryAppColor.shade600, size: 12),
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

                      if(ref.watch(isLoadingPro) && ref.watch(lengthPro) > 0) Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        child: const CircularProgressIndicator(),
                      ) else if(ref.watch(lengthPro) <= 0) const NoMoreResult(),
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


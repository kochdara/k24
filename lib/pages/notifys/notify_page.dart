
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/pages/notifys/notify_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../helpers/helper.dart';
import '../../serialization/notify/nortify_serial.dart';
import '../details/details_post.dart';

final myWidgets = MyWidgets();
final labels = Labels();
final config = Config();
final myCards = MyCards();

class NotifyPage extends ConsumerStatefulWidget {
  const NotifyPage({super.key});

  @override
  ConsumerState<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends ConsumerState<NotifyPage> {
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMoreData() async {
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(notifyListProvider(ref).notifier);
    fetchMore.fetchHome();
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  Widget build(BuildContext context) {
    final listNotify = ref.watch(notifyListProvider(ref));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: labels.label('Notifications', fontSize: 20, fontWeight: FontWeight.w500),
        ),
        titleSpacing: 6,
        actions: [
          IconButton(
            onPressed: () =>  { },
            padding: const EdgeInsets.all(14),
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(notifyListProvider(ref).notifier).refresh(),
        child: BodyNotify(
          scrollController: _scrollController,
          listNotify: listNotify,
          isLoadingPro: isLoadingPro,
          lengthPro: lengthPro,
        ),
      ),
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 1, null,
      ),
    );
  }
}

class BodyNotify extends ConsumerWidget {
  const BodyNotify({super.key,
    required this.scrollController,
    required this.isLoadingPro,
    required this.listNotify,
    required this.lengthPro,
  });

  final ScrollController scrollController;
  final StateProvider<bool> isLoadingPro;
  final AsyncValue<List<NotifyDatum>> listNotify;
  final StateProvider<int> lengthPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(delegate: SliverChildListDelegate([
          listNotify.when(
            error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () => { }),
            loading: () => Container(
              height: 250,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            data: (data) {
              return Column(
                children: [
                  for(final datum in data) ListTile(
                    onTap: () {
                      routeAnimation(
                        context,
                        pageBuilder: DetailsPost(title: datum.data?.post?.title ?? 'N/A', data: GridCard(data: datum.data?.post)),
                      );
                    },
                    dense: true,
                    isThreeLine: true,
                    leading: (datum.data?.user?.photo?.url != null) ? SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FadeInImage.assetNetwork(placeholder: placeholder, image: '${datum.data?.user?.photo?.url}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ) : Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: config.secondaryColor.shade50,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(Icons.notifications, size: 24, color: Colors.black38,),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    horizontalTitleGap: 10,
                    title: labels.label(datum.title ?? 'N/A', fontSize: 14, color: Colors.black87,),
                    shape: const Border(bottom: BorderSide(color: Colors.black12)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label(datum.message ?? 'N/A',
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        labels.label(stringToTimeAgoDay(date: '${datum.send_date}', format: 'dd, MMM yyyy') ?? 'N/A',
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),

                  if(ref.watch(isLoadingPro) && ref.watch(lengthPro) > 0) Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: const CircularProgressIndicator(),
                  ) else if(ref.watch(lengthPro) <= 0) Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(noMore, fit: BoxFit.contain,),
                        ),
                        labels.label('No More', fontSize: 15, color: Colors.black54),
                      ],
                    ),
                  ),

                ],
              );
            },
          ),
        ]),),
      ],
    );
  }
}


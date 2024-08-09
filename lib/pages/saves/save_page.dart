
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/likes/like_page.dart';
import 'package:k24/pages/saves/save_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/serialization/likes/likes_serial.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../details/details_post.dart';
import '../more_provider.dart';

final myWidgets = MyWidgets();
final labels = Labels();
final config = Config();
final myCards = MyCards();

class SavesPage extends ConsumerStatefulWidget {
  const SavesPage({super.key});

  @override
  ConsumerState<SavesPage> createState() => _SavesPageState();
}

class _SavesPageState extends ConsumerState<SavesPage> {

  late ScrollController scrollController = ScrollController();
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent - 150 && pixels <= maxScrollExtent) {
        fetchMoreData();
      }
    });
  }

  Future<void> fetchMoreData() async {
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(getTotalSaveProvider(ref, 'newest', type: 'all').notifier);
    fetchMore.fetchSaves();
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = getTotalSaveProvider(ref, 'newest', type: 'all');
    final getSaves = ref.watch(getTotalSaveProvider(ref, 'newest', type: 'all'));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => reloadData(),
        child: LikesBody(
          getSaves: getSaves,
          provider: provider,
          scrollController: scrollController,
          isLoadingPro: ref.watch(isLoadingPro),
          lengthPro: ref.watch(lengthPro),
        ),
      ),
      backgroundColor: config.backgroundColor,
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 4, null,
      ),
    );
  }

  Future<void> reloadData() async {
    ref.refresh(getTotalSaveProvider(ref, 'newest', type: 'all').notifier).refresh();
    ref.read(isLoadingPro.notifier).state = false;
    ref.read(lengthPro.notifier).state = 1;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class LikesBody extends ConsumerWidget {
  LikesBody({super.key,
    required this.getSaves,
    required this.provider,
    required this.scrollController,
    required this.isLoadingPro,
    required this.lengthPro,
  });

  final AsyncValue<List<LikesDatum?>?> getSaves;
  final GetTotalSaveProvider provider;
  final ScrollController scrollController;
  final bool isLoadingPro;
  final int lengthPro;
  final sendApi = Provider((ref) => SaveApiService());

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          floating: true,
          title: labels.label('Saves', fontSize: 20, fontWeight: FontWeight.w500),
          titleSpacing: 6,
        ),

        SliverList(delegate: SliverChildListDelegate([
          const SizedBox(height: 12,),

          getSaves.when(
            error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
            loading: () => const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
            ),
            data: (data) {
              return Column(
                children: [

                  for(final datum in data ?? [])
                    Builder(
                      builder: (context) {
                        final fieldData = (datum?.data is Map) ? LikesData.fromJson(datum?.data) : LikesData();

                        return InkWell(
                          onTap: () {
                            if(fieldData.id != null) {
                              routeAnimation(
                                context,
                                pageBuilder: DetailsPost(title: fieldData.title??'N/A', data: GridCard(
                                  type: 'post',
                                  data: Data_.fromJson(fieldData.toJson() ?? {}),
                                )),
                              );
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            surfaceTintColor: Colors.white,
                            elevation: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Stack(
                                children: [
                                  CardViewData(datum: datum,),

                                  // love like //
                                  Positioned(
                                    right: - 4,
                                    bottom: - 4,
                                    child: Container(
                                      color: Colors.white,
                                      child: IconButton(
                                        onPressed: () async {
                                          if(checkLogs(ref)) {
                                            showActionSheet(context, [
                                              MoreTypeInfo('unsave', 'Unsave', null, null, () async {
                                                final send = ref.watch(sendApi);
                                                String idSaves = datum?.id ?? '';
                                                final res = await send.submitRemoveSave(ref, idSaves);
                                                if(res.message != null) {
                                                  ref.read(provider.notifier).removeAt(idSaves);
                                                  alertSnack(context, res.message ?? '');
                                                }
                                              }),
                                            ]);
                                          }
                                        },
                                        icon: Icon(Icons.bookmark, size: 24, color: config.primaryAppColor.shade600,),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    ),

                  if(isLoadingPro && lengthPro > 0) Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: const CircularProgressIndicator(),
                  ) else if(lengthPro <= 0) const NoMoreResult(),

                ],
              );
            },
          ),

          const SizedBox(height: 12,),

        ])),
      ],
    );
  }
}




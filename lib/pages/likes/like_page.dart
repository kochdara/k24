
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/likes/likes_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/serialization/helper.dart';
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

class LikesPage extends ConsumerStatefulWidget {
  const LikesPage({super.key});

  @override
  ConsumerState<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends ConsumerState<LikesPage> {

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

    final fetchMore = ref.read(getTotalLikesProvider(ref, 'newest').notifier);
    fetchMore.fetchLikes('newest');
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = getTotalLikesProvider(ref, 'newest');
    final getLikes = ref.watch(getTotalLikesProvider(ref, 'newest'));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => reloadData(),
        child: LikesBody(
          getLikes: getLikes,
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
    ref.refresh(getTotalLikesProvider(ref, 'newest').notifier).refresh();
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
    required this.getLikes,
    required this.provider,
    required this.scrollController,
    required this.isLoadingPro,
    required this.lengthPro,
  });

  final AsyncValue<List<LikesDatum?>?> getLikes;
  final GetTotalLikesProvider provider;
  final ScrollController scrollController;
  final bool isLoadingPro;
  final int lengthPro;
  final sendApi = Provider((ref) => LikesApiService());

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          floating: true,
          title: labels.label('Likes', fontSize: 20, fontWeight: FontWeight.w500),
          titleSpacing: 6,
        ),

        SliverList(delegate: SliverChildListDelegate([
          const SizedBox(height: 12,),

          getLikes.when(
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
                            routeAnimation(
                              context,
                              pageBuilder: DetailsPost(title: fieldData.title??'N/A', data: GridCard(
                                type: 'post',
                                data: Data_.fromJson(fieldData.toJson() ?? {}),
                              )),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
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
                                              MoreTypeInfo('unlike', 'Unlike', null, null, () async {
                                                final send = ref.watch(sendApi);
                                                String idLikes = datum?.id ?? '';
                                                final res = await send.submitRemoveLike(ref, idLikes);
                                                if(res.message != null) {
                                                  ref.read(provider.notifier).removeAt(idLikes);
                                                  alertSnack(context, res.message ?? '');
                                                }
                                              }),
                                            ]);
                                          }
                                        },
                                        icon: Icon(CupertinoIcons.suit_heart_fill, size: 24, color: config.primaryAppColor.shade600,),
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

class CardViewData extends ConsumerWidget {
  const CardViewData({super.key,
    required this.datum,
  });

  final LikesDatum? datum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = (datum?.data is Map) ? LikesData.fromJson(datum?.data) : LikesData();
    final photos = (data.photo is Map) ? IconSerial.fromJson(data.photo ?? {}) : IconSerial(url: data.photo);
    double height = 140;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: height,
          height: height,
          color: config.secondaryColor.shade50,
          child: ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
            child: ((data.thumbnail ?? (photos.url ?? '')).isNotEmpty) ?
            FadeInImage.assetNetwork(placeholder: placeholder, image: '${data.thumbnail ?? photos.url}', fit: BoxFit.cover)
                : Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              color: config.infoColor.shade50, // Color(0xFFE8F5FB),
              child: labels.label(data.title ?? (data.name ?? 'N/A'), color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center, maxLines: 3,),
            ),
          ),
        ),

        Expanded(
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labels.label(data.title??(data.name ?? 'N/A'), color: config.secondaryColor.shade900, fontSize: 15, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, maxLines: 2),

                    labels.labelIcon(
                      leftIcon: Icon(Icons.location_on_outlined, size: 13, color: config.secondaryColor.shade200),
                      leftTitle: ' ${data.contact?.location?.en_name ?? (data.username ?? 'N/A')}',
                      style: TextStyle(color: config.secondaryColor.shade200, fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'en', height: lineHeight),
                    ),
                  ],
                ),

                if(data.price != null) labels.label('\$${data.price ?? '0.00'}', color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),

              ],
            ),
          ),
        ),
      ],
    );
  }
}





// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../helpers/helper.dart';
import '../../widgets/buttons.dart';
import '../../widgets/labels.dart';
import '../listing/search/search_page.dart';
import 'home_provider.dart';

final Buttons buttons = Buttons();
final Labels labels = Labels();
final Config config = Config();
final MyCards myCards = MyCards();
final MyWidgets myWidgets = MyWidgets();

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final scrollController = ScrollController();
  StateProvider<bool> fetchingProvider = StateProvider<bool>((ref) => false);
  StateProvider<bool> loadingProvider = StateProvider<bool>((ref) => false);
  StateProvider<bool> downProvider = StateProvider<bool>((ref) => false);
  StateProvider<Map> newData = StateProvider((ref) => {});

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() => loadMore(ref, fetchingProvider, downProvider, scrollController, ref.watch(newData)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainCate = ref.watch(getMainCategoryProvider('0'));
    final homeList = ref.watch(homeListsProvider(ref, ref.watch(newData)));
    final bannerAds = ref.watch(getBannerAdsProvider('app', 'image'));

    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => handleRefresh(ref, newData),
        notificationPredicate: (notification) => !homeList.isLoading,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          slivers: <Widget>[
            /// app bar ///
            SliverAppBar(
              title: appBar(),
              floating: true,
            ),

            /// body //
            SliverList(
              delegate: SliverChildListDelegate([
                Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// top ads ///
                        if(bannerAds.hasValue && (bannerAds.value?.data?.listing?.a?.data?.first?.image != null ||
                            bannerAds.value?.data?.listing?.b?.data?.first?.image != null))
                          myCards.ads(
                            url: '${bannerAds.value?.data?.listing?.a?.data?.first?.image ?? bannerAds.value?.data?.listing?.b?.data?.first?.image}',
                            loading: bannerAds.isLoading,
                            links: bannerAds.value?.data?.listing?.a?.data?.first?.link ?? bannerAds.value?.data?.listing?.b?.data?.first?.link,
                          ),

                        /// main category ///
                        mainCate.when(
                          error: (e, st) => Text('Error : $e'),
                          loading: () => myCards.shimmerCategory(),
                          data: (data) => myCards.cardCategory(data),
                        ),

                        /// last title ///
                        myWidgets.titleAds(ref),

                        /// home list ///
                        homeList.when(
                          error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () => handleRefresh(ref, newData)),
                          loading: () => myCards.shimmerHome(viewPage: ref.watch(viewPageProvider)),
                          data: (data) => myCards.cardHome(
                            context,
                            data,
                            fetching: ref.watch(fetchingProvider),
                            viewPage: ref.watch(viewPageProvider),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ]),
            ),

          ],
        ),
      ),
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 0,
        scrollController, visible: !ref.watch(downProvider),
      ),
    );
  }

  Widget appBar() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.arrowtriangle_left_square, color: Colors.white),
            const SizedBox(width: 8),

            labels.label('Khmer24', fontSize: 22, fontWeight: FontWeight.w500),
          ],
        ),

        Positioned(
            right: - 10,
            child: Container(
              decoration: BoxDecoration(
                color: config.primaryAppColor.shade600,
                boxShadow: [
                  BoxShadow(
                    color: config.primaryAppColor.shade600,
                    spreadRadius: 8,
                    blurRadius: 18,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(CupertinoIcons.qrcode, color: Colors.white),
                  ),

                  IconButton(
                    onPressed: () async {
                      final result = await routeNoAnimation(context, pageBuilder: SearchPage(
                        title: 'Search',
                        newData: newData,
                      ));
                      if(result != null) {
                        final homeList = homeListsProvider(
                          ref,
                          ref.watch(newData),
                        );
                        await ref.read(homeList.notifier).refresh();
                        print(ref.watch(newData));
                        print('object: $result');
                      }
                    },
                    icon: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            )
        )
      ],
    );
  }

}

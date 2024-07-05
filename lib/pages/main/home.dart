
// ignore_for_file: unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/profile_public/another_profile.dart';
import 'package:k24/pages/details/details_post.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../widgets/buttons.dart';
import '../../widgets/labels.dart';
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
  StateProvider<bool> down = StateProvider<bool>((ref) => false);
  StateProvider<int> selectedIndex = StateProvider<int>((ref) => 0);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(loadMore);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadMore() async {
    final limit = ref.watch(homeListsProvider(ref).notifier).limit;
    final current = ref.watch(homeListsProvider(ref).notifier).current_result;
    final fet = ref.read(fetchingProvider.notifier);
    ScrollPosition scroll = scrollController.position;

    if (scroll.pixels > 1500 && scroll.pixels >= (scroll.maxScrollExtent - 750)
        && (current >= limit) && !fet.state) {
      fet.state = true;
      ref.read(homeListsProvider(ref).notifier).fetchHome();
      await futureAwait(() { fet.state = false; });
    }

    final r = ref.read(down.notifier);
    final w = ref.watch(down);
    if (scroll.userScrollDirection == ScrollDirection.reverse && !w) {r.state = true;}
    else if (scroll.userScrollDirection == ScrollDirection.forward && w) {r.state = false;}
  }

  Future<void> _handleRefresh() async {
    ref.refresh(getMainCategoryProvider('0').future);
    await ref.read(homeListsProvider(ref).notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final mainCate = ref.watch(getMainCategoryProvider('0'));
    final homeList = ref.watch(homeListsProvider(ref));

    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        notificationPredicate: (notification) => !homeList.isLoading,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: scrollController,
          slivers: <Widget>[
            /// app bar ///
            SliverAppBar(title: appBar(), floating: true),

            /// body //
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 1, (BuildContext context, int index) {
                return Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// top ads ///
                        myCards.ads(url: 'https://images.khmer24.co/banners/2022-10/ABA-1664951593.jpg', loading: mainCate.isLoading),

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
                          error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: _handleRefresh),
                          loading: () => myCards.shimmerHome(viewPage: ref.watch(viewPage)),
                          data: (data) => myCards.cardHome(
                            data,
                            fetching: ref.watch(fetchingProvider),
                            viewPage: ref.watch(viewPage),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
            ),

          ],
        ),
      ),
      bottomNavigationBar: !ref.watch(down) ? myWidgets.bottomBarPage(
        context, ref, selectedIndex,
        scrollController
      ) : null,
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
            right: 0,
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
              child: const Row(
                children: [
                  Icon(CupertinoIcons.qrcode, color: Colors.white),
                  SizedBox(width: 15),
                  Icon(Icons.search, color: Colors.white)
                ],
              ),
            )
        )
      ],
    );
  }

}

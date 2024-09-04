
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/follows/follows_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/accounts/profiles_public/profile_serial.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../helpers/helper.dart';
import '../accounts/profile_public/another_profile.dart';
import '../more_provider.dart';

final labels = Labels();
final config = Config();
final myCards = MyCards();

class FollowsPages extends ConsumerStatefulWidget {
  const FollowsPages({super.key,
    this.profile
  });

  final DataProfile? profile;

  @override
  ConsumerState<FollowsPages> createState() => _FollowsPagesState();
}

class _FollowsPagesState extends ConsumerState<FollowsPages> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setupPage() {
    //
  }

  @override
  Widget build(BuildContext context) {
    final dataPro = widget.profile;
    final userPro = ref.watch(usersProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: labels.label((dataPro?.name ?? dataPro?.username) ?? (userPro.user?.name ?? 'Unknown'), color: Colors.white, fontSize: 20, textAlign: TextAlign.center,),
          titleSpacing: 4,
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: config.primaryAppColor.shade200,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(icon: labels.label('Followers', fontSize: 16, fontWeight: FontWeight.w500)),
              Tab(icon: labels.label('Following', fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        backgroundColor: config.backgroundColor,
        body: TabBarView(
          children: [
            /// page 1 ///
            BodyFollowsPage(keys: 'followers', profile: dataPro,),

            ///  page 2 ///
            BodyFollowsPage(keys: 'following', profile: dataPro,),

          ],
        ),
        bottomNavigationBar: myWidgets.bottomBarPage(
          context, ref, 4, null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class BodyFollowsPage extends ConsumerStatefulWidget {
  const BodyFollowsPage({super.key,
    required this.keys,
    this.profile,
  });

  final String keys;
  final DataProfile? profile;

  @override
  ConsumerState<BodyFollowsPage> createState() => _BodyFollowsPageState();
}

class _BodyFollowsPageState extends ConsumerState<BodyFollowsPage> {
  final ScrollController scrollController = ScrollController();
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent-250 && pixels <= maxScrollExtent) {
        _fetchMoreData();
      }
    });
  }

  Future<void> _fetchMoreData() async {
    if(!mounted) return;
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final provider = getFollowsProvider(ref, widget.keys, username: widget.profile?.username);
    final fetchMore = ref.read(provider.notifier);
    fetchMore.fetchHome();
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  Widget build(BuildContext context) {
    final provider = getFollowsProvider(ref, widget.keys, username: widget.profile?.username);
    final listFollows = ref.watch(provider);
    final isLoading = ref.watch(isLoadingPro);
    final length = ref.watch(lengthPro);

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(provider.notifier).refresh();
        ref.read(isLoadingPro.notifier).state = false;
        ref.read(lengthPro.notifier).state = 1;
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: listFollows.when(
          error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
          loading: () => const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          ),
          data: (data) {
            return Column(
              children: [
                for(final datum in (data ?? [])) Material(
                  color: Colors.transparent,
                  child: ListTile(
                    onTap: () => routeNoAnimation(context, pageBuilder: AnotherProfilePage(userData: User_.fromJson(datum.toJson() ?? {}))),
                    leading: (datum?.photo?.url != null) ? CircleAvatar( /// if have image ///
                      backgroundColor: Colors.black12,
                      backgroundImage: NetworkImage('${datum?.photo?.url}'),
                    ) : Container( /// if not have image ///
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: config.secondaryColor.shade50,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(Icons.person, color: Colors.black54, size: 24,),
                    ),
                    horizontalTitleGap: 12,
                    // dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0,),
                    visualDensity: VisualDensity.compact,
                    // shape: const Border(bottom: BorderSide(color: Colors.black12,)),
                    title: labels.label(datum?.name ?? 'N/A', color: Colors.black87, fontSize: 15,),
                    subtitle: labels.label('@${datum?.username ?? 'N/A'}', color: Colors.black54, fontSize: 12,),
                  ),
                ),

                if(isLoading && length > 0) Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: const CircularProgressIndicator(),
                ) else if(length <= 0) const NoMoreResult(),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}



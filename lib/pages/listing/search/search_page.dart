

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/listing/search/search_provider.dart';
import 'package:k24/pages/listing/search/users/searchuser_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../accounts/profile_public/another_profile.dart';
import '../../details/details_post.dart';
import '../../more_provider.dart';
import '../sub_category.dart';

final Forms forms = Forms();
final Labels labels = Labels();
final Buttons buttons = Buttons();
final MyWidgets myWidgets = MyWidgets();
final Config config = Config();
final myCards = MyCards();

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key, required this.title, required this.newData});

  final String title;
  final StateProvider<Map> newData;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  StateProvider<List> keyVal = StateProvider<List>((ref) => []);
  late TextEditingController title;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    focusNode = FocusNode();
    setupPage();
  }

  Future<void> setupPage() async {
    final keys = await getSecure('keyword', type: Map) ?? [];
    ref.read(keyVal.notifier).update((state) {
      final newList = [...state, ...keys];
      return newList;
    });
    setState(() {
      title.text = ref.watch(widget.newData)['keyword'] ?? '';
      futureAwait(duration: 250, () {
        focusNode.requestFocus();
      });
    });
  }

  void onFieldSubmitted(String val) {
    final newDa = widget.newData;
    final watch = ref.watch(keyVal);
    String tit = widget.title;
    if(val.isEmpty) { focusNode.requestFocus(); return; }

    if (tit.toLowerCase() != 'search') {
      ref.read(newDa.notifier).update((state) {
        final newMap = {...state};
        newMap['keyword'] = val;
        return newMap;
      });
    }

    List uniqueNumbers = {...watch, val}.toList();
    saveSecure('keyword', uniqueNumbers);
    if(tit.toLowerCase() == 'search') { routeNoAnimation(context, pageBuilder: ResultSearchPage(title: val)); }
    else {  Navigator.pop(context, 'success'); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: bodySearch(),
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 0, null
      ),
    );
  }

  Widget bodySearch() {
    final watch = ref.watch(keyVal);

    return CustomScrollView(
      slivers: [
        /// app bar ///
        SliverAppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          pinned: true,
          titleSpacing: 0,
          title: forms.labelFormFields(
            hintText: 'Search...',
            controller: title,
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none)
          ),
          actions: [
            IconButton(
              onPressed: () {
                if(title.text.isNotEmpty) {
                  onFieldSubmitted(title.text);
                } else {
                  focusNode.requestFocus();
                }
              },
              padding: const EdgeInsets.all(14),
              icon: Icon(Icons.search, size: 28, color: config.secondaryColor.shade400),
            )
          ],
        ),

        /// body ///
        if(watch.isNotEmpty) SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1, (context, index) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          labels.label('Recent Search', color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500),
                          IconButton(
                            padding: const EdgeInsets.all(8),
                            onPressed: () {
                              deleteSecure('keyword');

                              setState(() {
                                title.text = '';
                                ref.read(keyVal.notifier).update((state) {
                                  final newList = [];
                                  return newList;
                                });
                                focusNode.unfocus();
                              });
                            },
                            icon: labels.label('Clear', color: config.primaryAppColor.shade600, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),

                    for(final v in watch)
                      ListTile(
                        leading: Icon(CupertinoIcons.arrow_counterclockwise, color: config.secondaryColor.shade300),
                        title: Text('$v'),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                        tileColor: Colors.white,
                        shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              focusNode.unfocus();
                              title.text = '$v';
                            });
                            focusNode.requestFocus();
                          },
                          icon: Icon(Icons.edit, size: 20, color: config.secondaryColor.shade300),
                          padding: const EdgeInsets.all(14),
                        ),
                        onTap: () => onFieldSubmitted('$v'),
                      ),
                  ],
                ),
              ),
            );
          },
          ),
        )

      ],
    );
  }
}





class ResultSearchPage extends ConsumerStatefulWidget {
  const ResultSearchPage({super.key,
    required this.title,
  });

  final String title;

  @override
  ConsumerState<ResultSearchPage> createState() => _ResultSearchPageState();
}

class _ResultSearchPageState extends ConsumerState<ResultSearchPage> {
  late ScrollController scrollController = ScrollController();
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent - 250 && pixels <= maxScrollExtent) {
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

    final postProvider = getSearchPostProvider(ref, widget.title,);
    final fetchMore = ref.read(postProvider.notifier);
    fetchMore.fetchSearchData(widget.title,);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  Future<void> reloadData() async {
    final storeProvider = getSearchUserProvider(ref, 'public_stores', widget.title);
    final userProvider = getSearchUserProvider(ref, 'public_users', widget.title);
    final postProvider = getSearchPostProvider(ref, widget.title,);

    ref.refresh(storeProvider.notifier).refresh();
    ref.refresh(userProvider.notifier).refresh();
    ref.refresh(postProvider.notifier).refresh();
    ref.read(isLoadingPro.notifier).state = false;
    ref.read(lengthPro.notifier).state = 1;
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = getSearchUserProvider(ref, 'public_stores', widget.title);
    final userProvider = getSearchUserProvider(ref, 'public_users', widget.title);
    final postProvider = getSearchPostProvider(ref, widget.title,);

    final storeData = ref.watch(storeProvider);
    final userData = ref.watch(userProvider);
    final postData = ref.watch(postProvider);

    bool isLoading = ref.watch(isLoadingPro);
    int length = ref.watch(lengthPro);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4,
        centerTitle: true,
        title: labels.label('Search: ${widget.title}', fontSize: 17,
          color: Colors.white, fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis, maxLines: 1,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.search, color: Colors.white, size: 26,),
          ),
        ],
      ),
      backgroundColor: config.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => reloadData(),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            /// app bar ///
            SliverAppBar(
              floating: true,
              titleSpacing: 10,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: Row(
                children: [
                  Expanded(
                    child: buttons.textButtons(
                      title: 'User',
                      onPressed: () {
                        routeNoAnimation(context, pageBuilder: UserResultSearchPage(
                          keys: 'public_users',
                          title: widget.title,
                        ));
                      },
                      padSize: 0,
                      textSize: 14,
                      textWeight: FontWeight.w600,
                      textColor: config.primaryAppColor.shade600,
                      bgColor: config.primaryAppColor.shade50,
                    ),
                  ),
                  const SizedBox(width: 10,),

                  Expanded(
                    child: buttons.textButtons(
                      title: 'Company',
                      onPressed: () {
                        routeNoAnimation(context, pageBuilder: UserResultSearchPage(
                          keys: 'public_stores',
                          title: widget.title,
                        ));
                      },
                      padSize: 0,
                      textSize: 14,
                      textWeight: FontWeight.w600,
                      textColor: config.primaryAppColor.shade600,
                      bgColor: config.primaryAppColor.shade50,
                    ),
                  ),
                  const SizedBox(width: 10,),

                  Expanded(
                    child: buttons.textButtons(
                      title: 'Post',
                      onPressed: () {
                        routeNoAnimation(
                          context,
                          pageBuilder: SubCategory(
                            title: 'Sub Category',
                            data: {
                              'id': '',
                              'title': 'Search: ${widget.title}',
                              'slug': '',
                            },
                            condition: false,
                            setFilters: jsonEncode({'keyword': widget.title,}),
                          ),
                        );
                      },
                      padSize: 0,
                      textSize: 14,
                      textWeight: FontWeight.w600,
                      textColor: config.primaryAppColor.shade600,
                      bgColor: config.primaryAppColor.shade50,
                    ),
                  ),
                ],
              ),
            ),

            /// body ///
            SliverList(delegate: SliverChildListDelegate([

              if((storeData.valueOrNull ?? []).isNotEmpty) storeData.when(
                error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
                loading: () => const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                ),
                data: (data) {
                  return Container(
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25), // Shadow color with opacity
                          spreadRadius: 1,                     // How far the shadow spreads
                          blurRadius: 1,                       // Blur effect of the shadow
                          offset: const Offset(1, 1),                // Shadow position (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        labels.label('Company', fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600,),
                        const SizedBox(height: 8,),

                        for(final datum in data ?? []) Material(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              routeAnimation(
                                context,
                                pageBuilder: AnotherProfilePage(userData: User_.fromJson((datum?.toJson()) as Map<String, dynamic>)),
                              );
                            },
                            dense: true,
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: (datum?.logo?.url != null) ? CircleAvatar(
                                backgroundImage: NetworkImage(datum?.logo?.url ?? '',),
                                backgroundColor: Colors.black12,
                              ) : Container(height: 50,
                                decoration: BoxDecoration(color: config.secondaryColor.shade50, borderRadius: BorderRadius.circular(60)),
                                child: Icon(Icons.person, size: 30, color: config.secondaryColor.shade200),
                              ),
                            ),
                            horizontalTitleGap: 10,
                            contentPadding: EdgeInsets.zero,
                            title: labels.label(datum?.username ?? '', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600,maxLines: 1),
                            subtitle: labels.label('@${datum?.username ?? ''}', fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500,maxLines: 1),
                            trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black26, size: 18,),
                          ),
                        ),

                        if((data ?? []).length >= 5) buttons.textButtons(
                          title: 'View More',
                          onPressed: () {
                            routeNoAnimation(context, pageBuilder: UserResultSearchPage(
                              keys: 'public_stores',
                              title: widget.title,
                            ));
                          },
                          padSize: 0,
                          textSize: 14,
                          textWeight: FontWeight.w600,
                          textColor: config.primaryAppColor.shade600,
                          bgColor: config.primaryAppColor.shade50,
                        ),

                      ],
                    ),
                  );
                },
              ),

              if((userData.valueOrNull ?? []).isNotEmpty) userData.when(
                error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
                loading: () => const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                ),
                data: (data) {
                  return Container(
                    margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25), // Shadow color with opacity
                          spreadRadius: 1,                     // How far the shadow spreads
                          blurRadius: 1,                       // Blur effect of the shadow
                          offset: const Offset(1, 1),                // Shadow position (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        labels.label('User', fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600,),
                        const SizedBox(height: 8,),

                        for(final datum in data ?? []) Material(
                          color: Colors.transparent,
                          child: ListTile(
                            onTap: () {
                              routeAnimation(
                                context,
                                pageBuilder: AnotherProfilePage(userData: User_.fromJson((datum?.toJson()) as Map<String, dynamic>)),
                              );
                            },
                            dense: true,
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: (datum?.photo?.url != null) ? CircleAvatar(
                                backgroundImage: NetworkImage(datum?.photo?.url ?? '',),
                                backgroundColor: Colors.black12,
                              ) : Container(height: 50,
                                decoration: BoxDecoration(color: config.secondaryColor.shade50, borderRadius: BorderRadius.circular(60)),
                                child: Icon(Icons.person, size: 30, color: config.secondaryColor.shade200),
                              ),
                            ),
                            horizontalTitleGap: 10,
                            contentPadding: EdgeInsets.zero,
                            title: labels.label(datum?.name ?? 'N/A', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600,maxLines: 1),
                            subtitle: labels.label('@${datum?.username ?? 'N/A'}', fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500,maxLines: 1),
                            trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black26, size: 18,),
                          ),
                        ),

                        if((data ?? []).length >= 5) buttons.textButtons(
                          title: 'View More',
                          onPressed: () {
                            routeNoAnimation(context, pageBuilder: UserResultSearchPage(
                              keys: 'public_users',
                              title: widget.title,
                            ));
                          },
                          padSize: 0,
                          textSize: 14,
                          textWeight: FontWeight.w600,
                          textColor: config.primaryAppColor.shade600,
                          bgColor: config.primaryAppColor.shade50,
                        ),

                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,),
                child:labels.label('Posts', fontSize: 17, color: Colors.black87, fontWeight: FontWeight.w600,),
              ),
              const SizedBox(height: 4,),

              postData.when(
                error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
                loading: () => const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                ),
                data: (data) {
                  return Column(
                    children: [

                      for(final datum in data ?? []) InkWell(
                        onTap: () {
                          routeAnimation(
                            context,
                            pageBuilder: DetailsPost(title: datum?.data?.title??'N/A', data: datum),
                          );
                        },
                        child: ListViewCard(datum: datum),
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

            ])),
          ],
        ),
      ),
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 0, null
      ),
    );
  }
}


class ListViewCard extends StatelessWidget {
  const ListViewCard({super.key,
    required this.datum,
  });

  final GridCard datum;

  @override
  Widget build(BuildContext context) {
    double height = 130;
    final productData = datum.data;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      surfaceTintColor: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: height,
              height: height,
              color: config.secondaryColor.shade50,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
                child: (productData?.thumbnail != null) ?
                  FadeInImage.assetNetwork(placeholder: placeholder, image: productData?.thumbnail ?? '', fit: BoxFit.cover,)
                    : Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  color: config.infoColor.shade50, // Color(0xFFE8F5FB),
                  child: labels.label(productData?.title ?? 'N/A', color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center, maxLines: 3,),
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
                        labels.label(productData?.title ?? 'Title: N/A', color: Colors.black87, fontSize: 15, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500, maxLines: 2),
                        if(productData?.location?.long_location != null) labels.label(productData?.location?.long_location ?? '', color: Colors.black54, fontSize: 12, maxLines: 1,),
                        labels.label(stringToTimeAgoDay(date: '${productData?.renew_date}', format: 'dd, MMM yyyy') ?? 'Date: N/A', color: Colors.black54, fontSize: 12, maxLines: 1,),
                      ],
                    ),
                    labels.label('\$0.00', color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class UserResultSearchPage extends ConsumerStatefulWidget {
  const UserResultSearchPage({super.key,
    required this.keys,
    required this.title,
  });

  final String keys;
  final String title;

  @override
  ConsumerState<UserResultSearchPage> createState() => _UserResultSearchPageState();
}

class _UserResultSearchPageState extends ConsumerState<UserResultSearchPage> {
  late ScrollController scrollController = ScrollController();
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent - 250 && pixels <= maxScrollExtent) {
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

    final userProvider = getSearchUserProvider(ref, widget.keys, widget.title);
    final fetchMore = ref.read(userProvider.notifier);
    fetchMore.fetchSearchData(widget.title,);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  Future<void> reloadData() async {
    final userProvider = getSearchUserProvider(ref, widget.keys, widget.title);
    ref.refresh(userProvider.notifier).refresh();
    ref.read(isLoadingPro.notifier).state = false;
    ref.read(lengthPro.notifier).state = 1;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = getSearchUserProvider(ref, widget.keys, widget.title);

    final userData = ref.watch(userProvider);

    bool isLoading = ref.watch(isLoadingPro);
    int length = ref.watch(lengthPro);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4,
        centerTitle: true,
        title: labels.label('Search: ${widget.title}', fontSize: 17,
          color: Colors.white, fontWeight: FontWeight.w600,
          overflow: TextOverflow.ellipsis, maxLines: 1,
        ),
      ),
      backgroundColor: config.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => reloadData(),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [

            /// body ///
            SliverList(delegate: SliverChildListDelegate([

              userData.when(
                error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
                loading: () => const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                ),
                data: (data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8,),

                      for(final datum in data ?? []) Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        child: Material(
                          elevation: 1,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          child: ListTile(
                            onTap: () {
                              routeAnimation(
                                context,
                                pageBuilder: AnotherProfilePage(userData: User_.fromJson((datum?.toJson()) as Map<String, dynamic>)),
                              );
                            },
                            dense: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            tileColor: Colors.white,
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: (datum?.photo?.url != null || datum?.logo?.url!= null) ? CircleAvatar(
                                backgroundImage: NetworkImage(datum?.photo?.url ?? (datum?.logo?.url ?? ''),),
                                backgroundColor: Colors.black12,
                              ) : Container(height: 50,
                                decoration: BoxDecoration(color: config.secondaryColor.shade50, borderRadius: BorderRadius.circular(60)),
                                child: Icon(Icons.person, size: 30, color: config.secondaryColor.shade200),
                              ),
                            ),
                            horizontalTitleGap: 10,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            title: labels.label(datum?.name ?? (datum?.username ?? 'N/A'), fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600,maxLines: 1),
                            subtitle: labels.label('@${datum?.username ?? 'N/A'}', fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500,maxLines: 1),
                            trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black26, size: 18,),
                          ),
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
              const SizedBox(height: 12,),

            ])),
          ],
        ),
      ),
      bottomNavigationBar: myWidgets.bottomBarPage(
          context, ref, 0, null
      ),
    );
  }
}
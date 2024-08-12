

// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/edit_profile/edit_page.dart';
import 'package:k24/pages/accounts/profiles/profile_provider.dart';
import 'package:k24/pages/jobs/apply_job/apply_job_page.dart';
import 'package:k24/pages/jobs/job_applications/application_provider.dart';
import 'package:k24/pages/jobs/job_applications/jobapplications_page.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/posts/post_provider.dart';
import 'package:k24/pages/saves/save_page.dart';
import 'package:k24/pages/settings/settings_page.dart';
import 'package:k24/serialization/accounts/profiles/profiles_own.dart';
import 'package:k24/serialization/category/main_category.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../../serialization/accounts/profiles_public/profile_serial.dart';
import '../../details/details_post.dart';
import '../../likes/like_page.dart';
import '../../more_provider.dart';
import '../../posts/post_page.dart';
import '../profile_public/profile_provider.dart';

final Labels labels = Labels();
final Buttons buttons = Buttons();
final MyWidgets myWidgets = MyWidgets();
final MyCards myCards = MyCards();
final Config config = Config();
final myAPIService = Provider((ref) => MyAccountApiService());

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final ScrollController scrollController = ScrollController();
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    setupPage();
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent-150 && pixels <= maxScrollExtent) {
        _fetchMoreData();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMoreData() async {
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(ownProfileListProvider(ref).notifier);
    fetchMore.fetchHome();
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  Widget build(BuildContext context) {
    final userPro = ref.watch(usersProvider);
    final providerPro = profilePublicProvider(ref, '${userPro.user?.username}');
    final profilePro = ref.watch(providerPro);
    final provider = ownProfileListProvider(ref);
    final ownProfilePro = ref.watch(provider);

    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(providerPro.future);
          ref.read(provider.notifier).refresh();
          ref.read(isLoadingPro.notifier).state = false;
          ref.read(lengthPro.notifier).state = 1;
        },
        child: BodyProfile(
          ref,
          profilePro: profilePro,
          provider: provider,
          ownProfilePro: ownProfilePro,
          isLoading: ref.watch(isLoadingPro),
          length: ref.watch(lengthPro),
          scrollController: scrollController,
        ),
      ),
      bottomNavigationBar: myWidgets.bottomBarPage(
          context, ref, widget.selectedIndex,
          null
      ),
    );
  }

  void setupPage() async {
    //
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile(this.ref, {super.key,
    required this.profilePro,
    required this.provider,
    required this.ownProfilePro,
    required this.isLoading,
    required this.length,
    required this.scrollController,
  });

  final bool isLoading;
  final ScrollController scrollController;
  final int length;
  final WidgetRef ref;
  final AsyncValue<ProfileSerial?> profilePro;
  final OwnProfileListProvider provider;
  final AsyncValue<List<DatumProfile>> ownProfilePro;

  @override
  Widget build(BuildContext context) {
    final userKey = ref.watch(usersProvider);
    final getBadges = ref.watch(getBadgesAppProvider(ref));
    final valBadges = getBadges.valueOrNull;

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          floating: true,
          leading: Center(
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: config.secondaryColor.shade50,
                borderRadius: BorderRadius.circular(60),
              ),
              child: (userKey.user?.photo?.url != null) ? CircleAvatar(
                backgroundColor: Colors.black12,
                backgroundImage: NetworkImage(userKey.user?.photo?.url ?? ''),
              ) : Icon(Icons.person, color: config.secondaryColor.shade200, size: 26),
            ),
          ),
          title: labels.label('${userKey.user?.name}', fontSize: 20, fontWeight: FontWeight.w500),
          titleSpacing: 6,
          actions: [
            IconButton(
              onPressed: () { },
              icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill, color: Colors.white),
            ),

            IconButton(
              onPressed: () {
                routeNoAnimation(context, pageBuilder: const SettingPage());
              },
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),

        /// body //
        SliverList(
          delegate: SliverChildListDelegate([

            profilePro.when(
              error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
              loading: () => const SizedBox(
                height: 350,
                child: Center(child: CircularProgressIndicator()),
              ),
              data: (data) {
                final datum = data?.data;

                return Flex(
                  direction: Axis.vertical,
                  children: [
                    Stack(
                      children: [
                        // cover of image
                        Column(
                          children: [
                            InkWell(
                              onTap: () { if(datum?.cover?.url != null) viewImage(context, '${datum?.cover?.url}'); },
                              child: Container(
                                color: config.primaryAppColor.shade50,
                                height: 200,
                                width: double.infinity,
                                child: (datum?.cover?.url != null) ? FadeInImage.assetNetwork(
                                    placeholder: placeholder,
                                    image: '${datum?.cover?.url}',
                                  fit: BoxFit.cover,
                                ) : null,
                              ),
                            ),

                            Container(
                              height: 60,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        // profile image
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: InkWell(
                            onTap: () { if(datum?.photo?.url != null) viewImage(context, '${datum?.photo?.url}'); },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: config.secondaryColor.shade100,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.white, width: 4)
                                  ),
                                  alignment: Alignment.center,
                                  width: 94,
                                  height: 94,
                                  child: (datum?.photo?.url != null) ? ClipOval(
                                    child: FadeInImage.assetNetwork(
                                      placeholder: placeholder,
                                      image: '${datum?.photo?.url}',
                                      width: 94,
                                      height: 94,
                                      fit: BoxFit.cover,
                                    ),
                                  ) : const Icon(Icons.person, size: 64, color: Colors.white),
                                ),

                                Positioned(
                                  bottom: 4,
                                  right: 4,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: config.secondaryColor.shade50,
                                    ),
                                    child: Icon(Icons.camera_alt, size: 14, color: config.secondaryColor.shade400),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        // edit profile
                        Positioned(
                            bottom: 4,
                            right: 10,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => { },
                                  icon: const Icon(CupertinoIcons.qrcode, size: 30, color: Colors.black87),
                                ),
                                SizedBox(
                                  height: 36.0,
                                  child: buttons.textButtons(
                                    title: 'Edit Profile',
                                    onPressed: () {
                                      routeAnimation(context, pageBuilder: const EditProfilePage());
                                    },
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                                    textColor: Colors.black87,
                                    bgColor: Colors.transparent,
                                    borderColor: Colors.black54,
                                    padSize: 0
                                  ),
                                ),
                              ],
                            )
                        )
                      ],
                    ),
                    // name, username, followers, following and subscriptions
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            direction: Axis.vertical,
                            children: [
                              labels.label('${userKey.user?.name}', color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w500),
                              Wrap(
                                spacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  labels.label('@${userKey.user?.username}', color: Colors.black54, fontSize: 14),
                                  if(userKey.user?.membership?.title != null) Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: config.primaryAppColor.shade600),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: labels.label('${userKey.user?.membership?.title}', color: config.primaryAppColor.shade600, fontSize: 13),
                                  ),
                                ],
                              ),
                              labels.label('${datum?.followers ?? '0'} followers • ${datum?.following ?? '0'} Following', color: Colors.black54, fontSize: 14),
                            ],
                          ),

                          const SizedBox(height: 8),

                          LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                double width = constraints.maxWidth - 12;
                                return Wrap(
                                  spacing: 10,
                                  runSpacing: 2,
                                  direction: Axis.horizontal,
                                  children: [
                                    ButtonsUI(prefixIcon: Icons.favorite, title: 'Likes', width: width, onPressed: () {
                                      routeNoAnimation(context, pageBuilder: const LikesPage());
                                    }, badge: '0',),
                                    ButtonsUI(prefixIcon: Icons.bookmark, title: 'Saves', width: width, onPressed: () {
                                      routeNoAnimation(context, pageBuilder: const SavesPage());
                                    }, badge: '0',),
                                    ButtonsUI(prefixIcon: Icons.work, title: 'Applied jobs', width: width, onPressed: () {
                                      routeNoAnimation(context, pageBuilder: const ApplyJobPage());
                                    }, badge: '0',),
                                    ButtonsUI(prefixIcon: Icons.assignment, title: 'Job Applications', width: width, onPressed: () {
                                      routeNoAnimation(context, pageBuilder: const JobApplicationPage());
                                    }, badge: valBadges?.data?.newCount ?? '0',),
                                    ButtonsUI(prefixIcon: Icons.description, title: 'Resume (CV)', width: width, onPressed: () => {
                                    }, badge: '0',),
                                    ButtonsUI(prefixIcon: Icons.subscriptions, title: 'Subscription', width: width, onPressed: () => {
                                    }, badge: '0',),
                                  ],
                                );
                              }
                          ),

                          const SizedBox(height: 8),

                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    /// top ads ///
                    myCards.ads(url: 'https://www.khmer24.ws/www/delivery/ai.php?filename=08232023_bannercarsale_(640x290)-2.jpg%20(3)&contenttype=jpeg', loading: false),
                    const SizedBox(height: 8),
                    // manage my ads
                    SegmentedControlExample(
                      provider: provider,
                      ownProfilePro: ownProfilePro,
                      isLoading: isLoading,
                      length: length,
                    ),

                  ],
                );
              },
            ),

          ]),
        ),

      ],
    );
  }
}

enum TypeSelect { active, premiere, expired }
final StateProvider<TypeSelect> selectedSegment = StateProvider((ref) => TypeSelect.active);

class SegmentedControlExample extends ConsumerWidget {
  SegmentedControlExample({super.key,
    required this.provider,
    required this.ownProfilePro,
    required this.isLoading,
    required this.length,
  });

  final OwnProfileListProvider provider;
  final AsyncValue<List<DatumProfile>> ownProfilePro;
  final bool isLoading;
  final int length;

  final Map<TypeSelect, int> skyColors = <TypeSelect, int>{
    TypeSelect.active: 0,
    TypeSelect.premiere: 1,
    TypeSelect.expired: 2,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submitApi = ref.watch(myAPIService);
    final getTotalPostPro = ref.watch(getTotalPostProvider(ref));
    final dataTotal = getTotalPostPro.valueOrNull ?? OwnDataTotalPost();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;

        return Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 6),
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.vertical,
                children: [
                  labels.label('Manage My Ads', fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w500),

                  SizedBox(
                    width: width - 20,
                    child: CupertinoSlidingSegmentedControl<TypeSelect>(
                      backgroundColor: config.secondaryColor.shade50,
                      thumbColor: Colors.white,
                      groupValue: ref.watch(selectedSegment),
                      onValueChanged: (TypeSelect? value) {
                        if (value != null) {
                          ref.read(selectedSegment.notifier).update((state) => value);
                        }
                      },
                      children: <TypeSelect, Widget>{
                        TypeSelect.active: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: labels.label('Active (${dataTotal.active ?? 0})', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
                        ),
                        TypeSelect.premiere: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: labels.label('Premiere (${dataTotal.paid ?? 0})', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
                        ),
                        TypeSelect.expired: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: labels.label('Expired (${dataTotal.expired ?? 0})', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ),

            if(ref.watch(selectedSegment).index == 0) ownProfilePro.when(
              error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () => { }),
              loading: () => myCards.shimmerHome(viewPage: ViewPage.list),
              data: (data) {
                return Flex(
                  direction: Axis.vertical,
                  children: [
                    for(final datum in data) Card(
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: config.secondaryColor.shade50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Flex(
                        direction: Axis.vertical,
                        children: [
                          InkWell(
                            onTap: () => handleView(context, datum),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(datum.thumbnail != null) Container(
                                    width: 125,
                                    height: 125,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: placeholder,
                                      image: '${datum.thumbnail}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        labels.selectLabel(datum.title ?? 'N/A', fontSize: 15, color: Colors.black87),
                                        labels.label('\$${datum.price ?? 0.0}', fontSize: 15, color: Colors.red, fontWeight: FontWeight.w500),
                                        Flex(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: labels.label('ID: ${datum.id}', color: Colors.black54, fontSize: 12),
                                            ),
                                            Expanded(
                                              child: labels.label('View: ${datum.views ?? 0}', color: Colors.black54, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        labels.label('Post Date: ${stringToString(date: '${datum.posted_date}', format: 'dd, MMM yyyy')}', color: Colors.black54, fontSize: 12),
                                        labels.label('Renew Date: ${stringToTimeAgoDay(date: '${datum.renew_date}', format: 'dd, MMM yyyy')}', color: Colors.black54, fontSize: 12),
                                        Flex(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: labels.label('Impression: ${datum.insights?.impression ?? 0}', color: Colors.black54, fontSize: 12),
                                            ),
                                            Expanded(
                                              child: labels.label('Engagement: ${datum.insights?.engagement ?? 0}', color: Colors.black54, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: config.secondaryColor.shade50, height: 0),

                          Row(
                            children: [
                              Expanded(
                                child: buttons.textButtons(
                                  title: 'Renew',
                                  onPressed: !checkDate('${datum.renew_date}') ? () => submitApi.submitRenew(
                                    '${datum.id}', provider,
                                    context: context,
                                    ref: ref,
                                  ) : null,
                                  padSize: 0,
                                  textSize: 14,
                                  textColor: checkDate('${datum.renew_date}') ? Colors.black54 : Colors.black87,
                                  bgColor: Colors.transparent,
                                ),
                              ),

                              Expanded(
                                child: buttons.textButtons(
                                  title: 'Promote',
                                  onPressed: () => { },
                                  padSize: 0,
                                  textSize: 14,
                                  bgColor: Colors.transparent,
                                ),
                              ),

                              Expanded(
                                child: buttons.textButtons(
                                  title: 'Delete',
                                  onPressed: () { },
                                  padSize: 0,
                                  textSize: 14,
                                  bgColor: Colors.transparent,
                                ),
                              ),

                              IconButton(
                                onPressed: () => showActionSheet(context, [
                                  MoreTypeInfo('edit', 'Edit', null, null, () { handleEdit(context, ref, datum); }),
                                  MoreTypeInfo('view_insights', 'View Insights', null, null, () { print('object'); }),
                                  MoreTypeInfo('auto_renew', 'Auto Renew', null, null, () { }),
                                  MoreTypeInfo('share', 'Share', null, null, () { }),
                                ]),
                                padding: const EdgeInsets.all(12.0),
                                icon: const Icon(Icons.more_vert_rounded, color: Colors.black87,),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            if(isLoading && length > 0) Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: const CircularProgressIndicator(),
            ) else if(length <= 0) const NoMoreResult(),

          ],
        );
      },
    );
  }

  void handleView(BuildContext context, DatumProfile datum) {
    final result = GridCard(type: 'post', data: Data_.fromJson(datum.toJson()), actions: datum.actions ?? []);
    routeAnimation(
      context,
      pageBuilder: DetailsPost(title: datum.title ?? 'N/A', data: result),
    );
  }

  Future<void> handleEdit(BuildContext context, WidgetRef ref, DatumProfile datum) async {
    final res = await getEditPostInfoProvider(ref, datum.id ?? '');
    final mainCat = res.data?.post?.category;
    routeAnimation(
      context,
      pageBuilder: NewAdPage(
        mainPro: MainCategory(id: mainCat?.parent ?? '', en_name: '', slug: '', parent: ''),
        subPro: MainCategory(id: mainCat?.id ?? '', en_name: mainCat?.en_name ?? '', parent: mainCat?.parent ?? '',),
        type: 'edit',
        editData: res,
        datum: datum,
      ),
    );
  }

  bool checkDate(String date) {
    DateTime? dateTime = DateTime.tryParse(date);
    final now = DateTime.now();
    final difference = now.difference(dateTime!);
    return difference.inHours < 12;
  }
}

class ButtonsUI extends StatelessWidget {
  const ButtonsUI({super.key, required this.title, required this.onPressed,
    required this.prefixIcon, required this.width,
    required this.badge,
  });

  final String title;
  final IconData? prefixIcon;
  final VoidCallback? onPressed;
  final double width;
  final String badge;

  @override
  Widget build(BuildContext context) {
    final badges = int.tryParse(badge) ?? 0;

    return SizedBox(
      width: width / 2,
      child: Stack(
        children: [
          buttons.textButtons(
            title: title,
            onPressed: onPressed,
            padSize: 8,
            textSize: 14,
            textColor: config.secondaryColor.shade300,
            prefixIcon: prefixIcon,
            prefColor: config.secondaryColor.shade300,
            prefixSize: 18,
            mainAxisAlignment: MainAxisAlignment.start,
          ),

          if(badges > 0) Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: config.warningColor.shade600,
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              child: labels.label('${badges < 100 ? badges : '99+'}', fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}



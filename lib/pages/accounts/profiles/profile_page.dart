

// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/edit_profile/edit_page.dart';
import 'package:k24/pages/accounts/profiles/profile_provider.dart';
import 'package:k24/pages/follows/follows_page.dart';
import 'package:k24/pages/jobs/apply_job/apply_job_page.dart';
import 'package:k24/pages/jobs/job_applications/application_provider.dart';
import 'package:k24/pages/jobs/job_applications/jobapplications_page.dart';
import 'package:k24/pages/jobs/my_resume/check_informations.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/saves/save_page.dart';
import 'package:k24/pages/settings/settings_page.dart';
import 'package:k24/serialization/accounts/profiles/profiles_own.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../../helpers/functions.dart';
import '../../../serialization/accounts/profiles_public/profile_serial.dart';
import '../../likes/like_page.dart';
import '../../more_provider.dart';
import '../profile_public/profile_provider.dart';

final Labels labels = Labels();
final Buttons buttons = Buttons();
final MyWidgets myWidgets = MyWidgets();
final MyCards myCards = MyCards();
final Config config = Config();
final myAPIService = Provider((ref) => MyAccountApiService());
final forms = Forms();

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
  final newMap = StateProvider<Map<String, dynamic>>((ref) => {});
  final StateProvider<TypeSelect> selectedSegment = StateProvider((ref) => TypeSelect.active);

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
    if(!mounted) return;
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    final mapVal = ref.watch(newMap);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(ownProfileListProvider(ref, mapVal).notifier);
    fetchMore.fetchHome(mapVal);
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  Widget build(BuildContext context) {
    final mapVal = ref.watch(newMap);
    final userPro = ref.watch(usersProvider);
    final providerPro = profilePublicProvider(ref, username: '${userPro.user?.username}');
    final profilePro = ref.watch(providerPro);
    final provider = ownProfileListProvider(ref, mapVal);
    final ownProfilePro = ref.watch(provider);
    final loginPro = loginInformationProvider(ref,);

    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          if(!mounted) return;
          ref.refresh(loginPro.future);
          ref.refresh(providerPro.future);
          ref.read(provider.notifier).refresh();
          ref.read(isLoadingPro.notifier).state = false;
          ref.read(lengthPro.notifier).state = 1;
          ref.read(newMap.notifier).state = {};
        },
        child: BodyProfile(
          ref,
          profilePro: profilePro,
          provider: provider,
          ownProfilePro: ownProfilePro,
          isLoading: ref.watch(isLoadingPro),
          length: ref.watch(lengthPro),
          scrollController: scrollController,
          newMap: newMap,
          selectedSegment: selectedSegment,
          loginPro: loginPro,
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
    required this.newMap,
    required this.selectedSegment,
    required this.loginPro,
  });

  final bool isLoading;
  final ScrollController scrollController;
  final int length;
  final WidgetRef ref;
  final AsyncValue<ProfileSerial?> profilePro;
  final OwnProfileListProvider provider;
  final AsyncValue<List<DatumProfile>> ownProfilePro;
  final StateProvider<Map<String, dynamic>> newMap;
  final StateProvider<TypeSelect> selectedSegment;
  final LoginInformationProvider loginPro;

  @override
  Widget build(BuildContext context) {
    final userPro = ref.watch(usersProvider);
    final getBadges = ref.watch(getBadgesAppProvider(ref));
    final valBadges = getBadges.valueOrNull;

    final loginProvider = ref.watch(loginPro);
    final userKey = loginProvider.valueOrNull ?? userPro.user;

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
                border: Border.all(color: Colors.white,),
              ),
              child: (userKey?.photo?.url != null) ? CircleAvatar(
                backgroundColor: Colors.black12,
                backgroundImage: NetworkImage(userKey?.photo?.url ?? ''),
              ) : Icon(Icons.person, color: config.secondaryColor.shade200, size: 26),
            ),
          ),
          title: labels.label('${userKey?.name}', fontSize: 20, fontWeight: FontWeight.w500),
          titleSpacing: 6,
          actions: [
            IconButton(
              onPressed: () { sharedLinks(context, '$mainUrl/${userKey?.username}'); },
              icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill, color: Colors.white),
            ),

            IconButton(
              onPressed: () {
                routeNoAnimation(context, pageBuilder: const SettingPage(checkLog: true,));
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
                        /// cover of image ///
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
                        /// profile image ///
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
                        /// edit profile ///
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
                    /// name, username, followers, following and subscriptions ///
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 2,
                            runSpacing: 4,
                            direction: Axis.vertical,
                            children: [
                              labels.label('${userKey?.name}', color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w500),
                              Wrap(
                                spacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  labels.label('@${userKey?.username}', color: Colors.black54, fontSize: 14),
                                  if(userKey?.membership?.title != null) Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: config.primaryAppColor.shade600),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: labels.label('${userKey?.membership?.title}', color: config.primaryAppColor.shade600, fontSize: 12),
                                  ),
                                ],
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    routeNoAnimation(context, pageBuilder: const FollowsPages());
                                  },
                                  child: labels.label('${datum?.followers ?? '0'} followers • ${datum?.following ?? '0'} Following', color: Colors.black54, fontSize: 14),
                                ),
                              ),
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
                                    ButtonsUI(prefixIcon: Icons.description, title: 'Resume (CV)', width: width, onPressed: () {
                                      routeNoAnimation(context, pageBuilder: const CheckInfoResumePage());
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
                    // myCards.ads(url: 'https://www.khmer24.ws/www/delivery/ai.php?filename=08232023_bannercarsale_(640x290)-2.jpg%20(3)&contenttype=jpeg', loading: false),
                    // const SizedBox(height: 8),

                    // manage my ads
                    SegmentedControlExample(
                      provider: provider,
                      ownProfilePro: ownProfilePro,
                      isLoading: isLoading,
                      length: length,
                      newMap: newMap,
                      selectedSegment: selectedSegment,
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

class SegmentedControlExample extends ConsumerWidget {
  SegmentedControlExample({super.key,
    required this.provider,
    required this.ownProfilePro,
    required this.isLoading,
    required this.length,
    required this.newMap,
    required this.selectedSegment,
  });

  final OwnProfileListProvider provider;
  final AsyncValue<List<DatumProfile>> ownProfilePro;
  final bool isLoading;
  final int length;
  final StateProvider<Map<String, dynamic>> newMap;
  final StateProvider<TypeSelect> selectedSegment;

  final Map<TypeSelect, int> skyColors = <TypeSelect, int>{
    TypeSelect.active: 0,
    TypeSelect.premiere: 1,
    TypeSelect.expired: 2,
  };
  final StateProvider<Map> newVal = StateProvider((ref) => {
    'type': 'active',
    'reason': 'sold',
    'description': '',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submitApi = ref.watch(myAPIService);
    final getTotalPostPro = ref.watch(getTotalPostProvider(ref));
    final dataTotal = getTotalPostPro.valueOrNull ?? OwnDataTotalPost();
    final getReason = ref.watch(getDeleteReasonProvider(ref));
    final getPostFilter = ref.watch(getPostFilterProvider(ref));

    final newFilter = ref.watch(newMap);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;

        return Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 6),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  labels.label('Manage My Ads', fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w500),
                  const SizedBox(height: 6,),

                  Row(
                    children: [
                      Expanded(
                        child: forms.labelFormFields(
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search, size: 24, color: Colors.black54,),
                          onFieldSubmitted: (val) {
                            updateKey(ref, 'keyword', val);
                          },
                        ),
                      ),
                      const SizedBox(width: 10,),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: config.secondaryColor.shade100),
                            borderRadius: BorderRadius.circular(6), // Optional: to give rounded corners
                          ),
                          child: ListTile(
                            onTap: () {
                              final datumVal = getPostFilter.valueOrNull;
                              final newDatum = datumVal?.data ?? [];

                              showActionSheet2(context, [
                                for(final val in newDatum) if(val?.parent == '0') MoreTypeInfo(val?.en_name ?? 'N/A', '', null, images(val?.icon?.url ?? ''), () {
                                  showActionSheet2(context, [
                                    MoreTypeInfo(val?.en_name ?? 'N/A', '', null, images(val?.icon?.url ?? ''), () {
                                      updateKey(ref, 'category', val?.id);
                                      updateKey(ref, 'cateTitle', val?.en_name);
                                    }),
                                    for(final val2 in newDatum) if(val2?.parent == val?.id) MoreTypeInfo(val2?.en_name ?? 'N/A', '', null, images(val2?.icon?.url ?? ''), () {
                                      updateKey(ref, 'category', val2?.id);
                                      updateKey(ref, 'cateTitle', val2?.en_name);
                                    }),
                                  ], title: 'Sub Category');
                                }),
                              ], title: 'Category');
                            },
                            dense: true,
                            visualDensity: VisualDensity.comfortable,
                            contentPadding: const EdgeInsets.only(left: 12,),
                            title: labels.label(newFilter['cateTitle'] ?? 'All Category', color: Colors.black54, fontSize: 15, maxLines: 1, overflow: TextOverflow.ellipsis),
                            trailing: newFilter['cateTitle'] != null ? IconButton(icon: const Icon(Icons.clear_outlined, color: Colors.black54, size: 20,), onPressed: () {
                              updateKey(ref, 'category', null);
                              updateKey(ref, 'cateTitle', null);
                            }, visualDensity: VisualDensity.comfortable,)
                            : const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black54, size: 16,),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),

                  SizedBox(
                    width: width - 20,
                    child: CupertinoSlidingSegmentedControl<TypeSelect>(
                      backgroundColor: config.secondaryColor.shade50,
                      thumbColor: Colors.white,
                      groupValue: ref.watch(selectedSegment),
                      onValueChanged: (TypeSelect? value) {
                        if (value != null) {
                          String? val;
                          if(value == TypeSelect.expired) {
                            val = 'expired';
                          } else if(value == TypeSelect.premiere) {
                            val = 'paid';
                          } else {
                            val = 'active';
                          }
                          updateKey(ref, 'type', val);
                          ref.read(selectedSegment.notifier).update((state) => value);
                        }
                      },
                      children: <TypeSelect, Widget>{
                        TypeSelect.active: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: labels.label('Active (${dataTotal.active ?? 0})', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
                        ),
                        TypeSelect.premiere: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: labels.label('Premiere (${dataTotal.paid ?? 0})', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
                        ),
                        TypeSelect.expired: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: labels.label('Expired (${dataTotal.expired ?? 0})', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ),

            ownProfilePro.when(
              error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () => { }),
              loading: () => myCards.shimmerHome(ref, viewPage: ViewPage.list),
              data: (data) {
                return Flex(
                  direction: Axis.vertical,
                  children: [
                    const SizedBox(height: 6,),

                    for(final datum in data) Card(
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.black38,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: config.secondaryColor.shade50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6,),
                      child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(datum.status_message != null) ListTile(
                            dense: true,
                            horizontalTitleGap: 4,
                            tileColor: Colors.red.shade50,
                            visualDensity: VisualDensity.compact,
                            leading: const Icon(Icons.warning_rounded, color: Colors.black54, size: 18,),
                            title: labels.label(datum.status_message ?? '', color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600, maxLines: 1, overflow: TextOverflow.ellipsis,),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                            ),
                          ),

                          InkWell(
                            onTap: () => handleView(context, datum),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 125,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    color: config.infoColor.shade50,
                                    child: (datum.thumbnail != null) ? FadeInImage.assetNetwork(
                                      placeholder: placeholder,
                                      image: '${datum.thumbnail}',
                                      fit: BoxFit.cover,
                                    ) : Center(child: labels.label(datum.title ?? 'N/A', color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center, maxLines: 2,)),
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        labels.label(datum.title ?? 'N/A', fontSize: 15, color: Colors.black87),
                                        Wrap(
                                          spacing: 6,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            labels.label('\$${datum.price ?? 0.0}', fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600),
                                            if(datum.discount?.original_price != null) labels.label(
                                              '\$${datum.discount?.original_price ?? '0.0'}',
                                              color: Colors.black54,
                                              fontSize: 12,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                            if(datum.discount?.original_price != null) labels.label(
                                              '${discountString(datum.discount?.type, '${datum.discount?.amount_saved}', datum.discount?.original_price)} OFF',
                                              color: config.warningColor.shade500,
                                              fontSize: 13,
                                            ),
                                          ],
                                        ),

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
                              if((datum.actions ?? []).contains('renew')) Expanded(
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

                              if((datum.actions ?? []).contains('promote')) Expanded(
                                child: buttons.textButtons(
                                  title: 'Promote',
                                  onPressed: () => { },
                                  padSize: 0,
                                  textSize: 14,
                                  bgColor: Colors.transparent,
                                ),
                              ),

                              if((datum.actions ?? []).contains('delete')) Expanded(
                                child: buttons.textButtons(
                                  title: 'Delete',
                                  onPressed: () async {
                                    final res = await showDeleteReasonDialog(context, ref, getReason.valueOrNull, newVal);
                                    if(res != null) {
                                      submitApi.submitDelete(
                                        datum.id ?? '',
                                        ref.watch(newVal),
                                        provider,
                                        context: context,
                                        ref: ref,
                                      );
                                      print(datum.id);
                                      print(res);
                                      print(ref.watch(newVal));
                                    }
                                  },
                                  padSize: 0,
                                  textSize: 14,
                                  bgColor: Colors.transparent,
                                ),
                              ),

                              IconButton(
                                onPressed: () => showActionSheet(context, [
                                  if((datum.actions ?? []).contains('edit')) MoreTypeInfo('edit', 'Edit', CupertinoIcons.pencil_circle, null, () { handleEdit(context, ref, datum); }),
                                  if((datum.actions ?? []).contains('insights')) MoreTypeInfo('insights', 'View Insights', CupertinoIcons.globe, null, () { print('object'); }),
                                  if((datum.actions ?? []).contains('auto_renew')) MoreTypeInfo('auto_renew', 'Auto Renew', CupertinoIcons.arrow_counterclockwise, null, () { }),
                                  if((datum.actions ?? []).contains('share')) MoreTypeInfo('share', 'Share', CupertinoIcons.arrowshape_turn_up_right, null, () {
                                    sharedLinks(context, datum.short_link);
                                  }),
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

  void updateKey(WidgetRef ref, String key, String? val) {
    ref.read(newMap.notifier).update((state) {
      return { ...state, ...{ key: val }, };
    });
  }
}


Widget images(String src) {
  return CircleAvatar(
    backgroundColor: Colors.black12,
    child: FadeInImage.assetNetwork(placeholder: placeholder, image: src, fit: BoxFit.cover,),
  );
}

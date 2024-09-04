

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/functions.dart';
import 'package:k24/pages/accounts/profile_public/profile_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/chats/chat_serial.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/helper.dart';
import '../../../serialization/accounts/profiles_public/profile_serial.dart';
import '../../../serialization/grid_card/grid_card.dart';
import '../../chats/conversations/chat_conversation.dart';
import '../../follows/follows_page.dart';

final Labels labels = Labels();
final Buttons buttons = Buttons();
final MyWidgets myWidgets = MyWidgets();
final MyCards myCards = MyCards();
final Config config = Config();

class AnotherProfilePage extends ConsumerStatefulWidget {
  const AnotherProfilePage({super.key, required this.userData});

  final User_? userData;

  @override
  ConsumerState<AnotherProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<AnotherProfilePage> {
  final ScrollController scrollController = ScrollController();
  final StateProvider<bool> showBar = StateProvider((ref) => false);
  final StateProvider<int> changePage = StateProvider((ref) => 0);
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final scrollPosition = scrollController.position.pixels;
      final currentShowBarState = ref.watch(showBar);
      updateShowBarState(scrollPosition, currentShowBarState);
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if (scrollPosition > maxScrollExtent - 50 && scrollPosition <= maxScrollExtent) {
        _fetchMoreData();
      }
    });
    setupPage();
  }

  void updateShowBarState(double scrollPosition, bool currentShowBarState) {
    if (scrollPosition >= 500.0 && !currentShowBarState) {
      ref.read(showBar.notifier).update((state) => true);
    } else if (scrollPosition < 500.0 && currentShowBarState) {
      ref.read(showBar.notifier).update((state) => false);
    }
  }

  Future<void> _fetchMoreData() async {
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final userDatum = widget.userData;
    final username = '${userDatum?.username}';
    final profileListPub = profileListProvider(ref, username);
    final fetchMore = ref.read(profileListPub.notifier);
    fetchMore.fetchHome();

    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDatum = widget.userData;
    final username = '${userDatum?.username}';
    final profileListPub = profileListProvider(ref, username);

    final profilePro = profilePublicProvider(ref, username);
    final profileList = ref.watch(profileListPub);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: labels.label('${userDatum?.name}', fontSize: 20, fontWeight: FontWeight.w500, maxLines: 1, overflow: TextOverflow.ellipsis),
          titleSpacing: 6,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () { },
              icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: config.backgroundColor,
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(profileListPub.notifier).refresh(username);
            ref.read(isLoadingPro.notifier).state = false;
            ref.read(lengthPro.notifier).state = 1;
          },
          child: BodyProfile(
            ref,
            profilePro: profilePro,
            profileList: profileList,
            scrollController: scrollController,
            showBar: showBar,
            changePage: changePage,
            isLoadingPro: isLoadingPro,
            lengthPro: lengthPro,
            provider: profileListPub,
          ),
        ),
        bottomNavigationBar: myWidgets.bottomBarPage(
            context, ref, 0,
            null
        ),
      ),
    );
  }

  void setupPage() async {
    //
  }
}

class BodyProfile extends StatelessWidget {
  BodyProfile(this.ref, {super.key,
    required this.profilePro,
    required this.profileList,
    required this.scrollController,
    required this.showBar,
    required this.changePage,
    required this.isLoadingPro,
    required this.lengthPro,
    required this.provider,
  });

  final WidgetRef ref;
  final ProfilePublicProvider profilePro;
  final AsyncValue<List<GridCard>> profileList;
  final ScrollController scrollController;
  final StateProvider<bool> showBar;
  final StateProvider<int> changePage;
  final StateProvider<bool> isLoadingPro;
  final StateProvider<int> lengthPro;
  final dynamic provider;
  final sendApi = Provider((ref) => ProfileSendApiService());

  @override
  Widget build(BuildContext context) {
    TextStyle? style = TextStyle(color: Colors.black87, fontSize: 14, fontFamily: 'en', height: lineHeight);
    final profile = ref.watch(profilePro);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints cons) {
          double width = cons.maxWidth;
        return Stack(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              controller: scrollController,
              slivers: [
                /// body //
                SliverList(
                  delegate: SliverChildListDelegate([

                    profile.when(
                      error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                      loading: () => const SizedBox(
                        height: 350,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      data: (data) {
                        final datum = data?.data;
                        final meta = data?.meta;

                        return Flex(
                          direction: Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      ],
                                    ),
                                  ),
                                ),
                                // edit profile
                                if(!checkOwnUser(ref, datum?.id)) Positioned(
                                    bottom: 4,
                                    right: 10,
                                    child: Row(
                                      children: [
                                        buttons.textButtons(
                                          title: 'Follow${(datum?.is_follow == true) ? 'ing' : ''}',
                                          onPressed: () => submitDataPro({
                                            'id': '${datum?.id}',
                                            'type': 'user',
                                          }, datum?.is_follow == true, profilePro),
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                                          textColor: config.primaryAppColor.shade600,
                                          bgColor: Colors.transparent,
                                          borderColor: Colors.transparent,
                                          prefixIcon: (datum?.is_follow == true) ? Icons.check : Icons.add,
                                          prefColor: config.primaryAppColor.shade600,
                                          prefixSize: 16,
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
                              width: double.infinity,
                              child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labels.selectLabel('${datum?.name}', color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w500),
                                  labels.selectLabel('@${datum?.username}', color: Colors.black54, fontSize: 14),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        routeNoAnimation(context, pageBuilder: FollowsPages(
                                          profile: datum,
                                        ));
                                      },
                                      child: labels.label('${datum?.followers ?? '0'} followers • ${datum?.following ?? '0'} Following', color: Colors.black87, fontSize: 14),
                                    ),
                                  ),

                                  if(datum?.verified != null) labels.labelIcon(
                                    leftIcon: const Padding(
                                      padding: EdgeInsets.only(right: 6.0),
                                      child: Icon(Icons.check_circle_outline, size: 14),
                                    ),
                                    leftTitle: 'Verified',
                                    rightIcon: const Wrap(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                                          child: Icon(Icons.call, size: 14),
                                        ),
                                      ],
                                    ),
                                    style: style,
                                  ),

                                  labels.labelIcon(
                                    leftIcon: const Padding(
                                      padding: EdgeInsets.only(right: 6.0),
                                      child: Icon(Icons.calendar_today_outlined, size: 14),
                                    ),
                                    leftTitle: 'Joined ${stringToString(date: '${datum?.registered_date}', format: 'dd, MMM yyyy')}',
                                    style: style,
                                  ),

                                  if(datum?.contact?.address != null) labels.labelIcon(
                                    leftIcon: const Padding(
                                      padding: EdgeInsets.only(right: 6.0),
                                      child: Icon(Icons.location_on_outlined, size: 14),
                                    ),
                                    leftTitle: '${datum?.contact?.address}',
                                    style: style,
                                    maxLines: 2,
                                  ),

                                  const SizedBox(height: 10),

                                  SizedBox(
                                    width: width - 20,
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                          child: buttons.textButtons(
                                            title: 'Call',
                                            onPressed: () => callFun(context, datum),
                                            prefixIcon: Icons.call,
                                            prefColor: Colors.white,
                                            prefixSize: 20,
                                            bgColor: config.primaryAppColor.shade600,
                                            radius: 50,
                                            textColor: Colors.white,
                                            textSize: 15,
                                            borderColor: Colors.transparent,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        ButtonUIS(icon: Icons.sms, onPressed: () => smsFun(context, datum)),
                                        const SizedBox(width: 10),
                                        ButtonUIS(icon: CupertinoIcons.qrcode, onPressed: () {}),
                                        const SizedBox(width: 10),
                                        ButtonUIS(icon: Icons.more_horiz, onPressed: () {
                                          showActionSheet2(context, [
                                            MoreTypeInfo('Follow${(datum?.is_follow == true) ? 'ing' : ''}', '', (datum?.is_follow == true) ? Icons.check : Icons.add, null, () => submitDataPro({
                                              'id': '${datum?.id}',
                                              'type': 'user',
                                            }, datum?.is_follow == true, profilePro)),
                                            MoreTypeInfo('${(datum?.is_saved == true) ? 'Uns' : 'S'}ave', '', (datum?.is_saved == true) ? Icons.bookmark : Icons.bookmark_border, null, () {
                                              savedFunctions(ref, datum?.id, profilePro, isSaved: datum?.is_saved, type: 'user', typeRemove: 'post');
                                            }),
                                            MoreTypeInfo('Copy link', meta?.url ?? '', Icons.link, null, () {
                                              copyFunction(context, meta?.url);
                                            }),
                                            MoreTypeInfo('Direction', '', Icons.u_turn_right_outlined, null, () { }),
                                            MoreTypeInfo('QR Code', '', CupertinoIcons.qrcode, null, () { }),
                                            MoreTypeInfo('Report', '', Icons.report_gmailerrorred_sharp, null, () { }),
                                          ]);
                                        }),
                                      ],
                                    ),
                                  ),

                                  TapUI(ref: ref, width: width, scrollController: scrollController, changePage: changePage),
                                ],
                              ),
                            ),
                            // home page
                            if(ref.watch(changePage) == 0) Column(
                              children: [
                                /// last title ///
                                myWidgets.titleAds(ref, title: 'Recent Ads'),

                                /// listing page ///
                                profileList.when(
                                  error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                                  loading: () => myCards.shimmerHome(ref, viewPage: ref.watch(viewPageProvider)),
                                  data: (data) => myCards.cardHome(
                                    context, ref,
                                    data,
                                    fetching: false,
                                    viewPage: ref.watch(viewPageProvider),
                                    notRelates: false,
                                    provider: provider,
                                  ),
                                ),

                                /// loading data ///
                                if(ref.watch(isLoadingPro) && ref.watch(lengthPro) > 0) Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(20),
                                  child: const CircularProgressIndicator(),
                                ) else if(ref.watch(lengthPro) <= 0) const NoMoreResult(),
                              ],
                            ),
                            // about page
                            if(ref.watch(changePage) == 1) Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              margin: const EdgeInsets.only(top: 8),
                              child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labels.label('Overview', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),

                                  const AboutUI(
                                    title: 'Verified',
                                    icon: Icons.check_circle_outline_outlined,
                                  ),

                                  if(datum?.contact?.phone != null) AboutUI(
                                    title: '${datum?.contact?.phone}',
                                    icon: CupertinoIcons.phone,
                                    isThreeLine: true,
                                    color: config.primaryAppColor.shade600,
                                    buttonTitle: 'Click To Call',
                                  ),

                                  AboutUI(
                                    title: '${meta?.url}',
                                    icon: CupertinoIcons.globe,
                                    color: config.primaryAppColor.shade600,

                                    onTap: () async {
                                      // Replace "https://" and split by "/"
                                      String? modifiedUrl = meta?.url.toString().replaceFirst('https://', '');
                                      final List<String>? urlParts = modifiedUrl?.split('/');

                                      // You can reassemble or manipulate the parts if needed
                                      const String scheme = 'https';
                                      final String host = urlParts![0];
                                      final String path = urlParts.sublist(1).join('/');

                                      final Uri smsLaunchUri = Uri(
                                        scheme: scheme,
                                        host: host,
                                        path: path,
                                      );

                                      await launchUrl(smsLaunchUri);
                                    },
                                  ),

                                  if(datum?.contact?.address != null) AboutUI(
                                    title: '${datum?.contact?.address}',
                                    icon: Icons.location_on_outlined,
                                    isThreeLine: true,
                                    subTitle: '123',
                                    buttonTitle: 'Get Directions',
                                    colorButton: config.primaryAppColor.shade600,
                                  ),
                                ],
                              ),
                            ),

                          ],
                        );
                      },
                    ),

                  ]),
                ),

              ],
            ),

            if(ref.watch(showBar)) Positioned(
              top: 0,
              child: TapUI(ref: ref, width: width, scrollController: scrollController, changePage: changePage,),
            ),
          ],
        );
      }
    );
  }

  Future<void> callFun(BuildContext context, DataProfile? datum) async {
    if(checkLogs(ref)) {
      final phone = datum?.contact?.phone_white_operator ?? [];
      showActionSheet(context, [
        for(final v in phone)
          MoreTypeInfo(v?.slug ?? '', v?.phone ?? '', null, null, () async {
            final Uri smsLaunchUri = Uri(
              scheme: 'tel',
              path: v?.phone ?? '',
            );
            await launchUrl(smsLaunchUri);
          }),
      ]);
    }
  }

  Future<void> smsFun(BuildContext context, DataProfile? datum) async {
    if(checkLogs(ref) && !checkOwnUser(ref, datum?.id)) {
      routeAnimation(context, pageBuilder: ChatConversations(chatData: ChatData(
          id: null,
          to_id: datum?.id,
          user: ChatUser.fromJson(datum?.toJson() ?? {})
      )));
    }
  }

  Future<void> submitDataPro(Map<String, dynamic> data, bool is_follow, ProfilePublicProvider profilePro) async {
    final sendData = ref.watch(sendApi);
    // submit to clear follow //
    if(checkLogs(ref)) {
      if(is_follow) {
        showActionSheet(ref.context, [
          MoreTypeInfo('unfollow', 'Unfollow', null, null, () async {
            final result = await sendData.submitFollow('unfollow', data, ref: ref);
            if(result.message != null) {
              ref.read(profilePro.notifier).updateLikes('0', isFollow: false);
              alertSnack(ref.context, result.message ?? 'N/A');
            }
          }),
        ]);

        // submit to follow //
      } else {
        final result = await sendData.submitFollow('follow', data, ref: ref);
        if(result.message != null) {
          ref.read(profilePro.notifier).updateLikes('0', isFollow: true);
          alertSnack(ref.context, result.message ?? 'N/A');
        }
      }
    }
  }
}

class ButtonUIS extends StatelessWidget {
  const ButtonUIS({super.key, required this.onPressed, this.icon});

  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: config.primaryAppColor.shade600),
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(maxWidth: 38, maxHeight: 38),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 22,
        color: config.primaryAppColor.shade600,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}

class TapUI extends StatelessWidget {
  const TapUI({super.key, required this.width, required this.ref,
    required this.scrollController,
    required this.changePage,
  });

  final WidgetRef ref;
  final double width;
  final ScrollController scrollController;
  final StateProvider<int> changePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: width,
      child: TabBar(
        onTap: (val) {
          scrollController.position.animateTo(420,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          ref.read(changePage.notifier).update((state) => val);
        },
        indicatorColor: config.primaryAppColor.shade600,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2,
        tabs: <Widget>[
          Tab(icon: labels.label('Home', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
          Tab(icon: labels.label('About Me', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
        ],
      ),
    );
  }
}

class AboutUI extends StatelessWidget {
  const AboutUI({super.key,
    required this.title,
    required this.icon,
    this.subTitle,
    this.buttonTitle,
    this.onTap,
    this.isThreeLine,
    this.color,
    this.colorButton,
  });

  final String title;
  final IconData? icon;
  final String? subTitle;
  final String? buttonTitle;
  final void Function()? onTap;
  final bool? isThreeLine;
  final Color? color;
  final Color? colorButton;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: isThreeLine ?? false,
      dense: true,
      horizontalTitleGap: 8,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 26, color: config.secondaryColor.shade400,),
      title: InkWell(onTap: onTap,child: labels.label(title, fontSize: 15, color: color ?? Colors.black87)),
      subtitle: (isThreeLine == true) ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(subTitle != null) labels.label(subTitle!, fontSize: 13, color: Colors.black87),
          if(buttonTitle != null) InkWell(
            onTap: onTap,
            child: labels.label(buttonTitle!, fontSize: 13, color: colorButton ?? Colors.black87),
          ),
        ],
      ) : null,
      shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
    );
  }
}



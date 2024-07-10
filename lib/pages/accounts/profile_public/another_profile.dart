

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/pages/accounts/profile_public/profile_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../../serialization/grid_card/grid_card.dart';
import '../../../serialization/accounts/profiles_public/profile_serial.dart';

final Labels labels = Labels();
final Buttons buttons = Buttons();
final MyWidgets myWidgets = MyWidgets();
final MyCards myCards = MyCards();
final Config config = Config();

class AnotherProfilePage extends ConsumerStatefulWidget {
  AnotherProfilePage({super.key, required this.userData});

  final StateProvider<int> selectedIndex = StateProvider((ref) => 0);
  final User_? userData;

  @override
  ConsumerState<AnotherProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<AnotherProfilePage> {
  final ScrollController scrollController = ScrollController();
  final StateProvider<bool> showBar = StateProvider((ref) => false);
  final StateProvider<int> changePage = StateProvider((ref) => 0);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final scrollPosition = scrollController.position.pixels;
      final currentShowBarState = ref.watch(showBar);
      updateShowBarState(scrollPosition, currentShowBarState);
    });
    setupPage();
  }

  void updateShowBarState(double scrollPosition, bool currentShowBarState) {
    if (scrollPosition >= 450.0 && !currentShowBarState) {
      ref.read(showBar.notifier).update((state) => true);
    } else if (scrollPosition < 450.0 && currentShowBarState) {
      ref.read(showBar.notifier).update((state) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDatum = widget.userData;
    final profileListPub = profileListProvider('${userDatum?.username}', '${ref.watch(usersProvider).tokens?.access_token}');
    final profilePro = ref.watch(profilePublicProvider('${userDatum?.username}', '${ref.watch(usersProvider).tokens?.access_token}'));
    final profileList = ref.watch(profileListPub);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: labels.label('${userDatum?.name}', fontSize: 20, fontWeight: FontWeight.w500),
          titleSpacing: 6,
          actions: [
            IconButton(
              onPressed: () { },
              icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: config.backgroundColor,
        body: RefreshIndicator(
          onRefresh: () => ref.read(profileListPub.notifier).refresh(),
          child: BodyProfile(
            ref,
            profilePro: profilePro,
            profileList: profileList,
            scrollController: scrollController,
            showBar: showBar,
            changePage: changePage,
          ),
        ),
        bottomNavigationBar: myWidgets.bottomBarPage(
            context, ref, widget.selectedIndex,
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
  const BodyProfile(this.ref, {super.key,
    required this.profilePro,
    required this.profileList,
    required this.scrollController,
    required this.showBar,
    required this.changePage,
  });

  final WidgetRef ref;
  final AsyncValue<ProfileSerial?> profilePro;
  final AsyncValue<List<GridCard>> profileList;
  final ScrollController scrollController;
  final StateProvider<bool> showBar;
  final StateProvider<int> changePage;

  @override
  Widget build(BuildContext context) {
    TextStyle? style = const TextStyle(color: Colors.black87, fontSize: 14, fontFamily: 'en');

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

                    profilePro.when(
                      error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
                      loading: () => const Padding(
                        padding: EdgeInsets.all(14.0),
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
                                    Container(
                                      color: config.primaryAppColor.shade50,
                                      height: 200,
                                      width: double.infinity,
                                      child: (datum?.cover?.url != null) ? FadeInImage.assetNetwork(
                                        placeholder: 'assets/img/load.jpg',
                                        image: '${datum?.cover?.url}',
                                        fit: BoxFit.cover,
                                      ) : null,
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
                                    onTap: () { },
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: config.secondaryColor.shade100,
                                              borderRadius: BorderRadius.circular(100),
                                              border: Border.all(color: Colors.white, width: 4)
                                          ),
                                          alignment: Alignment.center,
                                          width: 110,
                                          height: 110,
                                          child: (datum?.photo?.url != null) ? ClipOval(
                                            child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/img/load.jpg',
                                              image: '${datum?.photo?.url}',
                                              width: 110,
                                              height: 110,
                                              fit: BoxFit.cover,
                                            ),
                                          ) : const Icon(Icons.person, size: 64, color: Colors.white),
                                        ),
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
                                        buttons.textButtons(
                                          title: 'Follow',
                                          onPressed: () { },
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                                          textColor: config.primaryAppColor.shade600,
                                          bgColor: Colors.transparent,
                                          borderColor: Colors.transparent,
                                          prefixIcon: Icons.add,
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
                              child: Wrap(
                                spacing: 2,
                                runSpacing: 4,
                                direction: Axis.vertical,
                                children: [
                                  labels.label('${datum?.name}', color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w500),
                                  labels.label('@${datum?.username}', color: Colors.black54, fontSize: 14),
                                  labels.label('${datum?.followers ?? '0'} followers • ${datum?.following ?? '0'} Following', color: Colors.black87, fontSize: 14),

                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      if(datum?.is_verify == true) labels.labelIcon(
                                        leftIcon: const Padding(
                                          padding: EdgeInsets.only(right: 6.0),
                                          child: Icon(Icons.check_circle_outline, size: 14),
                                        ),
                                        leftTitle: 'Verified',
                                        style: style,
                                      ),
                                    ],
                                  ),

                                  Wrap(
                                    spacing: 20,
                                    runSpacing: 8,
                                    direction: Axis.horizontal,
                                    children: [
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
                                      ),
                                    ],
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
                                            onPressed: () {  },
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
                                        ButtonUIS(icon: Icons.sms, onPressed: () {}),
                                        const SizedBox(width: 10),
                                        ButtonUIS(icon: CupertinoIcons.qrcode, onPressed: () {}),
                                        const SizedBox(width: 10),
                                        ButtonUIS(icon: Icons.more_horiz, onPressed: () {}),
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
                                  loading: () => myCards.shimmerHome(viewPage: ref.watch(viewPageProvider)),
                                  data: (data) => myCards.cardHome(
                                    data,
                                    fetching: false,
                                    viewPage: ref.watch(viewPageProvider),
                                    notRelates: false,
                                  ),
                                ),
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
                                    icon: Icons.verified_user_outlined,
                                  ),

                                  if(datum?.contact?.phone != null) AboutUI(
                                    title: '${datum?.contact?.phone}',
                                    icon: CupertinoIcons.phone,
                                    isThreeLine: true,
                                    color: config.primaryAppColor.shade600,
                                    buttonTitle: 'Click To Show Phone Number',
                                  ),

                                  AboutUI(
                                    title: '${meta?.url}',
                                    icon: CupertinoIcons.globe,
                                    color: config.primaryAppColor.shade600,
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
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 26, color: config.secondaryColor.shade400,),
      title: labels.label(title, fontSize: 15, color: color ?? Colors.black87),
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




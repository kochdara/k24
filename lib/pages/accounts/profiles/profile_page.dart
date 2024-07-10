

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/profiles/profile_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/settings/settings_page.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../../serialization/accounts/profiles/profiles_own.dart';
import '../../../serialization/accounts/profiles_public/profile_serial.dart';
import '../profile_public/profile_provider.dart';

final Labels labels = Labels();
final Buttons buttons = Buttons();
final MyWidgets myWidgets = MyWidgets();
final MyCards myCards = MyCards();
final Config config = Config();

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, required this.selectedIndex});

  final StateProvider<int> selectedIndex;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  @override
  Widget build(BuildContext context) {
    final userPro = ref.watch(usersProvider);
    final profilePro = ref.watch(profilePublicProvider('${userPro.user?.username}', '${ref.watch(usersProvider).tokens?.access_token}'));

    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.person_circle_fill, color: config.secondaryColor.shade50, size: 42),
        title: labels.label('${userPro.user?.name}', fontSize: 20, fontWeight: FontWeight.w500),
        titleSpacing: 6,
        actions: [
          IconButton(
            onPressed: () { },
            icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill, color: Colors.white),
          ),

          IconButton(
            onPressed: () {
              routeAnimation(context, pageBuilder: const SettingPage());
            },
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: config.backgroundColor,
      body: BodyProfile(
        ref,
        profilePro: profilePro,
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
  });

  final WidgetRef ref;
  final AsyncValue<ProfileSerial?> profilePro;

  @override
  Widget build(BuildContext context) {
    final userKey = ref.watch(usersProvider);

    return RefreshIndicator(
      onRefresh: () {
        return ref.read(ownProfileListProvider(ref, '${ref.watch(usersProvider).tokens?.access_token}').notifier).refresh();
      },
      child: CustomScrollView(
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

                  return Flex(
                    direction: Axis.vertical,
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
                                    placeholder: placeholder,
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
                                        placeholder: placeholder,
                                        image: '${datum?.photo?.url}',
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover,
                                      ),
                                    ) : const Icon(Icons.person, size: 64, color: Colors.white),
                                  ),

                                  Positioned(
                                    bottom: 6,
                                    right: 6,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: config.secondaryColor.shade50,
                                      ),
                                      child: Icon(Icons.camera_alt, size: 18, color: config.secondaryColor.shade400),
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
                                    icon: const Icon(CupertinoIcons.qrcode, size: 35, color: Colors.black87),
                                  ),
                                  buttons.textButtons(
                                    title: 'Edit Profile',
                                    onPressed: () { },
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
                                    textColor: Colors.black87,
                                    bgColor: Colors.transparent,
                                    borderColor: Colors.black54,
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
                                      ButtonsUI(prefixIcon: Icons.favorite, title: 'Likes', width: width, onPressed: () => {}),
                                      ButtonsUI(prefixIcon: Icons.bookmark, title: 'Saves', width: width, onPressed: () => {}),
                                      ButtonsUI(prefixIcon: Icons.work, title: 'Applied jobs', width: width, onPressed: () => {}),
                                      ButtonsUI(prefixIcon: Icons.assignment, title: 'Job Applications', width: width, onPressed: () => {}),
                                      ButtonsUI(prefixIcon: Icons.description, title: 'Resume (CV)', width: width, onPressed: () => {}),
                                      ButtonsUI(prefixIcon: Icons.subscriptions, title: 'Subscription', width: width, onPressed: () => {}),
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
                      SegmentedControlExample(ref),

                    ],
                  );
                },
              ),

            ]),
          ),

        ],
      ),
    );
  }
}

enum TypeSelect { active, premiere, expired }
final StateProvider<TypeSelect> selectedSegment = StateProvider((ref) => TypeSelect.active);

class SegmentedControlExample extends StatelessWidget {
  SegmentedControlExample(this.ref, {super.key});

  final WidgetRef ref;

  final Map<TypeSelect, int> skyColors = <TypeSelect, int>{
    TypeSelect.active: 0,
    TypeSelect.premiere: 1,
    TypeSelect.expired: 2,
  };

  @override
  Widget build(BuildContext context) {
    final ownProfilePro = ref.watch(ownProfileListProvider(ref, '${ref.watch(usersProvider).tokens?.access_token}'));

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
                          child: labels.label('Active (0)', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
                        ),
                        TypeSelect.premiere: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: labels.label('Premiere (0)', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
                        ),
                        TypeSelect.expired: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: labels.label('Expired (0)', fontSize: 13, color: Colors.black87, textAlign: TextAlign.center),
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
                          Padding(
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
                                      labels.selectLabel('${datum.title}', fontSize: 14, color: Colors.black87),
                                      labels.selectLabel('\$${datum.price}', fontSize: 15, color: Colors.red, fontWeight: FontWeight.w500, lineHeight: 1.65),
                                      Flex(
                                        direction: Axis.horizontal,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: labels.selectLabel('ID: ${datum.id}', color: Colors.black54, fontSize: 12),
                                          ),
                                          Expanded(
                                            child: labels.selectLabel('View: ${datum.views}', color: Colors.black54, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      labels.selectLabel('Post Date: ${stringToString(date: '${datum.posted_date}', format: 'dd, MMM yyyy')}', color: Colors.black54, fontSize: 12),
                                      labels.selectLabel('Renew Date: ${stringWithNow(date: '${datum.renew_date}', format: 'dd, MMM yyyy')}', color: Colors.black54, fontSize: 12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.black12, height: 0),

                          Row(
                            children: [
                              Expanded(
                                child: buttons.textButtons(
                                  title: 'Renew',
                                  onPressed: () { },
                                  padSize: 8,
                                  textSize: 14,
                                  bgColor: Colors.transparent,
                                ),
                              ),

                              Expanded(
                                child: buttons.textButtons(
                                  title: 'Edit',
                                  onPressed: () { },
                                  padSize: 8,
                                  textSize: 14,
                                  bgColor: Colors.transparent,
                                ),
                              ),

                              Expanded(
                                child: buttons.textButtons(
                                  title: 'Delete',
                                  onPressed: () { },
                                  padSize: 8,
                                  textSize: 14,
                                  bgColor: Colors.transparent,
                                ),
                              ),

                              PopupMenuButton(
                                padding: EdgeInsets.zero,
                                surfaceTintColor: Colors.white,
                                initialValue: 0,
                                onSelected: (item) {},
                                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Text('Item 1'),
                                  ),
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text('Item 2'),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text('Item 3'),
                                  ),
                                ],
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

          ],
        );
      },
    );
  }
}

class ButtonsUI extends StatelessWidget {
  const ButtonsUI({super.key, required this.title, required this.onPressed,
  required this.prefixIcon, required this.width});

  final String title;
  final IconData? prefixIcon;
  final VoidCallback? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width / 2,
      child: buttons.textButtons(
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
    );
  }
}



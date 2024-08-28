
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/pages/settings/settings_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../serialization/notify/nortify_serial.dart';
import '../accounts/edit_profile/edit_page.dart';
import '../accounts/profile_public/another_profile.dart';

final Labels labels = Labels();
final Buttons buttons = Buttons();
final config = Config();
final myWidgets = MyWidgets();
StateProvider<String> versionPro = StateProvider<String>((ref) => 'Unknown');
StateProvider<String> modelPro = StateProvider<String>((ref) => 'Unknown');
StateProvider<String> modelVPro = StateProvider<String>((ref) => 'Unknown');

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: labels.label('Settings', fontSize: 20, fontWeight: FontWeight.w500),
        titleSpacing: 6,
      ),
      backgroundColor: config.backgroundColor,
      body: BodyProfile(
        ref,
      ),
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 4,
        null
      ),
    );
  }

  void setupPage() async {
    futureAwait(duration: 1, () async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      ref.read(versionPro.notifier).update((state) => packageInfo.version);
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        ref.read(modelPro.notifier).update((state) => androidInfo.model);
        ref.read(modelVPro.notifier).update((state) => androidInfo.version.release);
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        ref.read(modelPro.notifier).update((state) => iosInfo.utsname.machine);
        ref.read(modelVPro.notifier).update((state) => iosInfo.systemVersion);
      }
    });
  }
}

class BodyProfile extends ConsumerWidget {
  const BodyProfile(this.ref, {super.key});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPro = ref.watch(usersProvider);

    final List accountSetting = [
      { 'title': 'Edit Profile', 'value': 'edit_profile', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { routeAnimation(context, pageBuilder: const EditProfilePage()); } },
      { 'title': 'Change Password', 'value': 'change_password', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Username', 'value': 'username', 'subtitle': 'username', 'trailing': true, 'child': null, 'onTap': () { } },
      { 'title': 'Activate Phone', 'value': 'activate_phone', 'subtitle': '00000', 'trailing': true, 'child': null, 'onTap': () { } },
      { 'title': 'Facebook', 'value': 'facebook', 'subtitle': 'Add', 'trailing': true, 'child': null, 'onTap': () { } },
      { 'title': 'Google', 'value': 'google', 'subtitle': 'Add', 'trailing': true, 'child': null, 'onTap': () { } },
      { 'title': 'Auto Update Profile Picture', 'value': 'auto_update_profile_picture', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Privacy', 'value': 'privacy', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Delete account', 'value': 'delete_account', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Membership Information', 'value': 'membership_information', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Billing Address', 'value': 'billing_address', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
    ];

    final List appSetting = [
      { 'title': 'Language', 'value': 'language', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Theme', 'value': 'theme', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Information', 'value': 'information', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
    ];

    final List support = [
      { 'title': 'Our Website', 'value': 'our_website', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Posting Rules', 'value': 'posting_rules', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Privacy Policy', 'value': 'privacy_policy', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Contact Us', 'value': 'contact_us', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Rate Us', 'value': 'rate_us', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Safety Tips', 'value': 'safety_tips', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
      { 'title': 'Feedback', 'value': 'feedback', 'subtitle': '', 'trailing': false, 'child': null, 'onTap': () { } },
    ];

    final phones = userPro.user?.contact?.phone ?? [];
    // Update the subtitle where value is 'username'
    for (var setting in accountSetting) {
      if (setting['value'] == 'username') {
        setting['subtitle'] = userPro.user?.username ?? 'Unknown';
      }
      if (setting['value'] == 'activate_phone') {
        setting['subtitle'] = phones.join(', ');
      }
    }

    return CustomScrollView(
      slivers: [
        /// body //
        SliverList(
          delegate: SliverChildListDelegate([
            ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: config.secondaryColor.shade50,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: (userPro.user?.photo?.url != null) ? CircleAvatar(
                  backgroundColor: Colors.black12,
                  backgroundImage: NetworkImage(userPro.user?.photo?.url ?? ''),
                ) : const Icon(Icons.person, size: 30, color: Colors.grey),
              ),
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              horizontalTitleGap: 12,
              title: labels.label(userPro.user?.name ?? 'Unknown', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
              subtitle: labels.label('@${userPro.user?.username ?? 'Unknown'}', fontSize: 14, color: Colors.black54),
              tileColor: Colors.white,
              shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
              trailing: const Icon(Icons.chevron_right, size: 28),
              onTap: () => routeAnimation(context, pageBuilder: AnotherProfilePage(userData: User_.fromJson((userPro.user?.toJson() ?? {}) as Map<String, dynamic>))),
            ),

            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              horizontalTitleGap: 12,
              title: labels.label('ACCOUNT SETTING', fontSize: 14, color: Colors.black54),
            ),

            for(final val in accountSetting)
              ListTileUI(
                title: val['title'].toString(),
                subTitle: val['subtitle'].toString(),
                trailing: val['trailing'],
                onTap: val['onTap'],
                child: val['child'],
              ),

            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              horizontalTitleGap: 12,
              title: labels.label('APP SETTING', fontSize: 14, color: Colors.black54),
            ),

            for(final val in appSetting)
              ListTileUI(
                title: val['title'].toString(),
                subTitle: val['subtitle'].toString(),
                trailing: val['trailing'],
                onTap: val['onTap'],
                child: val['child'],
              ),

            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              horizontalTitleGap: 12,
              title: labels.label('SUPPORT', fontSize: 14, color: Colors.black54),
            ),

            for(final val in support)
              ListTileUI(
                title: val['title'].toString(),
                subTitle: val['subtitle'].toString(),
                trailing: val['trailing'],
                onTap: val['onTap'],
                child: val['child'],
              ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: buttons.textButtons(
                title: 'Logout',
                onPressed: () async {
                  final send = SettingsApiService();

                  final result = await send.logoutAccount(context, ref, {
                    'device_id': '0',
                  });
                  if(result?.status == 'success') {
                    ref.read(usersProvider.notifier).update((state) => DataUser());
                    ref.read(dataBadgeProvider.notifier).update((state) => NotifyBadges());
                    deleteSecure('user');
                    futureAwait(duration: 250, () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      alertSnack(context, result?.message ?? 'User logout successfully!');
                    });
                  }
                },
                textColor: Colors.red,
                textWeight: FontWeight.w500,
                textSize: 15,
                bgColor: Colors.white,
                radius: 25,
                padSize: 12,
              ),
            ),

            Center(
              child: Column(
                children: [
                  labels.label('@${userPro.user?.username ?? 'Unknown'}', fontSize: 14, color: Colors.black54),
                  labels.label('Version: ${ref.watch(versionPro)}', fontSize: 14, color: Colors.black54),
                  labels.label('${ref.watch(modelPro)}: ${ref.watch(modelVPro)}', fontSize: 14, color: Colors.black54),
                  labels.label(InternetAddress.anyIPv4.address, fontSize: 14, color: Colors.black54),
                ],
              ),
            ),

            const SizedBox(height: 18),

          ]),
        )

      ],
    );
  }
}

class ListTileUI extends StatelessWidget {
  const ListTileUI({super.key,
    required this.title,
    this.subTitle,
    required this.trailing,
    this.child,
    this.onTap,
  });

  final String title;
  final String? subTitle;
  final bool trailing;
  final Widget? child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      horizontalTitleGap: 12,
      title: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 0,
            child: labels.label(title, fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(width: 12,),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(subTitle != null && subTitle != '') Expanded(child: labels.label(subTitle!, fontSize: 14, color: Colors.black87, textAlign: TextAlign.end, maxLines: 1, overflow: TextOverflow.ellipsis,),)
                else if(child != null) child!,
              ],
            ),
          )
        ],
      ),
      shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
      tileColor: Colors.white,
      trailing: trailing ? const Icon(Icons.chevron_right, size: 26, color: Colors.grey) : null,
      onTap: onTap,
    );
  }
}



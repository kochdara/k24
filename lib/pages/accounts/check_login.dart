
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/accounts/login/login.dart';
import 'package:k24/pages/accounts/register/register_page.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../helpers/functions.dart';
import '../../widgets/my_widgets.dart';
import '../settings/settings_page.dart';
import 'login/login_provider.dart';

final Labels labels = Labels();
final Config config = Config();
final Buttons buttons = Buttons();
final myWidgets = MyWidgets();

class CheckLoginPage extends ConsumerStatefulWidget {
  const CheckLoginPage({super.key});

  @override
  ConsumerState<CheckLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<CheckLoginPage> {
  late StateProvider<List<UserSerial>> userList;

  @override
  void initState() {
    super.initState();
    userList = StateProvider((ref) => []);
    setupPage();
    setupPageDevice();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: BodyLogin(
        userList: userList,
      ),
    );
  }

  Future<void> setupPage() async {
    final userData = await getSecure('list_user', type: List) ?? [];
    futureAwait(duration: 10, () {
      for(final val in userData) {
        final use = UserSerial.fromJson(val ?? {});
        ref.read(userList.notifier).update((state) {
          return [ ...state, ...[use] ];
        });
      }
    });
  }

  void setupPageDevice() async {
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

class BodyLogin extends ConsumerStatefulWidget {
  const BodyLogin({super.key,
    required this.userList,
  });

  final StateProvider<List<UserSerial>> userList;

  @override
  ConsumerState<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends ConsumerState<BodyLogin> {
  final apiServiceProvider = Provider((ref) => MyApiService());
  String? ipAddress = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupPage();
  }

  void setupPage() async {
    ipAddress = await getIpAddress();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(widget.userList);

    return CustomScrollView(
      slivers: <Widget>[
        /// aap bar ///
        SliverAppBar(
          pinned: true,
          actions: [
            IconButton(
              padding: const EdgeInsets.all(12),
              onPressed: () {
                routeAnimation(context, pageBuilder: const SettingPage());
              },
              icon: const Icon(Icons.settings, color: Colors.white, size: 28),
            ),
          ],
        ),

        /// body ///
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1, (BuildContext context, int index) {
            return Column(
              children: [
                /// title ///
                Container(
                  height: 170,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: config.primaryAppColor.shade600
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      labels.label('Khmer24', fontSize: 38, fontWeight: FontWeight.bold),
                      labels.label('Buy faster, Sell faster', fontSize: 16, fontWeight: FontWeight.w500),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      /// user card ///
                      for(final v in user) ...[
                        ListTile(
                          onTap: () => loginPage(ref, v,),
                          leading: (v.data?.user?.photo?.url != null) ? CircleAvatar(
                            backgroundColor: Colors.black12,
                            backgroundImage: NetworkImage(v.data?.user?.photo?.url ?? ''),
                          ) : Icon(CupertinoIcons.person_crop_circle_fill, size: 50, color: config.secondaryColor.shade100),
                          title: labels.label(v.data?.user?.name ?? 'N/A', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                          subtitle: labels.label('@${v.data?.user?.username ?? 'N/A'}', fontSize: 12, color: Colors.black54),
                          dense: true,
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          horizontalTitleGap: 8,
                          trailing: IconButton(
                            onPressed: () => showActionSheet(context, [
                              MoreTypeInfo('edit', 'Edit', CupertinoIcons.pencil_circle, null, () {
                                routeAnimation(context, pageBuilder: LoginPage(
                                  log: v.login ?? v.data?.user?.username,
                                  pass: v.password,
                                ));
                              }),
                              MoreTypeInfo('remove', 'Remove', CupertinoIcons.trash_fill, null, () => removeUser(ref, v)),
                            ]),
                            padding: const EdgeInsets.all(12),
                            icon: Icon(Icons.more_vert_rounded, color: config.secondaryColor.shade400),
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],

                      const SizedBox(height: 30),

                      labels.label('Login Or Register With Your Phone Number', fontSize: 14, color: Colors.black87),

                      const SizedBox(height: 20),

                      /// button //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: buttons.textButtons(
                              title: 'Login',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                              },
                              padSize: 10,
                              textSize: 16,
                              textWeight: FontWeight.w500,
                              textColor: Colors.white,
                              bgColor: config.warningColor.shade400,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: buttons.textButtons(
                              title: 'Register',
                              onPressed: () {
                                routeAnimation(context, pageBuilder: const RegisterPage());
                              },
                              padSize: 10,
                              textSize: 16,
                              textWeight: FontWeight.w500,
                              textColor: Colors.white,
                              bgColor: config.warningColor.shade400,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      labels.label('Quickly Connect', fontSize: 14, color: Colors.black87 ),
                      const SizedBox(height: 10),

                      /// more login //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () { },
                            iconSize: 45,
                            icon: Icon(Icons.facebook, color: Colors.blue.shade800),
                          ),

                          IconButton(
                            onPressed: () { },
                            iconSize: 45,
                            icon: const FaIcon(FontAwesomeIcons.googlePlusG, color: Colors.red,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      labels.label('By continuing, you agree to our Posting Rule and Private Policy.', fontSize: 14, color: Colors.black87, textAlign: TextAlign.center),
                      const SizedBox(height: 20),

                      labels.label('Version: ${ref.watch(versionPro)}', fontSize: 14, color: Colors.black54),
                      labels.label('${ref.watch(modelPro)}: ${ref.watch(modelVPro)}', fontSize: 14, color: Colors.black54),
                      labels.label(ipAddress ?? 'Unknown', fontSize: 14, color: Colors.black54),

                    ],
                  ),
                ),

              ],
            );
          },
          ),
        ),

      ],
    );
  }

  Future<void> removeUser(WidgetRef ref, UserSerial v) async {
    final userListNotifier = ref.read(widget.userList.notifier);
    final currentList = userListNotifier.state;

    int i = currentList.indexWhere((element) => element.data?.user?.id == v.data?.user?.id);
    if (i != -1) {
      final updatedList = List<UserSerial>.from(currentList)..removeAt(i);
      userListNotifier.state = updatedList;  // Update the state

      // Save the updated list
      await saveSecure('list_user', updatedList);

      alertSnack(ref.context, 'User removed successfully!');
    }
  }

  Future<void> loginPage(WidgetRef ref, UserSerial v) async {
    Map<String, dynamic> data = {
      'login': v.data?.user?.username ?? '',
      'password': v.password ?? '',
    };
    final result = await ref.read(apiServiceProvider).submitData(data, ref, context: ref.context);

    if (result is Map && result['data'] != null) {
      Map<String, dynamic> updateRes = { ...result, ...data };
      final res = UserSerial.fromJson(updateRes);
      final list = await getSecure('list_user', type: List);
      // Ensure list is not null and is a List
      List<dynamic> userList = list ?? [];
      bool updated = false;
      // Iterate over the list to find and update the existing entry
      for (int i = 0; i < userList.length; i++) {
        final val = userList[i];
        final resp = UserSerial.fromJson(val as Map<String, dynamic>);
        if (resp.data?.user?.id == res.data?.user?.id) {
          userList[i] = updateRes;
          updated = true;
          break;
        }
      }

      // If the entry was not found, add it to the list
      if (!updated) {
        userList.add(updateRes);
      }
      // Save the updated list
      await saveSecure('list_user', userList);
      // direct to home page
      Navigator.of(ref.context).popUntil((route) => route.isFirst);
      alertSnack(ref.context, 'User login successfully!');
    } else {
      // check error
      final keyLog = MessageLogin.fromJson(result ?? {});
      myWidgets.showAlert(ref.context, '${keyLog.message}', title: 'Alert');
    }
  }
}



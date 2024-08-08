
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/accounts/login/login.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';

import '../../widgets/my_widgets.dart';
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
  late List<UserSerial> userList;

  @override
  void initState() {
    super.initState();

    userList = [];
    setupPage();
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
        setState(() {
          userList.add(use);
        });
      }
    });
  }
}

class BodyLogin extends ConsumerWidget {
  BodyLogin({super.key,
    required this.userList,
  });

  final List<UserSerial> userList;
  final apiServiceProvider = Provider((ref) => MyApiService());

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CustomScrollView(
      slivers: <Widget>[
        /// aap bar ///
        SliverAppBar(
          pinned: true,
          actions: [
            IconButton(
              padding: const EdgeInsets.all(12),
              onPressed: () { },
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
                        for(final v in userList) ...[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 1), // changes position of shadow
                                  blurStyle:  BlurStyle.solid,
                                ),
                              ],
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    onTap: () => loginPage(ref, v,),
                                    leading: (v.data?.user?.photo?.url != null) ? CircleAvatar(
                                      backgroundColor: Colors.black12,
                                      backgroundImage: NetworkImage(v.data?.user?.photo?.url ?? ''),
                                    ) : Icon(CupertinoIcons.person_crop_circle_fill, size: 50, color: config.secondaryColor.shade100),
                                    title: labels.label(v.data?.user?.name ?? 'N/A', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                                    subtitle: labels.label('@${v.data?.user?.username ?? 'N/A'}', fontSize: 12, color: Colors.black54),
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                                    horizontalTitleGap: 8,
                                    trailing: IconButton(
                                      onPressed: () {},
                                      padding: const EdgeInsets.all(12),
                                      icon: Icon(Icons.more_vert_rounded, color: config.secondaryColor.shade400),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
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

                        /// more login //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () { },
                              icon: Icon(Icons.facebook, size: 50, color: Colors.blue.shade800),
                            ),

                            IconButton(
                              onPressed: () { },
                              icon: const Icon(Icons.gpp_good_outlined, size: 50, color: Colors.blue),
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
        ),

      ],
    );
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


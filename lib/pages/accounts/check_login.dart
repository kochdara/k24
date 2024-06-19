
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/accounts/login/login.dart';
import 'package:k24/pages/accounts/profiles/profile_page.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';

final Labels labels = Labels();
final Config config = Config();
final Buttons buttons = Buttons();

class CheckLoginPage extends ConsumerStatefulWidget {
  const CheckLoginPage({super.key});

  @override
  ConsumerState<CheckLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<CheckLoginPage> {

  @override
  void initState() {
    super.initState();
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
      body: const BodyLogin(),
    );
  }

  void setupPage() { }
}

class BodyLogin extends ConsumerWidget {
  const BodyLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: <Widget>[
        /// aap bar ///
        SliverAppBar(
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
                                  onTap: () { },
                                  leading: Icon(CupertinoIcons.person_crop_circle_fill, size: 50, color: config.secondaryColor.shade200),
                                    title: labels.label('username', fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
                                  subtitle: labels.label('@username', fontSize: 12, color: Colors.black54),
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14),
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
}


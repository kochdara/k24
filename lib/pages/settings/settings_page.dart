


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';

final Labels labels = Labels();
final Buttons buttons = Buttons();

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
      body: BodyProfile(
        ref,
      ),
    );
  }

  void setupPage() async {
    //
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile(this.ref, {super.key});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        /// body //
        SliverList(
          delegate: SliverChildListDelegate([
            ListTile(
              title: const Text('Log Out', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
              onTap: () async {
                dialogBuilder(context);

                futureAwait(duration: 500, () {
                  ref.read(usersProvider.notifier).update((state) => DataUser());
                  deleteSecure('user');
                  Navigator.pop(context);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
              },
            ),

          ]),
        )

      ],
    );
  }
}


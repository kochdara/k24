
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:k24/widgets/dialog_builder.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyProfile(
        ref,
      ),
    );
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile(this.ref, {super.key});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        /// app bar ///
        const SliverAppBar(
          title: Text('Profile Page', style: TextStyle(color: Colors.white)),
        ),

        /// body //
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1, (context, index) {
              return ListTile(
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
              );
            },
          ),
        )

      ],
    );
  }
}


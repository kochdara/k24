
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyProfile(),
    );
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        /// app bar ///
        const SliverAppBar(),

        /// body //
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1, (context, index) {
              return ListTile(
                title: Text('Demo'),
              );
            },
          ),
        )

      ],
    );
  }
}


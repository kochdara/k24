
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';

final Forms forms = Forms();
final Labels labels = Labels();

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodySearch(title: widget.title),
    );
  }
}

class BodySearch extends StatelessWidget {
  const BodySearch({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        /// app bar ///
        SliverAppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          pinned: true,
          titleSpacing: 0,
          title: forms.formField(
            'Search',
            hintText: 'Search: $title',
            autofocus: true,
          ),
        ),

        /// body ///
        SliverList(
          delegate: SliverChildBuilde rDelegate(
            childCount: 1, (context, index) {
              return const ListTile(
                title: Text('demo'),
              );
            },
          ),
        )

      ],
    );
  }
}



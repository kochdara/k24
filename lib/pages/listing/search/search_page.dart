

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/main.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';

final Forms forms = Forms();
final Labels labels = Labels();
final Buttons buttons = Buttons();

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key, required this.title, required this.newData});

  final String title;
  final StateProvider<Map> newData;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  StateProvider<List> keyVal = StateProvider<List>((ref) => []);
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  setupPage() async {
    final keys = await getSecure('keyword', type: Map);
    ref.read(keyVal.notifier).update((state) {
      final newList = [...state, ...keys];
      return newList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: BodySearch(ref, title: widget.title, focusNode: focusNode, newData: widget.newData, keyVal: keyVal),
    );
  }
}

class BodySearch extends StatelessWidget {
  const BodySearch(this.ref, {super.key, required this.title, required this.focusNode, required this.newData, required this.keyVal});

  final WidgetRef ref;
  final String title;
  final FocusNode focusNode;
  final StateProvider<Map> newData;
  final StateProvider<List> keyVal;

  @override
  Widget build(BuildContext context) {
    final title = ref.watch(newData)['keyword'] ?? '';
    final watch = ref.watch(keyVal);

    futureAwait(duration: 500, () {
      focusNode.requestFocus();
    });

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
            hintText: 'Search...',
            controller: TextEditingController(text: '$title'),
            focusNode: focusNode,
            onFieldSubmitted: (val) async {
              ref.read(newData.notifier).update((state) {
                final newMap = {...state};
                newMap['keyword'] = val;
                return newMap;
              });

              saveSecure('keyword', [...watch, val]);
              Navigator.pop(context, 'success');

            },
          ),
          actions: [
            IconButton(
              onPressed: () { focusNode.requestFocus(); },
              padding: const EdgeInsets.all(14),
              icon: Icon(Icons.search, size: 28, color: config.secondaryColor.shade400),
            )
          ],
        ),

        /// body ///
        if(watch.isNotEmpty) SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1, (context, index) {
              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            labels.label('Recent Search', color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w500),
                            IconButton(
                              padding: const EdgeInsets.all(8),
                              onPressed: () {
                                deleteSecure('keyword');

                                ref.read(keyVal.notifier).update((state) {
                                  final newList = [];
                                  return newList;
                                });
                              },
                              icon: labels.label('Clear', color: config.primaryAppColor.shade600, fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),

                      for(final v in watch)
                        ListTile(
                          leading: Icon(CupertinoIcons.arrow_counterclockwise, color: config.secondaryColor.shade300),
                          title: Text('$v'),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                          tileColor: Colors.white,
                          shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit, size: 20, color: config.secondaryColor.shade300),
                            padding: const EdgeInsets.all(14),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        )

      ],
    );
  }
}



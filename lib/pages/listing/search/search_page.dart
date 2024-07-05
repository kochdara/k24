

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
import 'package:k24/widgets/my_widgets.dart';

final Forms forms = Forms();
final Labels labels = Labels();
final Buttons buttons = Buttons();
final MyWidgets myWidgets = MyWidgets();
final Config config = Config();

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key, required this.title, required this.newData, required this.selectedIndex});

  final String title;
  final StateProvider<Map> newData;
  final StateProvider<int> selectedIndex;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  StateProvider<List> keyVal = StateProvider<List>((ref) => []);
  final StateProvider<FocusNode> focusNode = StateProvider((ref) => FocusNode());
  StateProvider<String> title = StateProvider((ref) => '');

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  setupPage() async {
    final keys = await getSecure('keyword', type: Map) ?? [];
    ref.read(keyVal.notifier).update((state) {
      final newList = [...state, ...keys];
      return newList;
    });
    title = StateProvider((ref) => ref.watch(widget.newData)['keyword'] ?? '');

    futureAwait(duration: 300, () {
      ref.read(focusNode.notifier).state.requestFocus();
    });
  }

  void onFieldSubmitted(String val) {
    final newDa = widget.newData;
    final watch = ref.watch(keyVal);

    ref.read(newDa.notifier).update((state) {
      final newMap = {...state};
      newMap['keyword'] = val;
      return newMap;
    });

    saveSecure('keyword', [...watch, val]);
    Navigator.pop(context, 'success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: bodySearch(),
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, widget.selectedIndex,
          null
      ),
    );
  }

  Widget bodySearch() {
    final watch = ref.watch(keyVal);

    return CustomScrollView(
      slivers: [
        /// app bar ///
        SliverAppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          pinned: true,
          titleSpacing: 0,
          title: forms.labelFormFields(
            hintText: 'Search...',
            controller: TextEditingController(text: ref.watch(title)),
            focusNode: ref.watch(focusNode),
            onFieldSubmitted: onFieldSubmitted,
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none)
          ),
          actions: [
            IconButton(
              onPressed: () { ref.read(focusNode.notifier).state.requestFocus(); },
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

                              ref.read(title.notifier).update((state) => '');
                              ref.read(keyVal.notifier).update((state) {
                                final newList = [];
                                return newList;
                              });
                              ref.read(focusNode.notifier).state.unfocus();
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
                          onPressed: () {
                            ref.read(focusNode.notifier).state.unfocus();
                            ref.read(title.notifier).update((state) => '$v');
                          },
                          icon: Icon(Icons.edit, size: 20, color: config.secondaryColor.shade300),
                          padding: const EdgeInsets.all(14),
                        ),
                        onTap: () => onFieldSubmitted('$v'),
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



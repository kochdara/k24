
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/main/home_provider.dart';

import '../../helpers/config.dart';
import '../../widgets/buttons.dart';
import '../../widgets/forms.dart';
import '../../widgets/labels.dart';
import '../../widgets/my_cards.dart';
import '../../widgets/my_widgets.dart';

class SubCategory extends ConsumerStatefulWidget {
  const SubCategory({super.key, required this.title, required this.data, required this.condition, required this.setFilters});

  final String title;
  final Map data;
  final bool condition;
  final String setFilters;

  @override
  ConsumerState<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends ConsumerState<SubCategory> {
  final Buttons buttons = Buttons();
  final Labels labels = Labels();
  final Config config = Config();
  final MyCards myCards = MyCards();
  final MyWidgets myWidgets = MyWidgets();
  final Forms forms = Forms();

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(loadMore);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void loadMore() async {
    //
  }

  Future<void> handleRefresh() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    final dataCate = widget.data;
    final watchCate = ref.watch(getMainCategoryProvider(parent: '${dataCate['id']}'));

    return Scaffold(
      appBar: appBar(),
      backgroundColor: config.backgroundColor,
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Center(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double width = constraints.maxWidth;
                  Map res = config.responsiveSub(width);

                  return Container(
                    constraints: BoxConstraints(maxWidth: config.maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // top ads //
                        myCards.ads(url: 'https://www.khmer24.ws/www/delivery/ai.php?filename=08232023_bannercarsale_(640x290)-2.jpg%20(3)&contenttype=jpeg', loading: false),

                        // title & filters //
                        titleFilter(),

                        // main category //
                        watchCate.when(
                          error: (e, st) => Text('Error : $e'),
                          loading: () => myCards.shimmerCategory(),
                          data: (data) => myCards.cardCategory(data),
                        ),

                        // grid view //

                      ],
                    ),
                  );
                }
            ),
          ),
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      leading: IconButton(
        padding: const EdgeInsets.all(14),
        onPressed: () {
          if(Navigator.canPop(context)) Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      title: buttons.textButtons(
        title: '${widget.data['title']??'Title of Category'}',
        onPressed: () {},
        bgColor: config.infoColor.shade300,
        textColor: Colors.white,
        textSize: 15,
        textWeight: FontWeight.w500,
        prefixIcon: CupertinoIcons.search,
        prefixSize: 18,
        prefColor: Colors.white,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      titleSpacing: 0,
      actions: [
        IconButton(
          padding: const EdgeInsets.all(12),
          onPressed: () => { },
          icon: const Icon(Icons.tune, color: Colors.white, size: 28),
        ),
      ],
    );
  }

  titleFilter() {
    return Container(
      padding: const EdgeInsets.only(top: 14, bottom: 8, left: 8),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labels.label(widget.data['title']??'Title', fontSize: 18, color: Colors.black),

              InkWell(
                onTap: () {
                  if(ref.watch(viewPage) == ViewPage.grid) {ref.read(viewPage.notifier).state = ViewPage.list;}
                  else if(ref.watch(viewPage) == ViewPage.list) {ref.read(viewPage.notifier).state = ViewPage.view;}
                  else {ref.read(viewPage.notifier).state = ViewPage.grid;}

                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: (ref.watch(viewPage) == ViewPage.list) ? const Icon(CupertinoIcons.list_bullet) :
                  (ref.watch(viewPage) == ViewPage.view) ? const Icon(CupertinoIcons.list_bullet_below_rectangle) :
                  const Icon(CupertinoIcons.square_grid_2x2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 10,
              children: [
                //

                SizedBox(width: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


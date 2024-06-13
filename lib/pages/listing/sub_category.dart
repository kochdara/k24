
// ignore_for_file: unused_result

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/listing/sub_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/config.dart';
import '../../serialization/filters/min_max/min_max.dart';
import '../../serialization/filters/radio_select/radio.dart';
import '../../widgets/buttons.dart';
import '../../widgets/forms.dart';
import '../../widgets/labels.dart';
import '../../widgets/my_cards.dart';
import '../../widgets/my_widgets.dart';
import '../filters_pro/my_filters.dart';
import '../../widgets/modals.dart';

final Buttons buttons = Buttons();
final Labels labels = Labels();
final Config config = Config();
final MyCards myCards = MyCards();
final MyWidgets myWidgets = MyWidgets();
final Forms forms = Forms();

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
  final scrollController = ScrollController();
  StateProvider<bool> fetchingProvider = StateProvider<bool>((ref) => false);
  StateProvider<int> indX = StateProvider((ref) => 0);
  StateProvider<Map> newData = StateProvider((ref) => {});
  final displayTitle = StateProvider<String?>((ref) => null);

  @override
  void initState() {
    super.initState();
    scrollController.addListener(loadMore);
    setupPage();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void loadMore() async {
    final dataCate = widget.data;
    final cate = dataCate['slug'];
    final limit = ref.watch(subListsProvider('$cate').notifier).limit;
    final current = ref.watch(subListsProvider('$cate').notifier).current_result;
    var fet = ref.read(fetchingProvider.notifier);
    ScrollPosition scroll = scrollController.position;

    if (scroll.pixels > 1500 && scroll.pixels >= (scroll.maxScrollExtent - 750)
        && (current >= limit) && !fet.state) {
      fet.state = true;
      ref.read(subListsProvider('$cate', newFilter: ref.watch(newData) as Map?).notifier).subFetch();
      await futureAwait(() { fet.state = false; });
    }
  }

  Future<void> handleRefresh() async {
    final dataCate = widget.data;
    final cate = dataCate['slug'];
    final Map? filter = ref.watch(newData) as Map?;

    ref.refresh(getMainCategoryProvider('$cate').future);
    await ref.read(subListsProvider('$cate', newFilter: filter).notifier).refresh();

    // String subs = '';
    // newFilter.forEach((key, value) {
    //   if(value is Map) {
    //     if(value['fieldvalue'] != null) subs += '&$key=${value['fieldvalue']}';
    //     if(value['slug'] != null) subs += '&$key=${value['slug']}';
    //
    //   } else {subs += '&$key=${value ?? ''}';}
    // });
    // print(subs);
  }

  @override
  Widget build(BuildContext context) {
    final dataCate = widget.data;
    final watchCate = ref.watch(getMainCategoryProvider('${dataCate['id']}'));
    final watchLists = ref.watch(subListsProvider('${dataCate['slug']}', newFilter: ref.watch(newData) as Map?));

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

                  return Container(
                    constraints: const BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// top ads ///
                        myCards.ads(url: 'https://www.khmer24.ws/www/delivery/ai.php?filename=08232023_bannercarsale_(640x290)-2.jpg%20(3)&contenttype=jpeg', loading: false),

                        /// title & filters ///
                        titleFilter(),

                        /// main category ///
                        watchCate.when(
                          error: (e, st) => Text('Error : $e'),
                          loading: () => myCards.shimmerCategory(),
                          data: (data) => myCards.subCategory(data, setFilters: ref.watch(newData), condition: true),
                        ),

                        /// grid view ///
                        watchLists.when(
                          error: (e, st) => myCards.notFound(context, id: '${dataCate['id']}', message: '$e', onPressed: handleRefresh),
                          loading: () => myCards.shimmerHome(viewPage: ref.watch(viewPage)),
                          data: (data) => myCards.cardHome(
                            data,
                            fetching: ref.watch(fetchingProvider),
                            viewPage: ref.watch(viewPage),
                          ),
                        ),

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

  void setupPage() {
    newData = StateProvider((ref) => jsonDecode(widget.setFilters));
    indX = StateProvider((ref) => 0);
  }

  PreferredSizeWidget appBar() {
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
          onPressed: onClickMoreFilter,
          icon: const Icon(Icons.tune, color: Colors.white, size: 28),
        ),
      ],
    );
  }

  Widget titleFilter() {
    final watchFilter = ref.watch(getFiltersProvider('${widget.data['slug'] ?? ""}'));

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

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: watchFilter.when(
              error: (e, st) => Text('error : $e'),
              loading: () => shimmerFilter(),
              data: (data) {
                return Wrap(
                  spacing: 10,
                  children: [

                    for(var v in data) fieldGenerator(v),

                    const SizedBox(width: 2),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerFilter() {
    List length = [0,1,2,3];
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.white,
      child: Wrap(
        spacing: 10,
        children: [
          for(var v in length) buttons.textButtons(
            title: 'Fetching $v',
            showDropdown: true,
            onPressed: () { },
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget fieldGenerator(Map<String, dynamic> field) {
    switch(field["type"]) {

      case "radio":
        return _fieldRadio(field);

      case "select":
        return _fieldSelect(field);

      case "min_max":
        return _fieldMinMax(field);

      case "group_fields":
        return _fieldSelect(field);

      case "more":
        return _fieldMore(field);

      default:
        return _fieldMore(field);
    }
  }

  Widget _fieldMinMax(Map<String, dynamic> field) {
    final fieldApp = MinMax.fromJson(field);
    final minField = fieldApp.min_field ?? Field_.fromJson({});
    final maxField = fieldApp.max_field ?? Field_.fromJson({});

    // set val //
    bool check = ref.watch(newData)[minField.fieldname]!=null && ref.watch(newData)[maxField.fieldname]!=null && ref.watch(newData)[minField.fieldname].isNotEmpty && ref.watch(newData)[maxField.fieldname].isNotEmpty;
    if(ref.watch(newData)[minField.fieldname] != null || ref.watch(newData)[maxField.fieldname] != null) {
      futureAwait(duration: 1, () {
        ref.read(displayTitle.notifier).state = '${fieldApp.title}: ${ref.watch(newData)[minField.fieldname]??''}${check?' - ':''}${ref.watch(newData)[maxField.fieldname]??''}';
      });
    }

    return buttons.textButtons(
      title: ref.watch(displayTitle)??(fieldApp.title ?? 'MinMax'),
      showDropdown: true,
      onPressed: () async {
        final result = await showBarModalBottomSheet(
          context: context,
          builder: (context) => MinMaxPageView(data: field, newData: newData),
        );

        /// submit ///
        if(result != null) handleRefresh();
      },
      textColor: ref.watch(displayTitle)!=null ? config.primaryAppColor.shade600 : Colors.black,
      child: ref.watch(displayTitle)!=null ? InkWell(
        onTap: () async {
          ref.read(displayTitle.notifier).state = null;
          ref.read(newData.notifier).update((state) {
            final newVal = {...state};
            newVal[minField.fieldname] = null;
            newVal[maxField.fieldname] = null;
            return newVal;
          });

          /// submit ///
          handleRefresh();
        },
        child: const Icon(Icons.close, size: 18),
      ) : null,
    );
  }

  Widget _fieldRadio(Map<String, dynamic> field) {
    final fieldApp = RadioSelect.fromJson(field);
    var options = fieldApp.options ?? [];
    var fieldName = ValueSelect.fromJson(ref.watch(newData)[fieldApp.fieldname] ?? {});

    // type group radio button //
    if (options.length <= 3) {
      return buttons.textButtons(
        title: '${fieldApp.title}: ${fieldName.fieldtitle ?? ''}',
        showDropdown: true,
        onPressed: () async {
          final condition = StateProvider<String>((ref) => fieldName.fieldvalue ?? '');
          final result = await showBarModalBottomSheet(context: context,
            builder: (context) => GroupFieldView(data: field, newData: newData, condition: condition),
          );

          /// submit ///
          if(result != null) handleRefresh();
        },
        textColor: fieldName.fieldtitle != null ? config.primaryAppColor.shade600 : Colors.black,
        child: fieldName.fieldtitle != null ? InkWell(
          onTap: () async {
            ref.read(newData.notifier).update((state) {
              final newMap = {...state};
              newMap[fieldApp.fieldname] = null;
              return newMap;
            });

            /// submit ///
            handleRefresh();
          },
          child: const Icon(Icons.close, size: 18),
        ) : null,
      );
    }

    // type list radio button //
    return buttons.textButtons(
      title: fieldName.fieldtitle ?? (fieldApp.title ?? 'RadioType'),
      showDropdown: true,
      onPressed: () async {
        final result = await showBarModalBottomSheet(context: context,
          builder: (context) => SelectTypePageView(data: field, selected: false, newData: newData, expand: false,),
        );

        /// submit ///
        if(result != null) handleRefresh();
      },
      textColor: fieldName.fieldtitle != null ? config.primaryAppColor.shade600 : Colors.black,
      child: fieldName.fieldtitle != null ? InkWell(
        onTap: () async {
          ref.read(newData.notifier).update((state) {
            final newMap = {...state};
            newMap[fieldApp.fieldname] = null;
            return newMap;
          });

          /// submit ///
          handleRefresh();
        },
        child: const Icon(Icons.close, size: 18),
      ) : null,
    );
  }

  Widget _fieldSelect(Map<String, dynamic> field) {
    final fieldS = RadioSelect.fromJson(field);
    var fieldName = ValueSelect.fromJson(ref.watch(newData)[fieldS.fieldname] ?? {});

    /// normal select not have fields ///
    if(fieldS.type == 'group_fields' && fieldS.fields != null) {
      var opt = fieldS.fields ?? [];

      // set value to location //
      for(var v=0; v<opt.length; v++) {
        if(ref.watch(newData)[opt[v].fieldname] != null && ref.watch(newData)[opt[v].fieldname].isNotEmpty) {
          field['title2'] = ref.watch(newData)[opt[v].fieldname]['en_name'];
        }
      }

      return buttons.textButtons(
        title: '${field['title2'] ?? (fieldS.title ?? 'SelectType')}',
        showDropdown: true,
        prefixIcon: Icons.location_on,
        prefColor: field['title2'] != null ? config.primaryAppColor.shade600 : Colors.black,
        onPressed: () async {
          final result = await showBarModalBottomSheet(context: context,
            builder: (context) => ProvincePageView(data: field, newData: newData),
          );

          /// click clear on modal ///
          if(result != null) {
            if(result.toString().contains('clear')) {
              setState(() { field['title2'] = null; });
              for(var k=0; k<opt.length; k++) {
                ref.read(newData.notifier).state[opt[k].slug] = null;
              }
            }

            /// submit ///
            handleRefresh();
          }

        },
        textColor: field['title2'] != null ? config.primaryAppColor.shade600 : Colors.black,
        child: field['title2'] != null ? InkWell(
          onTap: () async {
            setState(() { field['title2'] = null; });
            for(var k=0; k<opt.length; k++) {
              ref.read(newData.notifier).state[opt[k].slug] = null;
            }

            /// submit ///
            handleRefresh();
          },
          child: const Icon(Icons.close, size: 18),
        ) : null,
      );
    }

    /// normal select ///
    return buttons.textButtons(
      title: fieldName.fieldtitle ?? (fieldS.title ?? 'SelectType'),
      showDropdown: true,
      onPressed: () async {
        final result = await showBarModalBottomSheet(context: context,
          builder: (context) => SelectTypePageView(data: field, selected: true, newData: newData, expand: false),
        );

        /// submit ///
        if(result != null) handleRefresh();
      },
      textColor: fieldName.fieldtitle != null ? config.primaryAppColor.shade600 : Colors.black,
      child: fieldName.fieldtitle != null ? InkWell(
        onTap: () async {
          ref.read(newData.notifier).update((state) {
            final newMap = {...state};
            newMap[fieldS.fieldname] = null;
            return newMap;
          });

          /// submit ///
          handleRefresh();
        },
        child: const Icon(Icons.close, size: 18),
      ) : null,
    );
  }

  Widget _fieldMore(Map field) {
    return buttons.textButtons(
      title: 'More',
      prefixChild: (ref.watch(indX) > 0) ? badges.Badge(
        position: badges.BadgePosition.topEnd(top: -8, end: -6),
        badgeContent:  Text('${ref.watch(indX)}', style: const TextStyle(color: Colors.white, fontSize: 8)),
        badgeAnimation: const badges.BadgeAnimation.fade(),
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.circle,
          badgeColor: config.warningColor.shade400,
          padding: const EdgeInsets.all(4),
          elevation: 0,
        ),
        child: const Icon(Icons.tune, color: Colors.black87, size: 18),
      ) : const Icon(Icons.tune, color: Colors.black87, size: 18),
      onPressed: onClickMoreFilter,
    );
  }

  void onClickMoreFilter() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyFilters(title: 'Filters', filters: jsonEncode(ref.watch(newData)), condition: widget.condition, slug: '${widget.data['slug']??''}' )),
    );

    if(result != null) {
      ref.read(newData.notifier).state = result ?? {};

      await handleRefresh();
    }
  }

}

enum Filter { price, condition }

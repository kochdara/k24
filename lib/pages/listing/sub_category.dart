
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/listing/sub_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:k24/serialization/filters/group_fields/group_fields.dart';
import 'package:k24/serialization/filters/provinces.dart';
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
  final Helper helper = const Helper();

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
    final dataCate = widget.data;
    final cate = dataCate['slug'];
    final limit = ref.watch(subListsProvider(category: '$cate').notifier).limit;
    final current = ref.watch(subListsProvider(category: '$cate').notifier).current_result;
    var fet = ref.read(fetchingProvider.notifier);

    if (scrollController.position.pixels >= (scrollController.position.maxScrollExtent - 750)
        && (current >= limit) && !fet.state) {
      fet.state = true;
      ref.read(subListsProvider(category: '$cate').notifier).subFetch('$cate');
      await helper.futureAwait(() { fet.state = false; });
    }
  }

  Future<void> handleRefresh() async {
    final dataCate = widget.data;
    final cate = dataCate['slug'];
    await ref.read(subListsProvider(category: '$cate').notifier).refresh(category: '$cate');
  }

  @override
  Widget build(BuildContext context) {
    final dataCate = widget.data;
    final watchCate = ref.watch(getMainCategoryProvider(parent: '${dataCate['id']}'));
    final watchLists = ref.watch(subListsProvider(category: '${dataCate['slug']}'));

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
                  config.responsiveSub(width);

                  return Container(
                    constraints: BoxConstraints(maxWidth: config.maxWidth),
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
                          data: (data) => myCards.subCategory(data, setFilters: {}, condition: true),
                        ),

                        /// grid view ///
                        watchLists.when(
                          error: (e, st) => myCards.notFound(context, id: '${dataCate['id']}', message: '$e'),
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

  setupPage() {
    newData = StateProvider((ref) => {});
    indX = StateProvider((ref) => 0);
  }

  getLocation({ String type = '', String parent = '' }) async {
    List? data = [];
    try {
      var url = 'locations?lang=${config.lang}';
      if(type.isNotEmpty) url += '&type=$type';
      if(parent.isNotEmpty) url += '&parent=$parent';
      var result = await config.getUrls(subs: url, url: Urls.baseUrl);
      if(result['status'] == 0 && result['data']!=null) data = result['data'];
    } catch(e) {
      data = null;
    }
    return data;
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

  shimmerFilter() {
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

  fieldGenerator(Map<String, dynamic> field) {
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

  _fieldMinMax(Map<String, dynamic> field) {
    final fieldApp = MinMax.fromJson(field);
    final minField = fieldApp.min_field ?? Field_.fromJson({});
    final maxField = fieldApp.max_field ?? Field_.fromJson({});

    // set val //
    // bool check = ref.watch(newData)[minField.fieldname]!=null && ref.watch(newData)[maxField.fieldname]!=null && ref.watch(newData)[minField.fieldname].isNotEmpty && ref.watch(newData)[maxField.fieldname].isNotEmpty;
    // if(ref.watch(newData)[minField.fieldname] != null || ref.watch(newData)[maxField.fieldname] != null) {
    //   field['displayTitle'] = '${fieldApp.title}: ${ref.watch(newData)[minField.fieldname]??''}${check?' - ':''}${ref.watch(newData)[maxField.fieldname]??''}';
    // }

    return buttons.textButtons(
      title: '${field['displayTitle']??(fieldApp.title ?? 'MinMax')}',
      showDropdown: true,
      onPressed: () async {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => MinMaxPageView(data: field),
        );
      },
      textColor: field['displayTitle']!=null ? config.primaryAppColor.shade600 : Colors.black,
      child: field['displayTitle']!=null ? InkWell(
        onTap: () async {
          //
        },
        child: const Icon(Icons.close, size: 18),
      ) : null,
    );
  }

  _fieldRadio(Map<String, dynamic> field) {
    final fieldApp = RadioSelect.fromJson(field);
    var options = fieldApp.options ?? [];
    var fieldName = ValueSelect.fromJson(ref.watch(newData)[fieldApp.fieldname] ?? {});

    // type group radio button //
    if (options.length <= 3) {
      return buttons.textButtons(
        title: '${fieldApp.title}: ${fieldName.fieldtitle ?? ''}',
        showDropdown: true,
        onPressed: () async {
          //
        },
        textColor: fieldName.fieldtitle != null ? config.primaryAppColor.shade600 : Colors.black,
        child: fieldName.fieldtitle != null ? InkWell(
          onTap: () async {
            //
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
        showBarModalBottomSheet(context: context,
          builder: (context) => SelectTypePageView(data: field, selected: false),
        );
      },
      textColor: fieldName.fieldtitle != null ? config.primaryAppColor.shade600 : Colors.black,
      child: fieldName.fieldtitle != null ? InkWell(
        onTap: () async {
          ref.read(newData.notifier).update((state) {
            final newMap = {...state};
            newMap[fieldApp.fieldname] = null;
            return newMap;
          });
        },
        child: const Icon(Icons.close, size: 18),
      ) : null,
    );
  }

  _fieldSelect(Map<String, dynamic> field) {
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
            builder: (context) => ProvincePageView(data: field),
          );

          /// click clear on modal ///
          if(result.toString().contains('clear')) {
            setState(() { field['title2'] = null; });
            for(var k=0; k<opt.length; k++) {
              ref.read(newData.notifier).state[opt[k].slug] = null;
            }
          }

        },
        textColor: field['title2'] != null ? config.primaryAppColor.shade600 : Colors.black,
        child: field['title2'] != null ? InkWell(
          onTap: () async {
            setState(() { field['title2'] = null; });
            for(var k=0; k<opt.length; k++) {
              ref.read(newData.notifier).state[opt[k].slug] = null;
            }
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
        showBarModalBottomSheet(context: context,
          builder: (context) => SelectTypePageView(data: field, selected: true),
        );
      },
      textColor: fieldName.fieldtitle != null ? config.primaryAppColor.shade600 : Colors.black,
      child: fieldName.fieldtitle != null ? InkWell(
        onTap: () async {
          ref.read(newData.notifier).update((state) {
            final newMap = {...state};
            newMap[fieldS.fieldname] = null;
            return newMap;
          });
        },
        child: const Icon(Icons.close, size: 18),
      ) : null,
    );
  }

  _fieldMore(Map field) {
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

  onClickMoreFilter() async {
    // final result = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MyFilters(title: 'Filters', filters: jsonEncode(ref.watch(newData)), condition: widget.condition, slug: '${widget.data['slug']??''}' )),
    // );
    //
    // if(result != null) {
    //   ref.read(newData.notifier).state = result ?? {};
    //
    //   await handleRefresh();
    // }
  }

}

enum Filter { price, condition }

/// select type model ///
class MinMaxPageView extends ConsumerWidget {
  MinMaxPageView({super.key, required this.data});

  final Map<String, dynamic> data;

  final Labels labels = Labels();
  final Config config = Config();
  final Buttons buttons = Buttons();
  final Forms forms = Forms();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mData = MinMax.fromJson(data);

    var minField = mData.min_field ?? {};
    var maxField = mData.max_field ?? {};

    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// app bar ///
            AppBar(
              leading: Container(),
              title: Container(),
              centerTitle: true,
              backgroundColor: Colors.grey.shade200,
            ),

            /// listing ///
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
                color: Colors.grey.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labels.label('${mData.title}', color: Colors.black, fontSize: 15),

                  const SizedBox(height: 8),

                  LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                      double width = constraints.maxWidth;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (width / 2) - 8,
                            child: forms.labelFormFields(
                                autofocus: true,
                                '',
                                // '${minField['title']??''}',
                                // controller: field?["min_controller"],
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.digitsOnly
                                ], keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  // field?["min_controller"].text = val;

                                }
                            ),
                          ),

                          SizedBox(
                            width: (width / 2) - 8,
                            child: forms.labelFormFields(
                              '',
                              // '${maxField['title']??''}',
                              // controller: field?["max_controller"],
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ], keyboardType: TextInputType.number,
                              onChanged: (val) {
                                // field?["max_controller"].text = val;

                              },
                              onFieldSubmitted: (val) {
                                //
                              },
                            ),
                          ),

                        ],
                      );
                    }
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: buttons.textButtons(
                      title: 'Apply Filter',
                      onPressed: () {},
                      padSize: 14,
                      textSize: 16,
                      textWeight: FontWeight.w500,
                      textColor: Colors.white,
                      bgColor: config.warningColor.shade400,
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/// select type model ///
class SelectTypePageView extends ConsumerWidget {
  SelectTypePageView({super.key, required this.data, required this.selected});

  final Map<String, dynamic> data;
  final bool selected;

  final Labels labels = Labels();
  final Config config = Config();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortData = RadioSelect.fromJson(data);

    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// app bar ///
            AppBar(
              leading: IconButton(
                padding: const EdgeInsets.all(14),
                icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 32, color: Colors.blue),
                onPressed: () { Navigator.pop(context); },
              ),
              title: labels.label('${sortData.title}', color: Colors.black, fontSize: 18),
              actions: [
                if(ref.watch(newData)[sortData.fieldname] != null) IconButton(
                  padding: const EdgeInsets.all(14),
                  icon: labels.label('Clear', color: Colors.blue, fontSize: 15),
                  onPressed: () {
                    ref.read(newData.notifier).update((state) {
                      final newMap = {...state};
                      newMap[sortData.fieldname] = null;
                      return newMap;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
              centerTitle: true,
              backgroundColor: Colors.grey.shade200,
            ),

            /// listing ///
            ListView.builder(
              itemCount: sortData.options?.length ?? 0,
              shrinkWrap: true,
              controller: ModalScrollController.of(context),
              itemBuilder: (context, index) {
                final check = ValueSelect.fromJson(ref.watch(newData)[sortData.fieldname] ?? {});
                final options = sortData.options?[index];

                return ListTile(
                  title: labels.label('${options?.fieldtitle}', color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal, overflow: TextOverflow.ellipsis),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(check.fieldvalue == options?.fieldvalue) ...[
                        if(selected) Icon(Icons.check_circle, size: 20, color: config.primaryAppColor.shade600)
                        else Icon(Icons.radio_button_checked_outlined, size: 20, color: config.primaryAppColor.shade600),
                      ] else ...[
                        if(!selected) const Icon(Icons.radio_button_off, size: 20)
                      ],
                    ],
                  ),
                  shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                  onTap: () {
                    ref.read(newData.notifier).update((state) {
                        final newMap = {...state};
                        newMap[sortData.fieldname] = options?.toJson();
                        return newMap;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}

/// group select type model ///
class ProvincePageView extends ConsumerWidget {
  ProvincePageView({super.key, required this.data});

  final Map<String, dynamic> data;

  final Labels labels = Labels();
  final Config config = Config();

  final current = StateProvider((ref) => 0);
  final slug = StateProvider((ref) => {});
  final lastResult = StateProvider((ref) => {});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupData = GroupFields.fromJson(data);
    final fields = groupData.fields ?? [];
    final checkData = ref.watch(newData);

    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// app bar ///
            AppBar(
              leading: (ref.watch(current) > 0) ? IconButton(
                padding: const EdgeInsets.all(14),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
                onPressed: () { ref.read(current.notifier).state--; },
              ) : IconButton(
                padding: const EdgeInsets.all(14),
                icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 32, color: Colors.blue),
                onPressed: () { Navigator.pop(context); },
              ),
              title: labels.label(fields[ref.watch(current)].title ?? '', color: Colors.black, fontSize: 18),
              actions: [
                if(ref.watch(current) > 0) IconButton(
                  padding: const EdgeInsets.all(14),
                  icon: labels.label('Clear', color: Colors.blue, fontSize: 15),
                  onPressed: () {
                    Navigator.pop(context, 'clear');
                  },
                ),
              ],
              centerTitle: true,
              backgroundColor: Colors.grey.shade200,
            ),

            // any //
            if(ref.watch(current) > 0) ListTile(
              title: labels.label('Any', color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
              tileColor: Colors.white,
              onTap: () {
                /// submit ///
                final last = ref.watch(lastResult);
                if(last.isNotEmpty) {
                  last.forEach((key, value) {
                    ref.read(newData.notifier).update((state) {
                      final newMap = {...state};
                      newMap[key] = value;
                      return newMap;
                    });
                  });
                }
                Navigator.pop(context);

              },
            ),

            /// listing ///
            for(var v=0; v<fields.length; v++)
              Visibility(
                visible: (ref.watch(current) == v),
                child: Expanded(
                  child: Builder(
                    builder: (context) {
                      final wSlug = ref.watch(slug);
                      final watchGetPro = ref.watch(getLocationProvider(type: '${fields[ref.watch(current)].slug}', parent: '${wSlug[ref.watch(current)??'']}'));

                      return watchGetPro.when(
                        skipLoadingOnRefresh: false,
                        error: (e, st) => Text('error : $e'),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        data: (data) {
                          return ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            controller: ModalScrollController.of(context),
                            itemBuilder: (context, index) {
                              final proData = Province.fromJson(data[index] ?? {});
                              final dl = checkData[proData.type] ?? {};

                              return ListTile(
                                title: labels.label('${proData.en_name}', color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal, overflow: TextOverflow.ellipsis),
                                trailing: (dl['slug'] == proData.slug) ? Icon(Icons.check_circle, size: 20, color: config.primaryAppColor.shade600)
                                    : const Icon(Icons.arrow_forward_ios, size: 16),
                                shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                                tileColor: Colors.white,
                                onTap: () {
                                  ref.read(lastResult.notifier).state[proData.type] = proData.toJson();

                                  if(ref.watch(current) < (fields.length - 1)) {
                                    ref.read(current.notifier).state++;
                                    ref.read(slug.notifier).state[ref.watch(current)] = proData.slug ?? '';

                                    // clear old value //
                                    for(var k=v+1; k<fields.length; k++) {
                                      ref.read(lastResult.notifier).state[fields[k].slug] = null;
                                    }

                                    /// else submit ///
                                  } else {
                                    final last = ref.watch(lastResult);
                                    if(last.isNotEmpty) {
                                      last.forEach((key, value) {
                                        ref.read(newData.notifier).update((state) {
                                          final newMap = {...state};
                                          newMap[key] = value;
                                          return newMap;
                                        });
                                      });
                                    }
                                    Navigator.pop(context);
                                  }

                                },
                              );
                            },
                          );
                        }
                      );
                    }
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}

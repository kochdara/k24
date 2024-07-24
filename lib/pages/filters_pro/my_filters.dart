
// ignore_for_file: unused_result

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/filters_pro/filters_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

import '../../helpers/helper.dart';
import '../../serialization/filters/group_fields/group_fields.dart';
import '../../serialization/filters/min_max/min_max.dart';
import '../../serialization/filters/provinces.dart';
import '../../serialization/filters/radio_select/radio.dart';
import '../../serialization/filters/switch/switch_type.dart';
import '../../widgets/modals.dart';
import '../listing/sub_provider.dart';
import '../main/home_provider.dart';

Config config = Config();
Labels labels = Labels();
Buttons buttons = Buttons();
Forms forms = Forms();

class MyFilters extends ConsumerStatefulWidget {
  const MyFilters({super.key, required this.title, required this.filters, required this.condition, required this.slug,});

  final String title;
  final String filters;
  final bool condition;
  final String slug;

  @override
  ConsumerState<MyFilters> createState() => _MyFiltersState();
}

class _MyFiltersState extends ConsumerState<MyFilters> {
  ScrollController scrollController = ScrollController();
  StateProvider<Map> newDataFil = StateProvider<Map>((ref) => {});
  StateProvider<bool> setCon = StateProvider((ref) => true);
  StateProvider<int> ind = StateProvider((ref) => 1);
  StateProvider<Map> parent = StateProvider((ref) => {});
  StateProvider<bool> checkVal = StateProvider((ref) => false);

  double space = 10;

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
      appBar: appBar(),
      backgroundColor: config.backgroundColor,
      body: body(),
      bottomNavigationBar: bottomNav(),
    );
  }

  void setupPage() {
    newDataFil = StateProvider<Map>((ref) => jsonDecode(widget.filters));
  }

  void onPressedApply() {
    Navigator.pop(context, ref.watch(newDataFil));
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: labels.label(widget.title.isNotEmpty ? widget.title : 'Filters', fontSize: 22),
      titleSpacing: 0,
      actions: [
        buttons.textButtons(
          title: 'Apply Filter',
          textColor: Colors.white,
          textWeight: FontWeight.w500,
          textSize: 16,
          onPressed: onPressedApply,
          bgColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget bottomNav() {
    futureAwait(duration: 1, () {
      final val = ref.watch(newDataFil);
      val.forEach((key, value) {
        if(value != null) ref.read(checkVal.notifier).state = true;
      });

      if(val.isEmpty) ref.read(checkVal.notifier).state = false;
    });

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double wid = (width / 3) - 4;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(ref.watch(checkVal))
                  SizedBox(
                    width: wid,
                    child: buttons.textButtons(
                      title: 'Clear',
                      onPressed: () async {
                        setCon = StateProvider((ref) => true);
                        ind = StateProvider((ref) => 1);
                        ref.read(newDataFil.notifier).update((state) {
                          final newMap = {...state};
                          newMap.clear();
                          return newMap;
                        });
                      },
                      padSize: 14,
                      textSize: 16,
                      textWeight: FontWeight.w500,
                      textColor: config.secondaryColor.shade300,
                    ),
                  ),

                SizedBox(
                  width: ref.watch(checkVal) ? (wid * 2) - 16 : width - 16,
                  child: buttons.textButtons(
                    title: 'Apply Filter',
                    onPressed: onPressedApply,
                    padSize: 14,
                    textSize: 16,
                    textWeight: FontWeight.w500,
                    textColor: Colors.white,
                    bgColor: config.warningColor.shade400,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Widget body() {
    final watchFilter = ref.watch(getFilterProProvider(widget.slug));

    return SingleChildScrollView(
      controller: scrollController,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(14),
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              watchFilter.when(
                error: (error, stackTrace) => Text('error : $error'),
                loading: () => shimmerLoad(),
                data: (data) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Map field = data[index];
                      //
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// generate list filter ///
                          _fieldGenerator(field),

                          SizedBox(height: space),
                        ],
                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                },
              ),

              /// view button ///
              if(watchFilter.hasValue) Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: config.secondaryColor.shade100),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    labels.label(
                      'View',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),

                    Row(
                      children: [
                        buttons.buttonTap(
                          onTap: () {ref.read(viewPageProvider.notifier).state = ViewPage.view;},
                          icon: CupertinoIcons.list_bullet_below_rectangle,
                          color: ref.watch(viewPageProvider) == ViewPage.view ? config.secondaryColor.shade700 : null,
                          size: 23,
                        ),

                        buttons.buttonTap(
                          onTap: () {ref.read(viewPageProvider.notifier).state = ViewPage.list;},
                          icon: CupertinoIcons.list_bullet,
                          color: ref.watch(viewPageProvider) == ViewPage.list ? config.secondaryColor.shade700 : null,
                          size: 23,
                        ),

                        buttons.buttonTap(
                          onTap: () {ref.read(viewPageProvider.notifier).state = ViewPage.grid;},
                          icon: CupertinoIcons.square_grid_2x2,
                          color: ref.watch(viewPageProvider) == ViewPage.grid ? config.secondaryColor.shade700 : null,
                          size: 23,
                        ),
                      ],
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldGenerator(Map field) {
    switch(field["type"]) {

      case "radio":
        return _fieldRadio(field);

      case "select":
        return _fieldSelect(field);

      case "min_max":
        return _fieldMinMax(field);

      case "switch":
        return _fieldSwitch(field);

      case "group_fields":
        return _fieldSelect(field);

      default:
        return _fieldSelect(field);
    }
  }

  Widget _fieldRadio(Map field) {
    final radioField = StateProvider((ref) => RadioSelect.fromJson(field as Map<String, dynamic>));
    final sRadioField = ref.read(radioField.notifier);
    final wRadioField = ref.watch(radioField);
    sRadioField.state.controller ??= TextEditingController();

    /// set value ///
    if(ref.watch(newDataFil)[wRadioField.fieldname] != null) {
      sRadioField.state.controller.text = ref.watch(newDataFil)[wRadioField.fieldname]['fieldtitle']??'';
    }

    /// type group radio button ///
    List options = wRadioField.options ?? [];
    final fieldName = ValueSelect.fromJson(ref.watch(newDataFil)[wRadioField.fieldname] ?? {});
    if (options.length <= 3) {
      final condition = StateProvider<String>((ref) => fieldName.fieldvalue ?? '');
      return GroupFieldPage(data: field as Map<String, dynamic>, newData: newDataFil, condition: condition);
    }

    /// normal radio button ///
    return forms.labelFormFields(
        labelText: '${wRadioField.title}',
        readOnly: true,
        controller: wRadioField.controller,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        onTap: () async {
          await showBarModalBottomSheet(context: context,
            builder: (context) => SelectTypePageView(data: field as Map<String, dynamic>, selected: false, newData: newDataFil, expand: false),
          );

          /// submit ///
        }
    );
  }

  Widget _fieldSelect(Map field) {
    final radioField = StateProvider((ref) => RadioSelect.fromJson(field as Map<String, dynamic>));
    final sRadioField = ref.read(radioField.notifier).state;
    final wRadioField = ref.watch(radioField);
    sRadioField.controller ??= TextEditingController();

    /// set value ///
    if(ref.watch(newDataFil)[wRadioField.fieldname] != null) {
      sRadioField.controller.text = ref.watch(newDataFil)[wRadioField.fieldname]['fieldtitle']??'';
    }

    /// have fields select ///
    if(sRadioField.type == 'group_fields' && wRadioField.fields != null) {
      StateProvider<List<RadioSelect>> fields = StateProvider((ref) => wRadioField.fields ?? []);
      List<RadioSelect> stateLoc = ref.read(fields.notifier).state;
      List<RadioSelect> watchLoc = ref.watch(fields);

      for(int v=0; v<watchLoc.length; v++) {
        if (watchLoc[v].controller == null) stateLoc[v].controller = TextEditingController();
      }

      /// if select location ///
      if(wRadioField.slug == 'locations') {
        final ir = ref.read(ind.notifier);
        final iw = ref.watch(ind);

        // set control if have value //
        for(int v=0; v<watchLoc.length; v++) {
          final newDa = ref.watch(newDataFil)[watchLoc[v].fieldname];
          if(newDa != null) {
            ref.read(parent.notifier).state[v+1] = newDa['slug'] ?? ''; // update parent
            stateLoc[v].controller.text = newDa['en_name'] ?? '';

            // set enable of disable nex select //
            futureAwait(() {
              ir.state = v + 2;
            }, duration: 1);
          }
        }

        return Column(
          children: [

            for(int v=0; v<watchLoc.length; v++) ...[
              forms.labelFormFields(
                  labelText: '${watchLoc[v].title}',
                  readOnly: true,
                  enabled: (v < iw) ? true : false,
                  controller: stateLoc[v].controller,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  onTap: () async {
                    final result = await showBarModalBottomSheet(context: context,
                      builder: (context) => ProvincePage(data: watchLoc[v].toJson() as Map<String, dynamic>, newData: newDataFil, valKey: v, parent: parent),
                    );

                    if(result != null) {
                      stateLoc[v].controller.text = result['en_name'] ?? '';
                      ir.state = v+2;

                      /// on click clear //
                      if(result.isEmpty) {
                        ir.state = v + 1;
                        ref.read(newDataFil.notifier).state.remove(watchLoc[v].fieldname);
                      }

                      // clear next select //
                      for(int k=v+1; k<watchLoc.length; k++) {
                        ref.read(newDataFil.notifier).state.remove(watchLoc[k].fieldname);
                        stateLoc[k].controller.text = '';
                      }
                    }

                  }
              ),

              if(v < watchLoc.length - 1) SizedBox(height: space),
            ],

          ],
        );
      }


      /// set default val ///
      for(int v=0; v<watchLoc.length; v++) {
        if (ref.watch(newDataFil)[watchLoc[v].fieldname] != null) {
          stateLoc[v].controller.text = ref.watch(newDataFil)[watchLoc[v].fieldname]['fieldtitle'] ?? '';
        }
      }
      return Column(
        children: [

          /// type select ///
          for(int v=0; v<watchLoc.length; v++) ...[
            if(watchLoc[v].type == 'select') ...[
              forms.labelFormFields(
                  labelText: '${watchLoc[v].title}',
                  readOnly: true,
                  controller: watchLoc[v].controller,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  onTap: () async {
                    final result = await showBarModalBottomSheet(context: context,
                      builder: (context) => SelectTypePageView(data: watchLoc[v].toJson() as Map<String, dynamic>, selected: true, newData: newDataFil, expand: true),
                    );

                    if(result != null) stateLoc[v].controller.text = '';

                  }
              ),

              /// type min_max //
            ] else if(watchLoc[v].type == 'min_max') ...[
              _fieldMinMax(field['fields'][v]),

            ],

            if(v < watchLoc.length - 1) SizedBox(height: space),
          ],

        ],
      );
    }

    /// normal radio button ///
    return forms.labelFormFields(
        labelText: '${wRadioField.title}',
        readOnly: true,
        controller: wRadioField.controller,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        onTap: () async {
          await showBarModalBottomSheet(context: context,
            builder: (context) => SelectTypePageView(
              data: field as Map<String, dynamic>,
              selected: true,
              newData: newDataFil,
              expand: false,
            ),
          );

          /// submit ///
        }
    );
  }

  Widget _fieldMinMax(Map field) {
    return MinMaxPage(data: field as Map<String, dynamic>, newData: newDataFil, setCon: setCon);
  }

  Widget _fieldSwitch(Map field) {
    final switchField = SwitchType.fromJson(field);
    List options = switchField.options ?? [];
    List fil = options.where((item) { return item.value == '${ref.watch(newDataFil)[switchField.fieldname]??''}';}).toList();
    ValueSwitch? app;

    if(fil.isNotEmpty) { app = fil.first; }
    else { app = switchField.value; }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: config.secondaryColor.shade100),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labels.label('${switchField.title}', fontSize: 12, color: config.secondaryColor.shade200),
              labels.label(app?.title ?? 'N/A', fontSize: 16, color: Colors.black),
            ],
          ),

          Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              activeColor: config.primaryAppColor.shade300,
              thumbColor: Colors.white,
              trackColor: Colors.black12,
              value: ref.watch(newDataFil)[switchField.fieldname] == 'true' ? true : false,
              onChanged: (value) {
                ref.read(newDataFil.notifier).update((state) {
                  final newMap = {...state};
                  newMap[switchField.fieldname] = '$value';
                  return newMap;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerLoad() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.white,
      child: Column(
        children: [
          for(var v=0; v<6; v++) ...[
            forms.labelFormFields(
              labelText: 'demo',
              readOnly: true,
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),

            SizedBox(height: space),
          ],
        ],
      ),
    );
  }
}




/// min max model ///
class MinMaxPage extends ConsumerWidget {
  const MinMaxPage({super.key, required this.data, required this.newData, required this.setCon});

  final Map<String, dynamic> data;
  final StateProvider<Map> newData;
  final StateProvider<bool> setCon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mFields = StateProvider((ref) => MinMax.fromJson(data));
    final sField = ref.read(mFields.notifier);
    final wField = ref.watch(mFields);
    sField.state.min_controller ??= TextEditingController();
    sField.state.max_controller ??= TextEditingController();

    final minField = wField.min_field ?? Field_.fromJson({});
    final maxField = wField.max_field ?? Field_.fromJson({});

    /// set value ///
    sField.state.min_controller.text = '${ref.watch(newData)[minField.fieldname] ?? ''}';
    sField.state.max_controller.text = '${ref.watch(newData)[maxField.fieldname] ?? ''}';


    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            /// listing ///
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labels.label('${wField.title}', color: Colors.black, fontSize: 15),

                const SizedBox(height: 8),

                LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  double width = constraints.maxWidth;
                  final set = ref.read(setCon.notifier);
                  final watch = ref.watch(setCon);

                  if(minField.type == 'select') {
                    /// set value select ///
                    if(ref.watch(newData)[minField.fieldname] != null) wField.min_controller.text = ref.watch(newData)[minField.fieldname]['fieldtitle']??'';
                    if(ref.watch(newData)[maxField.fieldname] != null) wField.max_controller.text = ref.watch(newData)[maxField.fieldname]['fieldtitle']??'';

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (width / 2) - 7,
                          child: forms.labelFormFields(
                              labelText: minField.title ?? '',
                              readOnly: true,
                              controller: wField.min_controller,
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              onTap: () async {
                                await showBarModalBottomSheet(context: context,
                                  builder: (context) => SelectTypePageView(data: minField.toJson() as Map<String, dynamic>, selected: true, newData: newData, expand: true),
                                );
                              }
                          ),
                        ),

                        SizedBox(
                          width: (width / 2) - 7,
                          child: forms.labelFormFields(
                              labelText: maxField.title ?? '',
                              readOnly: true,
                              controller: wField.max_controller,
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              onTap: () async {
                                await showBarModalBottomSheet(context: context,
                                  builder: (context) => SelectTypePageView(data: maxField.toJson() as Map<String, dynamic>, selected: true, newData: newData, expand: true),
                                );
                              }
                          ),
                        ),

                      ],
                    );
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: (width / 2) - 8,
                        child: forms.labelFormFields(
                            labelText: minField.title??'',
                            controller: watch ? wField.min_controller : null,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ], keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onTap: () => set.state = false,
                            onChanged: (val) {
                              ref.read(newData.notifier).update((state) {
                                final newMap = {...state};
                                newMap[minField.fieldname] = val;
                                return newMap;
                              });

                            }
                        ),
                      ),

                      SizedBox(
                        width: (width / 2) - 8,
                        child: forms.labelFormFields(
                          labelText: maxField.title??'',
                          controller: watch ? wField.max_controller : null,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ], keyboardType: TextInputType.number,
                          onTap: () => set.state = false,
                          onChanged: (val) async {
                            ref.read(newData.notifier).update((state) {
                              final newMap = {...state};
                              newMap[maxField.fieldname] = val;
                              return newMap;
                            });

                          },
                        ),
                      ),

                    ],
                  );
                }
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

/// radio with tap model ///
class GroupFieldPage extends ConsumerWidget {
  const GroupFieldPage({super.key, required this.data, required this.condition, required this.newData});

  final Map<String, dynamic> data;
  final StateProvider<Map> newData;
  final StateProvider<String> condition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mData = RadioSelect.fromJson(data);
    final list = mData.options ?? [];

    final setVal = ref.read(condition.notifier);
    final watchVal = ref.watch(condition);

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            /// listing ///
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labels.label('${mData.title}', color: Colors.black, fontSize: 15),

                const SizedBox(height: 8),

                LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      double width = constraints.maxWidth;

                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [

                          SizedBox(
                            width: (width / 3) - 10,
                            child: buttons.textButtons(
                              title: 'Any',
                              onPressed: () {
                                Map val = {'fieldtitle': 'Any', 'fieldvalue': '', 'popular': 'false', 'fieldid': '29'} as Map<String, dynamic>;

                                setVal.state = '';

                                ref.read(newData.notifier).update((state) {
                                  final newMap = {...state};
                                  newMap[mData.fieldname] = val;
                                  return newMap;
                                });
                              },
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textSize: 15,
                              bgColor: watchVal == '' ? config.infoColor.shade50 : Colors.white,
                              borderColor: watchVal == '' ? config.infoColor.shade300 : config.secondaryColor.shade100,
                            ),
                          ),

                          for(final v in list) ...[
                            SizedBox(
                              width: (width / 3) - 10,
                              child: buttons.textButtons(
                                title: v?.fieldtitle ?? '',
                                onPressed: () {
                                  Map val = v?.toJson() as Map<String, dynamic>;

                                  setVal.state = v?.fieldvalue??'';

                                  ref.read(newData.notifier).update((state) {
                                    final newMap = {...state};
                                    newMap[mData.fieldname] = val;
                                    return newMap;
                                  });
                                },
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                textSize: 15,
                                bgColor: v?.fieldvalue == watchVal ? config.infoColor.shade50 : Colors.white,
                                borderColor: v?.fieldvalue == watchVal ? config.infoColor.shade300 : config.secondaryColor.shade100,
                              ),
                            ),
                          ],

                        ],
                      );
                    }
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

/// group select type model ///
class ProvincePage extends ConsumerWidget {
  const ProvincePage({super.key, required this.data, required this.newData, required this.parent, required this.valKey});

  final Map<String, dynamic> data;
  final StateProvider<Map> newData;
  final StateProvider<Map> parent;
  final int valKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupData = GroupFields.fromJson(data);
    final checkData = ref.watch(newData);

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
              title: labels.label(groupData.title ?? '', color: Colors.black, fontSize: 18),
              actions: [
                if(checkData[groupData.fieldname] != null) IconButton(
                  padding: const EdgeInsets.all(14),
                  icon: labels.label('Clear', color: Colors.blue, fontSize: 15),
                  onPressed: () {
                    Navigator.pop(context, {});
                  },
                ),
              ],
              centerTitle: true,
              backgroundColor: Colors.grey.shade200,
            ),

            /// listing ///
            Expanded(
              child: Builder(
                  builder: (context) {
                    final watchGetPro = ref.watch(getLocationProvider('${groupData.slug}', '${ref.watch(parent)[valKey]}'));

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
                                trailing: (dl['slug'] == proData.slug) ? Icon(Icons.check_circle, size: 20, color: config.primaryAppColor.shade600) : null,
                                shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                                tileColor: Colors.white,
                                onTap: () {
                                  ref.read(parent.notifier).update((state) {
                                    final newMap = {...state};
                                    newMap[valKey + 1] = proData.slug;
                                    return newMap;
                                  });

                                  ref.read(newData.notifier).update((state) {
                                    final newMap = {...state};
                                    newMap[groupData.fieldname] = proData.toJson();
                                    return newMap;
                                  });

                                  Navigator.pop(context, proData.toJson());

                                },
                              );
                            },
                          );
                        }
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
}

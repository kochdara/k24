
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../helpers/config.dart';
import '../helpers/helper.dart';
import '../pages/listing/sub_provider.dart';
import '../serialization/filters/group_fields/group_fields.dart';
import '../serialization/filters/min_max/min_max.dart';
import '../serialization/filters/provinces.dart';
import '../serialization/filters/radio_select/radio.dart';
import 'buttons.dart';
import 'forms.dart';
import 'labels.dart';
import 'my_cards.dart';
import 'my_widgets.dart';

final Buttons buttons = Buttons();
final Labels labels = Labels();
final Config config = Config();
final MyCards myCards = MyCards();
final MyWidgets myWidgets = MyWidgets();
final Forms forms = Forms();

/// min max model ///
class MinMaxPageView extends ConsumerWidget {
  const MinMaxPageView({super.key, required this.data, required this.newData});

  final Map<String, dynamic> data;
  final StateProvider<Map> newData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mData = MinMax.fromJson(data);

    var minField = Field_.fromJson(mData.min_field?.toJson() ?? {});
    var maxField = Field_.fromJson(mData.max_field?.toJson() ?? {});

    var minCon = StateProvider((ref) => TextEditingController());
    var maxCon = StateProvider((ref) => TextEditingController());
    var valMap = StateProvider((ref) => {});
    final newDa = ref.watch(newData);

    futureAwait(duration: 1, () {
      ref.read(minCon.notifier).state.text = '${newDa[minField.fieldname] ?? ' '}';
      ref.read(maxCon.notifier).state.text = '${newDa[maxField.fieldname] ?? ' '}';
    });

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
                              labelText: minField.title??'',
                              controller: ref.watch(minCon),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ], keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (val) {
                                ref.read(valMap.notifier).update((state) {
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
                            controller: ref.read(maxCon),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.digitsOnly
                            ], keyboardType: TextInputType.number,
                            onChanged: (val) {
                              ref.read(valMap.notifier).update((state) {
                                final newMap = {...state};
                                newMap[maxField.fieldname] = val;
                                return newMap;
                              });

                            },
                            onFieldSubmitted: (val) {
                              final last = ref.watch(valMap);
                              last.forEach((key, value) {
                                ref.read(newData.notifier).update((state) {
                                  final newMap = {...state};
                                  newMap[key] = value;
                                  return newMap;
                                });
                              });

                              Navigator.pop(context, 'success');
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
                      onPressed: () {
                        final last = ref.watch(valMap);
                        last.forEach((key, value) {
                          ref.read(newData.notifier).update((state) {
                            final newMap = {...state};
                            newMap[key] = value;
                            return newMap;
                          });
                        });

                        Navigator.pop(context, 'success');
                      },
                      padSize: 14,
                      textSize: 16,
                      textWeight: FontWeight.w500,
                      textColor: Colors.white,
                      bgColor: config.warningColor.shade400,
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
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

/// radio with tap model ///
class GroupFieldView extends ConsumerWidget {
  GroupFieldView({super.key, required this.data, required this.condition, required this.newData});

  final Map<String, dynamic> data;
  final StateProvider<Map> newData;
  final StateProvider<String> condition;

  final lastVal = StateProvider((ref) => {});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mData = RadioSelect.fromJson(data);
    final list = mData.options ?? [];

    final last = ref.read(lastVal.notifier);
    final watch = ref.watch(lastVal);

    final setVal = ref.read(condition.notifier);
    final watchVal = ref.watch(condition);

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
                                  last.state = {'fieldtitle': 'Any', 'fieldvalue': '', 'popular': 'false', 'fieldid': '29'} as Map<String, dynamic>;
                                  setVal.state = '';
                                },
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                textSize: 15,
                                bgColor: watchVal == '' ? config.infoColor.shade50 : Colors.white,
                                borderColor: watchVal == '' ? config.infoColor.shade300 : config.secondaryColor.shade100,
                              ),
                            ),

                            for(var v in list) ...[
                              SizedBox(
                                width: (width / 3) - 10,
                                child: buttons.textButtons(
                                  title: v?.fieldtitle ?? '',
                                  onPressed: () {
                                    last.state = v?.toJson() as Map<String, dynamic>;
                                    setVal.state = v?.fieldvalue??'';
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

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: buttons.textButtons(
                      title: 'Apply Filter',
                      onPressed: () {
                        if(watch.isNotEmpty) {
                          ref.read(newData.notifier).update((state) {
                            final newMap = {...state};
                            newMap[mData.fieldname] = watch;
                            return newMap;
                          });
                        }

                        Navigator.pop(context, 'success');
                      },
                      padSize: 14,
                      textSize: 16,
                      textWeight: FontWeight.w500,
                      textColor: Colors.white,
                      bgColor: config.warningColor.shade400,
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
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
  SelectTypePageView({super.key, required this.data, required this.selected, required this.newData, required this.expand});

  final Map<String, dynamic> data;
  final StateProvider<Map> newData;
  final StateProvider<List<ValueSelect?>?> listOptions = StateProvider((ref) => null);
  final bool selected;
  final bool expand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortData = RadioSelect.fromJson(data);

    if(sortData.fieldname == 'ad_model' && ref.watch(newData)['ad_field'] != null) {
      final val = ref.watch(newData)['ad_field'];
      final v = sortData.options?.where((option) => option != null && option.fieldparentvalue == val['fieldvalue']);

      futureAwait(duration: 10, () {
        ref.read(listOptions.notifier).update((state) {
          List<ValueSelect?>? newList = state;
          newList = {...?v}.toSet().toList();
          return newList;
        });
      });
    }

    final optionWatch = ref.watch(listOptions);

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
                      if(sortData.fieldname == 'ad_field') newMap['ad_model'] = null;
                      newMap[sortData.fieldname] = null;
                      return newMap;
                    });
                    Navigator.pop(context, 'success');
                  },
                ),
              ],
              centerTitle: true,
              backgroundColor: Colors.grey.shade200,
            ),

            /// listing ///
            Expanded(
              flex: (expand || sortData.options!.length >= 8) ? 1 : 0,
              child: ListView.builder(
                itemCount: optionWatch?.length ?? (sortData.options?.length ?? 0),
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                itemBuilder: (context, index) {
                  final check = ValueSelect.fromJson(ref.watch(newData)[sortData.fieldname] ?? {});
                  final options = optionWatch != null ? optionWatch[index] : sortData.options?[index];
              
                  return ListTile(
                    leading: (options?.icon != null) ? SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(options?.icon?.url??'', fit: BoxFit.cover),
                    ) : null,
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
                        if(sortData.fieldname == 'ad_field') newMap['ad_model'] = null;
                        return newMap;
                      });
                      Navigator.pop(context, 'success');
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/// group select type model ///
class ProvincePageView extends ConsumerWidget {
  ProvincePageView({super.key, required this.data, required this.newData});

  final Map<String, dynamic> data;
  final StateProvider<Map> newData;

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
                Navigator.pop(context, 'success');

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
                        final watchGetPro = ref.watch(getLocationProvider('${fields[ref.watch(current)].slug}', '${wSlug[ref.watch(current)??'']}'));

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
                                        Navigator.pop(context, 'success');
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

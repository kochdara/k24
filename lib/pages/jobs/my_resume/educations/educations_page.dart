
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/jobs/my_resume/educations/educations_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../widgets/dialog_builder.dart';
import '../../../more_provider.dart';
import '../check_informations.dart';

final labels = Labels();
final config = Config();
final myCards = MyCards();
final forms = Forms();
final buttons = Buttons();

class EducationsPage extends ConsumerStatefulWidget {
  const EducationsPage({super.key,
    this.id,
  });

  final String? id;

  @override
  ConsumerState<EducationsPage> createState() => _EducationsPageState();
}

class _EducationsPageState extends ConsumerState<EducationsPage> {
  final _formKey = GlobalKey<FormState>();
  final StateProvider<Map> newMap = StateProvider((ref) => {});
  final StateProvider<Map> tmpMap = StateProvider((ref) => {});
  final StateProvider<bool> loadings = StateProvider((ref) => true);
  late TextEditingController schController;
  late TextEditingController degController;
  late TextEditingController majController;
  late TextEditingController startController;
  late TextEditingController endController;
  late TextEditingController descController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schController = TextEditingController();
    degController = TextEditingController();
    majController = TextEditingController();
    startController = TextEditingController();
    endController = TextEditingController();
    descController = TextEditingController(text: ' ');
    setupPage();
  }

  void setupPage() async {
    await futureAwait(duration: 1500, () {
      if(mounted) {
        ref.read(loadings.notifier).state = false;
        final provider = getEducationsDetailsProvider(ref, widget.id ?? '0');
        final experiences = ref.watch(provider);
        final datum = experiences.valueOrNull;
        if(datum != null) {
          schController.text = datum.school ?? '';
          degController.text = datum.degree?.title ?? '';
          majController.text = datum.major ?? '';
          startController.text = stringToString(date: '${datum.start_date ?? ''}', format: 'yyyy-MM') ?? '';
          endController.text = stringToString(date: '${datum.end_date ?? ''}', format: 'yyyy-MM') ?? '';
          descController.text = datum.description ?? ' ';

          (datum.toJson() ?? {}).forEach((key, value) {
            final val = value is Map ? value['id'] ?? value['value'] : value;
            switch(key) {
              case 'start_date':
              case 'end_date':
                final res = stringToString(date: '$value', format: 'yyyy-MM-dd') ?? '';
                updateNewMap(key, res);
                break;
              default:
                updateNewMap(key, val);
            }
          },);
        }
      }
    },);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = getEducationsDetailsProvider(ref, widget.id ?? '0');
    ref.watch(provider);
    final tmp = ref.watch(tmpMap);
    final tmpR = ref.read(tmpMap.notifier);

    double doubleHeight = 16;

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Educations', fontSize: 20, fontWeight: FontWeight.w500,),
        titleSpacing: 6,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNav(),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([

            if(ref.watch(loadings)) const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
            ) else Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [

                    forms.labelFormFields(
                      labelText: 'School *',
                      controller: schController,
                      onChanged: (val) => updateNewMap('school', val),
                      validator: ValidationBuilder().minLength(2).build(),
                    ),
                    SizedBox(height: doubleHeight,),

                    /// Degree ///
                    forms.labelFormFields(
                      labelText: 'Degree *',
                      readOnly: true,
                      controller: degController,
                      suffixIcon: degController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                        onPressed: () {
                          updateNewMap('degree', null);
                          setState(() {degController.text = '';});
                        },
                        tooltip: 'Clear',
                        icon: const Icon(Icons.close),
                      ),
                      onChanged: (val) => updateNewMap('degree', val),
                      validator: ValidationBuilder().required().build(),
                      onTap: () => showActionSheet(context, [
                        MoreTypeInfo('high-school', 'High School', null, null, () {
                          updateNewMap('degree', 'high-school');
                          setState(() {degController.text = 'High School';});
                        }),
                        MoreTypeInfo('associate', 'Associate', null, null, () {
                          updateNewMap('degree', 'associate');
                          setState(() {degController.text = 'Associate';});
                        }),
                        MoreTypeInfo('bachelor', 'Bachelor', null, null, () {
                          updateNewMap('degree', 'bachelor');
                          setState(() {degController.text = 'Bachelor';});
                        }),
                        MoreTypeInfo('master', 'Master', null, null, () {
                          updateNewMap('degree', 'master');
                          setState(() {degController.text = 'Master';});
                        }),
                        MoreTypeInfo('professional', 'Professional', null, null, () {
                          updateNewMap('degree', 'professional');
                          setState(() {degController.text = 'Professional';});
                        }),
                        MoreTypeInfo('doctor', 'Doctor', null, null, () {
                          updateNewMap('degree', 'doctor');
                          setState(() {degController.text = 'Doctor';});
                        }),
                      ]),
                    ),
                    SizedBox(height: doubleHeight,),

                    forms.labelFormFields(
                      labelText: 'Major *',
                      controller: majController,
                      onChanged: (val) => updateNewMap('major', val),
                      validator: ValidationBuilder().required().build(),
                    ),
                    SizedBox(height: doubleHeight,),

                    /// date ///
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label('I currently attend here : Year-Month', color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600),
                        const SizedBox(height: 8,),

                        Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: forms.labelFormFields( /// start date ///
                                labelText: 'Start *',
                                readOnly: true,
                                suffixIcon: startController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                                  onPressed: () {
                                    tmpR.state['tmp_stat_date'] = '';
                                    updateNewMap('start_date', '');
                                    setState(() {startController.text = '';});
                                  },
                                  tooltip: 'Clear',
                                  icon: const Icon(Icons.close),
                                ),
                                controller: startController,
                                validator: ValidationBuilder().required().build(),
                                onTap: () async {
                                  final res = await showBarModalBottomSheet(
                                    context: context,
                                    builder: (context) => DateOptions(ref: ref,
                                      tmpMap: tmpMap, keys: 'tmp_stat_date',
                                    ),
                                  );
                                  if(res != null) {
                                    final val = ref.watch(tmpMap);
                                    final value = '${val['tmp_stat_date'] ?? ''}';
                                    updateNewMap('start_date', '$value-01');
                                    setState(() {
                                      startController.text = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: doubleHeight),

                            Expanded(
                              child: forms.labelFormFields( /// end date ///
                                labelText: 'End',
                                readOnly: true,
                                enabled: (tmp['tmp_switch'] != 'true'),
                                suffixIcon: endController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                                  onPressed: () {
                                    tmpR.state['tmp_end_date'] = '';
                                    updateNewMap('end_date', '');
                                    setState(() {endController.text = '';});
                                  },
                                  tooltip: 'Clear',
                                  icon: const Icon(Icons.close),
                                ),
                                controller: endController,
                                onTap: () async {
                                  final res = await showBarModalBottomSheet(
                                    context: context,
                                    builder: (context) => DateOptions(ref: ref,
                                      tmpMap: tmpMap, keys: 'tmp_end_date',
                                    ),
                                  );
                                  if(res != null) {
                                    final val = ref.watch(tmpMap);
                                    final value = '${val['tmp_end_date'] ?? ''}';
                                    updateNewMap('end_date', '$value-01');
                                    setState(() {
                                      endController.text = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    CupertinoListTile(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                      title: labels.label('I currently attend her', color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600,),
                      trailing: CupertinoSwitch(
                        value: (tmp['tmp_switch'] == 'true'),
                        activeColor: config.primaryAppColor.shade600,
                        onChanged: (bool? value) {
                          setState(() {
                            tmpR.state['tmp_switch'] = '${value ?? false}';
                            if(value == true) {
                              tmpR.state['tmp_end_date'] = '';
                              updateNewMap('end_date', '');
                              endController.text = '';
                            }
                          });
                        },
                      ),
                    ),

                    forms.labelFormFields(
                      labelText: 'Description',
                      controller: descController,
                      onChanged: (val) => updateNewMap('description', val),
                      maxLines: 5,
                    ),
                    SizedBox(height: doubleHeight,),

                  ],
                ),
              ),
            ),

          ])),
        ],
      ),
    );
  }

  void updateNewMap(String key, dynamic val) {
    ref.read(newMap.notifier).update((state) {
      return {...state, key: val};
    });
    print(ref.watch(newMap));
  }

  Widget bottomNav() {
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
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = (constraints.maxWidth) * 0.32;
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: width,
                    child: buttons.textButtons(
                      title: 'Save',
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          final sendApi = EducationsApiService();
                          Map<String, dynamic> data = {};
                          ref.watch(newMap).forEach((key, value) {
                            data.addAll({ key: value });
                          },);
                          // print(data);
                          // return;
                          if(widget.id != null) { /// for submit update this educations ///
                            final result = await sendApi.addEducations(ref, data, eduId: widget.id);
                            if (result.status == 'success') {
                              alertSnack(context, result.message ?? 'Save successful.');
                              routeAnimation(context, pageBuilder: const CheckInfoResumePage());
                            }

                          } else { /// for submit create this educations ///
                            final result = await sendApi.addEducations(ref, data);
                            if (result.status == 'success') {
                              alertSnack(context, result.message ?? 'Save successful.');
                              routeAnimation(context, pageBuilder: const CheckInfoResumePage());
                            }

                          }

                        } else {
                          alertSnack(context, 'Please check validate again!.');

                        }
                      },
                      padSize: 10,
                      textSize: 18,
                      textWeight: FontWeight.w500,
                      textColor: Colors.white,
                      bgColor: config.warningColor.shade400,
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}


class DateOptions extends StatelessWidget {
  const DateOptions({super.key,
    required this.ref,
    required this.tmpMap,
    required this.keys,
  });

  final WidgetRef ref;
  final StateProvider<Map> tmpMap;
  final String keys;

  @override
  Widget build(BuildContext context) {
    final tmp = ref.watch(tmpMap);
    final tmpR = ref.read(tmpMap.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.tryParse(tmp[keys] ?? '') ?? DateTime.now(), // tryParse(dateFormat),
            mode: CupertinoDatePickerMode.monthYear,
            onDateTimeChanged: (DateTime value) {
              tmpR.state[keys] = stringToString(date: value.toString(), format: 'yyyy-MM') ?? '';
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: buttons.textButtons(
                  title: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                  padSize: 10,
                  textSize: 16,
                  textWeight: FontWeight.w500,
                  bgColor: Colors.black12,
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: buttons.textButtons(
                  title: 'Apply',
                  onPressed: () {
                    Navigator.pop(context, 'submit');
                  },
                  padSize: 10,
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
    );
  }
}





// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/jobs/my_resume/languages/languages_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../more_provider.dart';
import '../check_informations.dart';

final labels = Labels();
final config = Config();
final myCards = MyCards();
final forms = Forms();
final buttons = Buttons();

class LanguagesPage extends ConsumerStatefulWidget {
  const LanguagesPage({super.key,
    this.id,
  });

  final String? id;

  @override
  ConsumerState<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends ConsumerState<LanguagesPage> {
  final _formKey = GlobalKey<FormState>();
  final StateProvider<Map> newMap = StateProvider((ref) => {});
  final StateProvider<Map> tmpMap = StateProvider((ref) => {});
  final StateProvider<bool> loadings = StateProvider((ref) => true);
  late TextEditingController titleController;
  late TextEditingController valueController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    valueController = TextEditingController();
    setupPage();
  }

  void setupPage() async {
    await futureAwait(duration: 1500, () {
      if(mounted) {
        ref.read(loadings.notifier).state = false;
        final provider = getLanguagesDetailsProvider(ref, widget.id ?? '0');
        final experiences = ref.watch(provider);
        final datum = experiences.valueOrNull;
        if(datum != null) {
          titleController.text = datum.title ?? '';
          valueController.text = datum.level?.title ?? '';

          (datum.toJson() ?? {}).forEach((key, value) {
            final val = value is Map ? value['id'] ?? value['value'] : value;
            updateNewMap(key, val);
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
    final provider = getLanguagesDetailsProvider(ref, widget.id ?? '0');
    ref.watch(provider);

    double doubleHeight = 16;

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Languages', fontSize: 20, fontWeight: FontWeight.w500,),
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
                      labelText: 'Title *',
                      controller: titleController,
                      onChanged: (val) => updateNewMap('title', val),
                      validator: ValidationBuilder().required().build(),
                    ),
                    SizedBox(height: doubleHeight,),

                    /// Level ///
                    forms.labelFormFields(
                      labelText: 'Level *',
                      readOnly: true,
                      controller: valueController,
                      suffixIcon: valueController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                        onPressed: () {
                          updateNewMap('level', null);
                          setState(() {valueController.text = '';});
                        },
                        tooltip: 'Clear',
                        icon: const Icon(Icons.close),
                      ),
                      onChanged: (val) => updateNewMap('level', val),
                      validator: ValidationBuilder().required().build(),
                      onTap: () => showActionSheet(context, [
                        MoreTypeInfo('beginner', 'Beginner', null, null, () {
                          updateNewMap('level', 'beginner');
                          setState(() {valueController.text = 'Beginner';});
                        }),
                        MoreTypeInfo('intermediate', 'Intermediate', null, null, () {
                          updateNewMap('level', 'intermediate');
                          setState(() {valueController.text = 'Intermediate';});
                        }),
                        MoreTypeInfo('advanced', 'Advanced', null, null, () {
                          updateNewMap('level', 'advanced');
                          setState(() {valueController.text = 'Advanced';});
                        }),
                        MoreTypeInfo('native', 'Native', null, null, () {
                          updateNewMap('level', 'native');
                          setState(() {valueController.text = 'Native';});
                        }),
                      ]),
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
                          final sendApi = LanguagesApiService();
                          Map<String, dynamic> data = {};
                          ref.watch(newMap).forEach((key, value) {
                            data.addAll({ key: value });
                          },);
                          // print(data);
                          // return;
                          if(widget.id != null) { /// for submit update this skills ///
                            final result = await sendApi.addLanguages(ref, data, lanId: widget.id);
                            if (result.status == 'success') {
                              alertSnack(context, result.message ?? 'Save successful.');
                              Navigator.pop(context);
                              routePopAndPush(context, pageBuilder: const CheckInfoResumePage());
                            }

                          } else { /// for submit create this skills ///
                            final result = await sendApi.addLanguages(ref, data);
                            if (result.status == 'success') {
                              alertSnack(context, result.message ?? 'Save successful.');
                              Navigator.pop(context);
                              routePopAndPush(context, pageBuilder: const CheckInfoResumePage());
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




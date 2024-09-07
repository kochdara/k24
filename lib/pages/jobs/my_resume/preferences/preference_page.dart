
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/jobs/my_resume/preferences/preference_provider.dart';
import 'package:k24/pages/listing/sub_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/filters/provinces.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../more_provider.dart';
import '../check_informations.dart';

final labels = Labels();
final config = Config();
final myCards = MyCards();
final forms = Forms();
final buttons = Buttons();

class PreferencesPage extends ConsumerStatefulWidget {
  const PreferencesPage({super.key});

  @override
  ConsumerState<PreferencesPage> createState() => _PreferenceState();
}

class _PreferenceState extends ConsumerState<PreferencesPage> {
  final _formKey = GlobalKey<FormState>();
  final StateProvider<Map> newMap = StateProvider((ref) => {});
  final StateProvider<Map> tmpMap = StateProvider((ref) => {});
  final StateProvider<bool> loadings = StateProvider((ref) => true);
  late TextEditingController posController;
  late TextEditingController catController;
  late TextEditingController locController;
  late TextEditingController typController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posController = TextEditingController();
    catController = TextEditingController();
    locController = TextEditingController();
    typController = TextEditingController();
    setupPage();
  }

  void setupPage() async {
    await futureAwait(duration: 1500, () {
      ref.read(loadings.notifier).state = false;
      if(mounted) {
        final provider = getPreferenceProvider(ref);
        final summary = ref.watch(provider);
        final datum = summary.valueOrNull;
        if(datum != null) {
          posController.text = datum.position ?? '';
          (datum.toJson() ?? {}).forEach((key, value) {
            if(value is List) {
              String oldTitle = '';
              String oldVal = '';
              for (final valData in value) {
                final title = valData is Map ? valData['en_name'] ?? valData['title'] : valData;
                final val = valData is Map ? valData['id'] ?? valData['value'] : valData;

                // Add the comma and space only if oldTitle or oldVal is not empty
                if (oldTitle.isNotEmpty) oldTitle += ', ';
                if (oldVal.isNotEmpty) oldVal += ',';

                oldTitle += title;
                oldVal += val;
              }
              if(key == 'category') catController.text = oldTitle;
              if(key == 'location') locController.text = oldTitle;
              if(key == 'job_type') typController.text = oldTitle;
              updateNewMap(key, oldVal);
            } else {
              updateNewMap(key, value);
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
    final provider = getPreferenceProvider(ref);
    final summary = ref.watch(provider);

    final tmp = ref.watch(newMap);

    double doubleHeight = 18;

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Job Preferences', fontSize: 20, fontWeight: FontWeight.w500,),
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
            ) else summary.when(
              error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
              loading: () => const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
              ),
              data: (data) {
                return Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400, width: 1.0), // Add border here
                            borderRadius: BorderRadius.circular(6.0), // Optionally add border radius
                          ),
                          child: CupertinoListTile(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            title: labels.label('Open Job', color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500,),
                            trailing: Transform.scale(
                              scale: 0.85,
                              child: CupertinoSwitch(
                                value: (tmp['open_job'].toString() == 'true'),
                                activeColor: config.primaryAppColor.shade600,
                                onChanged: (bool? value) {
                                  setState(() {
                                    updateNewMap('open_job', '${value ?? false}');
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: doubleHeight,),

                        forms.labelFormFields(
                          labelText: 'Category *',
                          suffixIcon: catController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                            onPressed: () {
                              updateNewMap('category', null);
                              setState(() {catController.text = '';});
                            },
                            tooltip: 'Clear',
                            icon: const Icon(Icons.close),
                          ),
                          controller: catController,
                          readOnly: true,
                          validator: ValidationBuilder().required().build(),
                          onTap: () async {
                            await showBarModalBottomSheet(context: context,
                              builder: (context) => LocationPicker(
                                newMap: newMap,
                                controller: catController,
                                keys: 'category',
                              ),
                            );
                          }
                        ),
                        SizedBox(height: doubleHeight,),

                        forms.labelFormFields(
                          labelText: 'Location *',
                          suffixIcon: locController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                            onPressed: () {
                              updateNewMap('location', null);
                              setState(() {locController.text = '';});
                            },
                            tooltip: 'Clear',
                            icon: const Icon(Icons.close),
                          ),
                          controller: locController,
                          readOnly: true,
                          validator: ValidationBuilder().required().build(),
                          onTap: () async {
                            await showBarModalBottomSheet(context: context,
                              builder: (context) => LocationPicker(
                                newMap: newMap,
                                controller: locController,
                                keys: 'location',
                              ),
                            );
                          }
                        ),
                        SizedBox(height: doubleHeight,),

                        forms.labelFormFields(
                          labelText: 'Preferences Position *',
                          controller: posController,
                          onChanged: (val) => updateNewMap('position', val),
                          validator: ValidationBuilder().required().build(),
                        ),
                        SizedBox(height: doubleHeight,),

                        forms.labelFormFields(
                          labelText: 'Job Type',
                          suffixIcon: typController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                            onPressed: () {
                              updateNewMap('job_type', null);
                              setState(() {typController.text = '';});
                            },
                            tooltip: 'Clear',
                            icon: const Icon(Icons.close),
                          ),
                          readOnly: true,
                          controller: typController,
                          onTap: () async {
                            await showCupertinoModalPopup<void>(
                              context: ref.context,
                              builder: (BuildContext context) => JobTypePicker(newMap: newMap,
                                typController: typController,
                              ),
                            );
                          }
                        ),
                        SizedBox(height: doubleHeight,),

                      ],
                    ),
                  ),
                );
              }
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
                          final sendApi = PreferenceApiService();
                          Map<String, dynamic> data = {};
                          ref.watch(newMap).forEach((key, value) {
                            data.addAll({ key: value });
                          },);
                          // print(data);
                          // return;
                          final result = await sendApi.submitPreference(ref, data);
                          if(result?.status == 'success') {
                            alertSnack(context, result?.message ?? 'Save successful.');
                            Navigator.pop(context);
                            routePopAndPush(context, pageBuilder: const CheckInfoResumePage());
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


class JobTypePicker extends ConsumerWidget {
  JobTypePicker({super.key,
    required this.newMap,
    required this.typController,
  });

  final StateProvider<Map> newMap;
  final TextEditingController typController;

  final List<MoreTypeInfo> listDat = [ // full-time,part-time,internships,freelance,contract,volunteer
    MoreTypeInfo('full-time', 'Full-Time', null, null, () { }),
    MoreTypeInfo('part-time', 'Part-Time', null, null, () { }),
    MoreTypeInfo('internships', 'Internships', null, null, () { }),
    MoreTypeInfo('freelance', 'Freelance', null, null, () { }),
    MoreTypeInfo('contract', 'Contract', null, null, () { }),
    MoreTypeInfo('volunteer', 'Volunteer', null, null, () { }),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tmp = ref.watch(newMap);
    String jobType = tmp['job_type'] ?? '';

    return CupertinoActionSheet(
      actions: <CupertinoActionSheetAction>[
        for(final val in listDat) CupertinoActionSheetAction(
          onPressed: () {
            ref.read(newMap.notifier).update((state) {
              if((tmp['job_type'] ?? '').toString().contains(val.name)) {
                String con = typController.text.replaceAll(val.description, '');
                String job = jobType.replaceAll(val.name, '');

                if (job.startsWith(',')) job = job.substring(1);
                if (con.startsWith(', ')) con = con.substring(2);

                if (job.endsWith(',')) job = job.substring(0, job.length - 1);
                if (con.endsWith(', ')) con = con.substring(0, con.length - 2);

                typController.text = con;
                return {...state, 'job_type': job};
              } else {
                if(jobType.isNotEmpty) {
                  jobType += ',';
                  typController.text += ', ';
                }
                jobType += val.name;
                typController.text += val.description;
                return {...state, 'job_type': jobType};
              }
            },);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labels.label(
                  val.description,
                  color: (tmp['job_type'] ?? '').toString().contains(val.name) ? Colors.blue.shade700 : Colors.black54,
                  fontSize: 17, fontWeight: FontWeight.w600,
                ),
                Icon(
                  (tmp['job_type'] ?? '').toString().contains(val.name) ?
                  Icons.check_circle : Icons.circle_outlined,
                  color: (tmp['job_type'] ?? '').toString().contains(val.name) ? Colors.blue.shade700 : Colors.black54,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {Navigator.pop(context);},
        isDestructiveAction: true,
        child: labels.label('Cancel', color: Colors.red, fontSize: 17, fontWeight: FontWeight.w600),
      ),
    );
  }
}


class LocationPicker extends ConsumerWidget {
  const LocationPicker({super.key,
    required this.newMap,
    required this.controller,
    this.keys,
  });

  final StateProvider<Map> newMap;
  final TextEditingController controller;
  final String? keys;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = getLocationProvider('province', '');
    final provider2 = getMainCategoryProvider('jobs');
    final getLocations = ref.watch(provider);
    final getMain = ref.watch(provider2);

    final tmp = ref.watch(newMap);
    String jobType = tmp[keys] ?? '';
    List<String> list = jobType.isNotEmpty ? jobType.split(',') : [];

    int keyLength = 0;
    String title = 'Unknown';
    switch(keys) {
      case 'category':
        keyLength = 6;
        title = 'Category';
        break;
      default:
        keyLength = 3;
        title = 'City/Province';
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: config.secondaryColor.shade50,
        surfaceTintColor: config.secondaryColor.shade50,
        leading: IconButton(onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black54, size: 28,),
        ),
        titleSpacing: 0,
        title: ListTile(
          title: labels.label(title, color: Colors.black87, fontSize: 17, fontWeight: FontWeight.w600,textAlign: TextAlign.center,),
          subtitle: labels.label('You are selected: ${list.length}/$keyLength', color: Colors.black54, fontSize: 12,textAlign: TextAlign.center,),
        ),
        actions: [
          IconButton(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 16.0),
            onPressed: () {
            controller.text = '';
            ref.read(newMap.notifier).update((state) {
              return { ...state, ...{ keys: null } };
            });
          }, icon: labels.label('Reset', color: Colors.blue.shade600, fontSize: 14,textAlign: TextAlign.center,fontWeight: FontWeight.w600,)),
        ],
      ),
      backgroundColor: config.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          /// for category ///
          child: (keys == 'category') ? getMain.when(
            error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
            loading: () => const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
            ),
           data: (data) {
             return Column(
               children: [
                 for(final datum in data) ...[
                   ListTile(
                     dense: true,
                     horizontalTitleGap: 8,
                     shape: const Border(top: BorderSide(color: Colors.black12,),),
                     leading: Icon(
                       (tmp[keys] ?? '').toString().contains('${datum.id}') ? Icons.check_circle : Icons.circle_outlined,
                       size: 16,
                       color: (tmp[keys] ?? '').toString().contains('${datum.id}') ? Colors.blue.shade700 : Colors.black54,
                     ),
                     title: labels.label(datum.en_name ?? 'N/A', color: Colors.black87, fontSize: 15, ),
                     onTap: () {
                       ref.read(newMap.notifier).update((state) {
                         if((tmp[keys] ?? '').toString().contains('${datum.id}')) {
                           String con = controller.text.replaceAll('${datum.en_name}', '');
                           String cate = jobType.replaceAll('${datum.id}', '');

                           if (cate.startsWith(',')) cate = cate.substring(1);
                           if (con.startsWith(', ')) con = con.substring(2);

                           if (cate.endsWith(',')) cate = cate.substring(0, cate.length - 1);
                           if (con.endsWith(', ')) con = con.substring(0, con.length - 2);

                           controller.text = con;
                           return {...state, keys: cate};

                         } else {
                           if(list.length > (keyLength - 1)) return {...state};
                           if(jobType.isNotEmpty) {
                             jobType += ',';
                             controller.text += ', ';
                           }
                           jobType += datum.id ?? '';
                           controller.text += datum.en_name ?? '';
                           return {...state, keys: jobType};

                         }
                       },);
                     },
                   ),
                 ],
               ],
             );
           },

           /// for locations ///
         ) : getLocations.when(
           error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
           loading: () => const SizedBox(
             height: 250,
             child: Center(child: CircularProgressIndicator()),
           ),
           data: (data) {

             return Column(
               children: [
                 for(final datum in data) ...[
                   Builder(
                     builder: (context) {
                       final fieldData = Province.fromJson(datum ?? {});

                       return ListTile(
                         dense: true,
                         horizontalTitleGap: 8,
                         shape: const Border(top: BorderSide(color: Colors.black12,),),
                         leading: Icon(
                           (tmp[keys] ?? '').toString().contains('${fieldData.id}') ? Icons.check_circle : Icons.circle_outlined,
                           size: 16,
                           color: (tmp[keys] ?? '').toString().contains('${fieldData.id}') ? Colors.blue.shade700 : Colors.black54,
                         ),
                         title: labels.label(fieldData.en_name ?? 'N/A', color: Colors.black87, fontSize: 15, ),
                         onTap: () {
                           ref.read(newMap.notifier).update((state) {
                             if((tmp[keys] ?? '').toString().contains('${fieldData.id}')) {
                               String con = controller.text.replaceAll('${fieldData.en_name}', '');
                               String loc = jobType.replaceAll('${fieldData.id}', '');

                               if (loc.startsWith(',')) loc = loc.substring(1);
                               if (con.startsWith(', ')) con = con.substring(2);

                               if (loc.endsWith(',')) loc = loc.substring(0, loc.length - 1);
                               if (con.endsWith(', ')) con = con.substring(0, con.length - 2);

                               controller.text = con;
                               return {...state, keys: loc};

                             } else {
                               if(list.length > (keyLength - 1)) return {...state};
                               if(jobType.isNotEmpty) {
                                 jobType += ',';
                                 controller.text += ', ';
                               }
                               jobType += fieldData.id ?? '';
                               controller.text += fieldData.en_name ?? '';
                               return {...state, keys: jobType};

                             }
                           },);
                         },
                       );
                     }
                   ),
                 ],
               ],
             );
           },
         ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: buttons.textButtons(
          title: 'Finish',
          onPressed: () {
            Navigator.pop(context);
          },
          padSize: 10,
          textSize: 18,
          textWeight: FontWeight.w500,
          textColor: Colors.white,
          bgColor: config.warningColor.shade400,
        ),
      ),
    );
  }
}




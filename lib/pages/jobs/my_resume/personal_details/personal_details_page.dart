
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/edit_profile/edit_page.dart';
import 'package:k24/pages/jobs/my_resume/check_informations.dart';
import 'package:k24/pages/jobs/my_resume/personal_details/personal_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

final myWidgets = MyWidgets();
final labels = Labels();
final config = Config();
final myCards = MyCards();
final buttons = Buttons();

class PersonalsDataPage extends ConsumerStatefulWidget {
  const PersonalsDataPage({super.key});

  @override
  ConsumerState<PersonalsDataPage> createState() => _PersonalsDataPageState();
}

class _PersonalsDataPageState extends ConsumerState<PersonalsDataPage> {
  final _formKey = GlobalKey<FormState>();
  final StateProvider<Map> newMap = StateProvider((ref) => {});
  final StateProvider<Map> tmpMap = StateProvider((ref) => {});
  late StateProvider<bool> loading;
  late TextEditingController fnController;
  late TextEditingController lnController;
  late TextEditingController yrController;
  late TextEditingController natController;
  late TextEditingController emController;
  late TextEditingController ph1Controller;
  late TextEditingController ph2Controller;
  late TextEditingController ph3Controller;
  late TextEditingController locController;
  late TextEditingController addController;
  late TextEditingController eduController;
  late TextEditingController posController;
  late TextEditingController expController;

  @override
  void initState() {
    super.initState();
    fnController = TextEditingController();
    lnController = TextEditingController();
    yrController = TextEditingController();
    natController = TextEditingController();
    emController = TextEditingController();
    ph1Controller = TextEditingController();
    ph2Controller = TextEditingController();
    ph3Controller = TextEditingController();
    locController = TextEditingController();
    addController = TextEditingController();
    eduController = TextEditingController();
    posController = TextEditingController();
    expController = TextEditingController();
    loading = StateProvider((ref) => true);
    setupPage();
  }

  void setupPage() async {
    await futureAwait(duration: 1500, () {
      if(mounted) {
        final provider = getPersonalDetailsProvider(ref);
        final personData = ref.watch(provider);
        final datum = personData.valueOrNull;
        if(personData.hasValue) {
          fnController.text = datum?.first_name ?? '';
          lnController.text = datum?.last_name ?? '';
          natController.text = datum?.nationality ?? '';
          yrController.text = datum?.dob ?? '';
          emController.text = datum?.email ?? '';
          for(int ind=0; ind<(datum?.phone ?? []).length; ind++) {
            if(ind == 0) ph1Controller.text = datum!.phone?[ind] ?? '';
            if(ind == 1) ph2Controller.text = datum!.phone?[ind] ?? '';
            if(ind == 2) ph3Controller.text = datum!.phone?[ind] ?? '';
          }
          locController.text = datum?.location?.long_location ?? '';
          addController.text = datum?.address ?? '';
          eduController.text = datum?.education_level?.title ?? '';
          posController.text = datum?.position ?? '';
          expController.text = datum?.work_experience ?? '';

          (datum?.toJson() ?? {}).forEach((key, value) {
            final val = (value is Map) ? (value['id'] ?? value['value'] ?? value) : value;
            if(key == 'phone') {
              for(int ind=0; ind<(value ?? []).length; ind++) {
                updateNewMap('phone[$ind]', value[ind]);
              }
            } else { updateNewMap(key, val); }
          },);
        }

        loading = StateProvider((ref) => false);
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    final oldMap = ref.watch(newMap);
    final tmp = ref.watch(tmpMap);
    final tmpR = ref.read(tmpMap.notifier);

    final provider = getPersonalDetailsProvider(ref);
    final personalData = ref.watch(provider);

    double doubleHeight = 15;

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Personal Information', fontSize: 20, fontWeight: FontWeight.w500),
        titleSpacing: 6,
      ),
      backgroundColor: config.backgroundColor,
      bottomNavigationBar: bottomNav(),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([

            if(ref.watch(loading)) const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
            ) else personalData.when(
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

                        /// photo first name and last name ///
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () => (oldMap['photo'] != null) ? showActionSheet(context, [
                                    MoreTypeInfo('view', 'View', null, null, () => viewImage(context, '${oldMap['photo']['url']}')),
                                    MoreTypeInfo('change', 'Change', null, null, () => imagePicker1()),
                                    MoreTypeInfo('remove', 'Remove', null, null, () {
                                      updateNewMap('photo', null);
                                    }),
                                  ]) : imagePicker1(),
                                  child: SizedBox(
                                    height: 130,
                                    width: 100,
                                    child: (oldMap['photo'] != null) ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: placeholder,
                                        image: '${oldMap['photo']['url']}',
                                        fit: BoxFit.cover,
                                      ),
                                    ) : Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.person, color: Colors.black54, size: 40,),
                                          labels.label('4 x 6', fontSize: 14, color: Colors.black54),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: IconButton(
                                    onPressed: () => imagePicker1(),
                                    visualDensity: VisualDensity.compact,
                                    padding: EdgeInsets.zero,
                                    tooltip: 'Edit Profile',
                                    icon: Icon(CupertinoIcons.pencil_circle_fill, color: config.primaryAppColor.shade600, size: 24,),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 18,),

                            Expanded(
                              child: Column(
                                children: [
                                  forms.labelFormFields(
                                    labelText: 'First Name *',
                                    controller: fnController,
                                    onChanged: (val) => updateNewMap('first_name', val),
                                    validator: ValidationBuilder().required().build(),
                                  ),
                                  const SizedBox(height: 18,),

                                  forms.labelFormFields(
                                    labelText: 'Last Name *',
                                    controller: lnController,
                                    onChanged: (val) => updateNewMap('last_name', val),
                                    validator: ValidationBuilder().required().build(),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: doubleHeight,),

                        /// gender ///
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labels.label('Gender', color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600),
                            const SizedBox(height: 4,),

                            Flex(
                              direction: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: buttons.textButtons(
                                    title: 'Male',
                                    onPressed: () => updateNewMap('gender', 'm'),
                                    padding: const EdgeInsets.symmetric(vertical: 13),
                                    textSize: 13,
                                    bgColor: (oldMap['gender'] == 'm') ? config.infoColor.shade50: Colors.white,
                                    borderColor: (oldMap['gender'] == 'm') ? config.infoColor.shade300: config.secondaryColor.shade100,
                                  ),
                                ),
                                SizedBox(width: doubleHeight),

                                Expanded(
                                  child: buttons.textButtons(
                                    title: 'Female',
                                    onPressed: () => updateNewMap('gender', 'f'),
                                    padding: const EdgeInsets.symmetric(vertical: 13),
                                    textSize: 13,
                                    bgColor: (oldMap['gender'] == 'f') ? config.infoColor.shade50 : Colors.white,
                                    borderColor: (oldMap['gender'] == 'f') ? config.infoColor.shade300 : config.secondaryColor.shade100,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: doubleHeight,),

                        /// date of birth ///
                        forms.labelFormFields(
                          labelText: 'Date of Birth *',
                          readOnly: true,
                          suffixIcon: yrController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                            onPressed: () {
                              tmpR.state['tmp_date'] = '';
                              setState(() {yrController.text = '';});
                            },
                            tooltip: 'Clear',
                            icon: const Icon(Icons.close),
                          ),
                          controller: yrController,
                          onChanged: (val) { },
                          validator: ValidationBuilder().required().build(),
                          onTap: () async {
                            await showBarModalBottomSheet(
                              context: context,
                              builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 250,
                                    width: double.infinity,
                                    child: CupertinoDatePicker(
                                      initialDateTime: DateTime.tryParse(tmp['tmp_date'] ?? '') ?? DateTime.now(), // tryParse(dateFormat),
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (DateTime value) {
                                        tmpR.state['tmp_date'] = stringToString(date: value.toString(), format: 'yyyy-MM-dd') ?? '';
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
                                              String val = tmp['tmp_date'] ?? '';
                                              updateNewMap('dob', val);
                                              setState(() {
                                                yrController.text = val;
                                              });
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
                              ),
                            );
                          },
                        ),
                        SizedBox(height: doubleHeight,),

                        /// nationality ///
                        forms.labelFormFields(
                          labelText: 'Nationality',
                          controller: natController,
                          onChanged: (val) => updateNewMap('nationality', val),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// email ///
                        forms.labelFormFields(
                          labelText: 'Email',
                          controller: emController,
                          onChanged: (val) => updateNewMap('email', val),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// phone 1 ///
                        forms.labelFormFields(
                          labelText: 'Phone Number 1 *',
                          controller: ph1Controller,
                          onChanged: (val) => updateNewMap('phone[0]', val),
                          validator: ValidationBuilder().required().build(),
                          keyboardType: const TextInputType.numberWithOptions(),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// phone 2 ///
                        forms.labelFormFields(
                          labelText: 'Phone Number 2',
                          controller: ph2Controller,
                          onChanged: (val) => updateNewMap('phone[1]', val),
                          keyboardType: const TextInputType.numberWithOptions(),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// phone 3 ///
                        forms.labelFormFields(
                          labelText: 'Phone Number 3',
                          controller: ph3Controller,
                          onChanged: (val) => updateNewMap('phone[2]', val),
                          keyboardType: const TextInputType.numberWithOptions(),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// locations ///
                        forms.labelFormFields(
                          labelText: 'Location',
                          readOnly: true,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          controller: locController,
                          onChanged: (val) => updateNewMap('location', val),
                          onTap: () async {
                            final result = await showBarModalBottomSheet(
                              context: context,
                              builder: (context) => ProvinceFilters(newMap: newMap,),
                            );
                            if(result != null) {
                              final resultSet = ref.watch(newMap);
                              setState(() {
                                String province = getNestedValue(resultSet, 'province');
                                String district = getNestedValue(resultSet, 'district');
                                String commune = getNestedValue(resultSet, 'commune');
                                locController.text = province;
                                if(district.isNotEmpty) locController.text += ', $district';
                                if(commune.isNotEmpty) locController.text += ', $commune';
                              });
                            }
                          },
                        ),
                        SizedBox(height: doubleHeight,),

                        /// address ///
                        forms.labelFormFields(
                          labelText: 'Address',
                          controller: addController,
                          onChanged: (val) => updateNewMap('address', val),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// Education ///
                        forms.labelFormFields(
                          labelText: 'Education Level',
                          readOnly: true,
                          controller: eduController,
                          suffixIcon: eduController.text.isEmpty ? const Icon(Icons.arrow_drop_down) : IconButton(
                            onPressed: () {
                              updateNewMap('education_level', null);
                              setState(() {eduController.text = '';});
                            },
                            tooltip: 'Clear',
                            icon: const Icon(Icons.close),
                          ),
                          onChanged: (val) => updateNewMap('education_level', val),
                          onTap: () => showActionSheet(context, [
                            MoreTypeInfo('high-school', 'High School', null, null, () {
                              updateNewMap('education_level', 'high-school');
                              setState(() {eduController.text = 'High School';});
                            }),
                            MoreTypeInfo('associate', 'Associate', null, null, () {
                              updateNewMap('education_level', 'associate');
                              setState(() {eduController.text = 'Associate';});
                            }),
                            MoreTypeInfo('bachelor', 'Bachelor', null, null, () {
                              updateNewMap('education_level', 'bachelor');
                              setState(() {eduController.text = 'Bachelor';});
                            }),
                            MoreTypeInfo('master', 'Master', null, null, () {
                              updateNewMap('education_level', 'master');
                              setState(() {eduController.text = 'Master';});
                            }),
                            MoreTypeInfo('professional', 'Professional', null, null, () {
                              updateNewMap('education_level', 'professional');
                              setState(() {eduController.text = 'Professional';});
                            }),
                            MoreTypeInfo('doctor', 'Doctor', null, null, () {
                              updateNewMap('education_level', 'doctor');
                              setState(() {eduController.text = 'Doctor';});
                            }),
                          ]),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// Positions ///
                        forms.labelFormFields(
                          labelText: 'Current Position',
                          controller: posController,
                          onChanged: (val) => updateNewMap('position', val),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// Work Experience ///
                        forms.labelFormFields(
                          labelText: 'Year of Experience',
                          controller: expController,
                          onChanged: (val) => updateNewMap('work_experience', val),
                          keyboardType: const TextInputType.numberWithOptions(),
                        ),
                        SizedBox(height: doubleHeight,),

                        /// marital status ///
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labels.label('Marital Status', color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600),
                            const SizedBox(height: 4,),

                            Flex(
                              direction: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: buttons.textButtons(
                                    title: 'Single',
                                    onPressed: () => updateNewMap('marital_status', 'single'),
                                    padding: const EdgeInsets.symmetric(vertical: 13),
                                    textSize: 13,
                                    bgColor: (oldMap['marital_status'] == 'single') ? config.infoColor.shade50: Colors.white,
                                    borderColor: (oldMap['marital_status'] == 'single') ? config.infoColor.shade300: config.secondaryColor.shade100,
                                  ),
                                ),
                                SizedBox(width: doubleHeight),

                                Expanded(
                                  child: buttons.textButtons(
                                    title: 'Married',
                                    onPressed: () => updateNewMap('marital_status', 'married'),
                                    padding: const EdgeInsets.symmetric(vertical: 13),
                                    textSize: 13,
                                    bgColor: (oldMap['marital_status'] == 'married') ? config.infoColor.shade50 : Colors.white,
                                    borderColor: (oldMap['marital_status'] == 'married') ? config.infoColor.shade300 : config.secondaryColor.shade100,
                                  ),
                                ),
                                SizedBox(width: doubleHeight),

                                Expanded(
                                  child: buttons.textButtons(
                                    title: 'Divorced',
                                    onPressed: () => updateNewMap('marital_status', 'divorced'),
                                    padding: const EdgeInsets.symmetric(vertical: 13),
                                    textSize: 13,
                                    bgColor: (oldMap['marital_status'] == 'divorced') ? config.infoColor.shade50 : Colors.white,
                                    borderColor: (oldMap['marital_status'] == 'divorced') ? config.infoColor.shade300 : config.secondaryColor.shade100,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),

          ])),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> imagePicker1() async {
    final uploadImg = PersonalApiService();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final xFiles = result.files.first.xFile;
      final multipartImage = MultipartFile.fromFileSync(xFiles.path, filename: xFiles.name);
      final res = await uploadImg.uploadProfile({
        "file": multipartImage,
      }, ref);
      if(res.status == 'success') {
        updateNewMap('photo', {
          'url': res.thumbnail,
          ...(res.toJson())
        });
      }
    }
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
                          final sendApi = PersonalApiService();
                          Map<String, dynamic> data = {};
                          ref.watch(newMap).forEach((key, value) {
                            switch(key) {
                              case 'photo':
                                if(value == null) {
                                  data.addAll({ 'photo': null }); /// if click remove photo ///
                                } else if(value is Map && value['type'] != null) {
                                  data.addAll({ 'photo': value['file']}); /// if map have type_of_image is upload new ///
                                }
                                break;
                              case 'province':
                              case 'district':
                              case 'commune':
                                if(value is Map) data.addAll({ 'location': value['id'] });
                                break;
                              default:
                                data.addAll({ key: value });
                            }
                          },);
                          final result = await sendApi.submitPersonal(ref, data);
                          if(result.status == 'success') {
                            alertSnack(context, result.message ?? 'Save successful.');
                            Navigator.pop(context);
                            routePopAndPush(context, pageBuilder: const CheckInfoResumePage());
                          }
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






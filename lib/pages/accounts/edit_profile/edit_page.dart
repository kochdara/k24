
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
import 'package:k24/pages/accounts/edit_profile/editpage_provider.dart';
import 'package:k24/pages/listing/sub_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/filters/provinces.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


final labels = Labels();
final config = Config();
final forms = Forms();
final myCards = MyCards();
final buttons = Buttons();
final myWidgets = MyWidgets();

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final StateProvider<Map> newMap = StateProvider((ref) => {});
  final StateProvider<bool> hiddenPro = StateProvider((ref) => false);
  final StateProvider<bool> loadingPro = StateProvider((ref) => true);
  final StateProvider<bool> valuePro = StateProvider((ref) => false);
  late TextEditingController fnController;
  late TextEditingController lnController;
  late TextEditingController yrController;
  late TextEditingController cmController;
  late TextEditingController emController;
  late TextEditingController ph1Controller;
  late TextEditingController ph2Controller;
  late TextEditingController ph3Controller;
  late TextEditingController locController;
  late TextEditingController addController;
  String dateFormat = '';
  final uploadData = Provider((ref) => RestAPIService());

  @override
  void initState() {
    super.initState();

    fnController = TextEditingController();
    lnController = TextEditingController();
    yrController = TextEditingController();
    cmController = TextEditingController();
    emController = TextEditingController();
    ph1Controller = TextEditingController();
    ph2Controller = TextEditingController();
    ph3Controller = TextEditingController();
    locController = TextEditingController();
    addController = TextEditingController();

    futureAwait(duration: 1000, () async {
      if(!mounted) return;
      ref.read(loadingPro.notifier).state = true;
      final userPro = ref.watch(editProfileProvider(ref));
      final value = userPro.valueOrNull;
      (value?.toJson() ?? {}).forEach((key, value) {
        if(value is String || value is bool) {
          if(key == 'dob') {
            updateNewMap(ref, key, stringToString(date: '$value', format: 'yyyy-MM-dd') ?? '');
          } else {
            updateNewMap(ref, key, value);
          }

          // for contact //
        } else if(value is Map && key == 'contact') {
          value.forEach((key, value) {
            if(value is List) {
              for(int v=0; v<value.length; v++) {
                updateNewMap(ref, 'phone[$v]', value[v]);
              }
            } else if(value is Map) {
              updateNewMap(ref, key, value);
            } else {
              updateNewMap(ref, key, value);
            }
          });
        }
      });

      if (fnController.text != value?.first_name) fnController.text = value?.first_name ?? '';
      if (lnController.text != value?.last_name) lnController.text = value?.last_name ?? '';
      String date = stringToString(date: '${value?.dob.toString()}', format: 'yyyy-MM-dd') ?? '';
      dateFormat = date;
      if (yrController.text != dateFormat) yrController.text = dateFormat;
      if (cmController.text != value?.company) cmController.text = value?.company ?? '';
      if (emController.text != value?.contact?.email) emController.text = value?.contact?.email ?? '';
      List phones = value?.contact?.phone ?? [];
      if (phones.isNotEmpty) ph1Controller.text = phones[0] ?? '';
      if (phones.length > 1) ph2Controller.text = phones[1] ?? '';
      if (phones.length > 2) ph3Controller.text = phones[2] ?? '';
      if (value?.contact?.location != null) locController.text = value?.contact?.location?.en_name ?? '';
      if (value?.contact?.district != null) locController.text += ', ${value?.contact?.district?.en_name ?? ''}';
      if (value?.contact?.commune != null) locController.text += ', ${value?.contact?.commune?.en_name ?? ''}';
      if (addController.text != value?.contact?.address) addController.text = value?.contact?.address ?? '';
      ref.read(loadingPro.notifier).state = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    fnController.dispose();
    lnController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hidden = ref.watch(hiddenPro);
    final rHidden = ref.read(hiddenPro.notifier);
    final resultSet = ref.watch(newMap);
    final uploadImg = ref.watch(uploadData);

    final provider = editProfileProvider(ref);
    final userPro = ref.watch(provider);
    final editData = userPro.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Edit Profile', fontSize: 20, fontWeight: FontWeight.w500),
        titleSpacing: 6,
      ),
      backgroundColor: config.backgroundColor,
      body: CustomScrollView(
        slivers: [
          /// body //
          SliverList(
            delegate: SliverChildListDelegate([

              if(ref.watch(loadingPro)) Container(
                height: 250,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ) else Column(
                children: [
                  // stack photo profile //
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      // cover of image
                      Column(
                        children: [
                          InkWell(
                            onTap: () => showActionSheet(context, [
                              if(editData?.cover?.url != null) MoreTypeInfo('view', 'view', CupertinoIcons.eye, null, () => viewImage(context, '${editData?.cover?.url}')),
                              MoreTypeInfo('change', 'Change', CupertinoIcons.pencil_circle, null, () {
                                imagePicker1('upload_cover', provider);
                              }),
                            ]),
                            child: Container(
                              color: config.primaryAppColor.shade600,
                              height: 200,
                              width: double.infinity,
                              child: (editData?.cover?.url != null) ? FadeInImage.assetNetwork(
                                placeholder: placeholder,
                                image: editData?.cover?.url ?? '',
                                fit: BoxFit.cover,
                              ) : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.camera_alt, color: Colors.white, size: 20,),
                                  const SizedBox(width: 8,),
                                  labels.label('Add cover photo', fontSize: 16,),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 60,),
                        ],
                      ),
                      // profile image
                      Positioned(
                        bottom: 10,
                        child: InkWell(
                          onTap: () => showActionSheet(context, [
                            if(editData?.photo?.url != null) MoreTypeInfo('view', 'view', CupertinoIcons.eye, null, () => viewImage(context, '${editData?.photo?.url}')),
                            MoreTypeInfo('change', 'Change', CupertinoIcons.pencil_circle, null, () {
                              imagePicker1('upload_profile', provider);
                            }),
                          ]),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: config.secondaryColor.shade100,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.white, width: 4)
                                ),
                                alignment: Alignment.center,
                                width: 94,
                                height: 94,
                                child: (editData?.photo?.url != null) ? ClipOval(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: placeholder,
                                    image: editData?.photo?.url ?? '',
                                    width: 94,
                                    height: 94,
                                    fit: BoxFit.cover,
                                  ),
                                ) : const Icon(Icons.person, size: 64, color: Colors.white),
                              ),

                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: config.secondaryColor.shade50,
                                  ),
                                  child: Icon(Icons.camera_alt, size: 14, color: config.secondaryColor.shade400),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),

                  // form text //
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Wrap(
                        spacing: 14,
                        runSpacing: 14,
                        direction: Axis.horizontal,
                        children: [

                          forms.labelFormFields(
                            labelText: 'First Name',
                            controller: hidden ? null : fnController,
                            onChanged: (val) => updateNewMap(ref, 'first_name', val),
                            validator: ValidationBuilder().required().build(),
                            onTap: () => rHidden.state = true,
                          ),

                          forms.labelFormFields(
                            labelText: 'Last Name',
                            controller: hidden ? null : lnController,
                            onChanged: (val) => updateNewMap(ref, 'last_name', val),
                            validator: ValidationBuilder().required().build(),
                            onTap: () => rHidden.state = true,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labels.label('Gender', color: Colors.black87, fontSize: 14),
                              const SizedBox(height: 4,),

                              Flex(
                                direction: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: buttons.textButtons(
                                      title: 'Male',
                                      onPressed: () {
                                        updateNewMap(ref, 'gender', 'm');
                                      },
                                      padding: const EdgeInsets.symmetric(vertical: 13),
                                      textSize: 13,
                                      bgColor: (resultSet['gender'] == 'm') ? config.infoColor.shade50 : Colors.white,
                                      borderColor: (resultSet['gender'] == 'm') ? config.infoColor.shade300 : config.secondaryColor.shade100,
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: buttons.textButtons(
                                      title: 'Female',
                                      onPressed: () {
                                        updateNewMap(ref, 'gender', 'f');
                                      },
                                      padding: const EdgeInsets.symmetric(vertical: 13),
                                      textSize: 13,
                                      bgColor: (resultSet['gender'] == 'f') ? config.infoColor.shade50 : Colors.white,
                                      borderColor: (resultSet['gender'] == 'f') ? config.infoColor.shade300 : config.secondaryColor.shade100,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          forms.labelFormFields(
                            labelText: 'Year of Birth',
                            readOnly: true,
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            controller: yrController,
                            onChanged: (val) => updateNewMap(ref, 'dob', val),
                            validator: ValidationBuilder().required().build(),
                            onTap: () async {
                              final result = await showBarModalBottomSheet(
                                context: context,
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      width: double.infinity,
                                      child: CupertinoDatePicker(
                                        initialDateTime: DateTime.tryParse(dateFormat),
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (DateTime value) {
                                          setState(() {
                                            dateFormat = stringToString(date: value.toString(), format: 'yyyy-MM-dd') ?? '';
                                          });
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
                                                updateNewMap(ref, 'dob', dateFormat);
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

                              if(result != null) {
                                setState(() {
                                  yrController.text = dateFormat;
                                  print(dateFormat);
                                  print(result);
                                });
                              }
                            },
                          ),

                          forms.labelFormFields(
                            labelText: 'Company',
                            controller: hidden ? null : cmController,
                            onChanged: (val) => updateNewMap(ref, 'company', val),
                            onTap: () => rHidden.state = true,
                          ),

                          forms.labelFormFields(
                            labelText: 'Email',
                            controller: hidden ? null : emController,
                            onChanged: (val) => updateNewMap(ref, 'email', val),
                            onTap: () => rHidden.state = true,
                          ),

                          forms.labelFormFields(
                            labelText: 'Phone Number 1',
                            controller: hidden ? null : ph1Controller,
                            onChanged: (val) => updateNewMap(ref, 'phone[0]', val),
                            validator: ValidationBuilder().minLength(8).maxLength(14).build(),
                            onTap: () => rHidden.state = true,
                          ),

                          forms.labelFormFields(
                            labelText: 'Phone Number 2',
                            controller: hidden ? null : ph2Controller,
                            onChanged: (val) => updateNewMap(ref, 'phone[1]', val),
                            onTap: () => rHidden.state = true,
                          ),

                          forms.labelFormFields(
                            labelText: 'Phone Number 3',
                            controller: hidden ? null : ph3Controller,
                            onChanged: (val) => updateNewMap(ref, 'phone[2]', val),
                            onTap: () => rHidden.state = true,
                          ),

                          forms.labelFormFields(
                            labelText: 'Location',
                            readOnly: true,
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            controller: locController,
                            onChanged: (val) => updateNewMap(ref, 'location', val),
                            validator: ValidationBuilder().required().build(),
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

                          forms.labelFormFields(
                            labelText: 'Address',
                            controller: hidden ? null : addController,
                            onChanged: (val) => updateNewMap(ref, 'address', val),
                            onTap: () => rHidden.state = true,
                          ),

                          // map location //
                          Stack(
                            children: [
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset('assets/img/maps.png', fit: BoxFit.cover),
                                ),
                              ),

                              Positioned(
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: buttons.textButtons(
                                    title: 'Change Location',
                                    onPressed: () {  },
                                    padSize: 10,
                                    textSize: 15,
                                    textColor: config.secondaryColor.shade500,
                                    textWeight: FontWeight.w500,
                                    prefixIcon: Icons.location_pin,
                                    prefColor: config.secondaryColor.shade500,
                                    prefixSize: 22,
                                    bgColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          checkBox(),

                          buttons.textButtons(
                            title: 'Submit',
                            onPressed: () async {
                              if(_formKey.currentState!.validate()) {
                                final resData = ref.watch(newMap);
                                final data = extractData(resData);

                                // Uncomment this line if you need to show the alert
                                // myWidgets.showAlert(context, '$data', title: 'Alert');
                                print(data);

                                final res = await uploadImg.uploadData(data, ref);
                                if (res != null) {
                                  futureAwait(duration: 500, () {
                                    if(!mounted) return;
                                    Navigator.pop(context);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${res['message'] ?? 'Message warning alert.'}'), showCloseIcon: true),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please check validation field again.'), showCloseIcon: true,),
                                );
                              }
                            },
                            padSize: 12,
                            textSize: 16,
                            textWeight: FontWeight.w500,
                            textColor: Colors.white,
                            bgColor: config.warningColor.shade400,
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ]),
          ),

        ],
      ),
    );
  }

  Widget checkBox() {
    final resultSet = ref.watch(newMap);
    if(resultSet['auto_update_profile_picture'] != null) {
      futureAwait(duration: 100, () {
        if(!mounted) return;
        ref.read(valuePro.notifier).state = bool.tryParse(resultSet['auto_update_profile_picture'].toString()) ?? false;
      });
    }

    return CheckboxListTile(
      title: labels.label('Update this contact to your Ads.', color: Colors.black87, fontSize: 13, maxLines: 2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      autofocus: false,
      checkColor: Colors.white,
      dense: true,
      value: ref.watch(valuePro),
      onChanged: (value) {
        ref.read(valuePro.notifier).state = value!;
        updateNewMap(ref, 'auto_update_profile_picture', value.toString());
      },
    );
  }

  void updateNewMap(WidgetRef ref, String key, dynamic val) {
    ref.read(newMap.notifier).update((state) {
      return {...state, key: val};
    });
    print(ref.watch(newMap));
  }

  Future<void> imagePicker1(String type, EditProfileProvider provider) async {
    final uploadImg = ref.watch(uploadData);
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
      }, ref, type);
      if(res.image != null) {
        alertSnack(context, '$type updated success!.');
        ref.read(provider.notifier).updateAt(type, res.photo?.url);
      }
      print(res.toJson());
    }
  }
}

String getNestedValue(Map resultSet, String key) {
  return resultSet[key] is Map ? resultSet[key]['en_name'] : (resultSet[key] ?? '');
}

Map<String, dynamic> extractData(Map input) {
  Map<String, dynamic> extractedData = {};
  input.forEach((key, value) {
    if (value is Map) {
      extractedData[key == 'location' ? 'province' : key] = value['id'] ?? '';
    } else {
      extractedData[key] = value;
    }
  });
  return extractedData;
}


class ProvinceFilters extends ConsumerStatefulWidget {
  const ProvinceFilters({super.key,
    required this.newMap,
  });

  final StateProvider<Map<dynamic, dynamic>> newMap;

  @override
  ConsumerState<ProvinceFilters> createState() => _ProvinceFiltersState();
}

class _ProvinceFiltersState extends ConsumerState<ProvinceFilters> {
  late StateProvider<ProvinceType> typePro;
  late StateProvider<Map> slugPro;
  late StateProvider<Map> tmpPro;
  late String title = '';

  @override
  void initState() {
    super.initState();
    typePro = StateProvider((ref) => ProvinceType.province);
    slugPro = StateProvider((ref) => {});
    tmpPro = StateProvider((ref) => {});
    title = '';
  }

  @override
  Widget build(BuildContext context) {
    final type = ref.watch(typePro);
    final slug = ref.watch(slugPro);
    final rType = ref.read(typePro.notifier);
    final rSlug = ref.read(slugPro.notifier);
    title = '';
    final getProvince = ref.watch(getLocationProvider('province', ''));
    final getDistrict = ref.watch(getLocationProvider('district', slug['district'].toString()));
    final getCommune = ref.watch(getLocationProvider('commune', slug['commune'].toString()));

    switch (type) {
      case ProvinceType.district:
        title = 'District';
        break;
      case ProvinceType.commune:
        title = 'Commune';
        break;
      default:
        title = 'Province';
    }

    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              // dense: true,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0,
              leading: IconButton(
                onPressed: () {
                  switch (type) {
                    case ProvinceType.district:
                      rType.state = ProvinceType.province;
                      break;
                    case ProvinceType.commune:
                      rType.state = ProvinceType.district;
                      break;
                    default:
                      Navigator.pop(context);
                      rType.state = ProvinceType.province;
                  }
                },
                padding: const EdgeInsets.all(14),
                icon: Icon(type != ProvinceType.province ? Icons.keyboard_arrow_left :
                Icons.keyboard_arrow_down_sharp, color: Colors.black87, size: 30,),
              ),
              tileColor: config.secondaryColor.shade50,
              title: labels.label(title, fontSize: 18, color: Colors.black87, textAlign: TextAlign.center),
              titleAlignment: ListTileTitleAlignment.center,
              trailing: IconButton(
                onPressed: () {
                  if(type != ProvinceType.province) {
                    ref.read(widget.newMap.notifier).update((state) {
                      final clearMap = {
                        'province': '',
                        'district': '',
                        'commune': '',
                      };
                      return {...state, ...clearMap};
                    });
                    Navigator.pop(context, 'success');
                  }
                },
                padding: const EdgeInsets.all(15),
                icon: labels.label((type != ProvinceType.province) ? 'Clear' : '', fontSize: 15, color: Colors.black87, textAlign: TextAlign.center),
              ),
            ),

            if(type != ProvinceType.province) ListTile(
              dense: true,
              onTap: () {
                ref.read(widget.newMap.notifier).update((state) {
                  return {...state, ...ref.watch(tmpPro)};
                });
                Navigator.pop(context, 'success');
              },
              shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
              title: labels.label('Any', fontSize: 15, color: config.primaryAppColor.shade600,),
            ),

            if(type == ProvinceType.province) Expanded(
              child: getProvince.when(
                error: (error, stackTrace) => myCards.notFound(context, id: '', message: '$error', onPressed: () { }),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    controller: ModalScrollController.of(context),
                    itemBuilder: (context, index) {
                      final datum = Province.fromJson(data[index] ?? {});
                      return ListTile(
                        dense: true,
                        onTap: () {
                          rType.state = ProvinceType.district;
                          rSlug.state['district'] = datum.slug.toString();
                          updateTmpData(ref, 'province', datum.toJson());
                          updateTmpData(ref, 'district', '');
                          updateTmpData(ref, 'commune', '');
                        },
                        shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                        title: labels.label(datum.en_name ?? 'N/A', fontSize: 15, color: Colors.black87,),
                      );
                    },
                  );
                },
              ),
            ),

            if(type == ProvinceType.district) Expanded(
              child: getDistrict.when(
                error: (error, stackTrace) => myCards.notFound(context, id: '', message: '$error', onPressed: () { }),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    controller: ModalScrollController.of(context),
                    itemBuilder: (context, index) {
                      final datum = Province.fromJson(data[index] ?? {});
                      return ListTile(
                        dense: true,
                        onTap: () {
                          rType.state = ProvinceType.commune;
                          rSlug.state['commune'] = datum.slug.toString();
                          updateTmpData(ref, 'district', datum.toJson());
                          updateTmpData(ref, 'commune', '');
                        },
                        shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                        title: labels.label(datum.en_name ?? 'N/A', fontSize: 15, color: Colors.black87,),
                      );
                    },
                  );
                },
              ),
            ),

            if(type == ProvinceType.commune) Expanded(
              child: getCommune.when(
                error: (error, stackTrace) => myCards.notFound(context, id: '', message: '$error', onPressed: () { }),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    controller: ModalScrollController.of(context),
                    itemBuilder: (context, index) {
                      final datum = Province.fromJson(data[index] ?? {});
                      return ListTile(
                        dense: true,
                        onTap: () {
                          updateTmpData(ref, 'commune', datum.toJson());
                          ref.read(widget.newMap.notifier).update((state) {
                            return {...state, ...ref.watch(tmpPro)};
                          });
                          Navigator.pop(context, 'success');
                        },
                        shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                        title: labels.label(datum.en_name ?? 'N/A', fontSize: 15, color: Colors.black87,),
                      );
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

  void updateTmpData(WidgetRef ref, String key, dynamic val) {
    ref.read(tmpPro.notifier).update((state) {
      return {...state, key: val};
    });
    print(ref.watch(tmpPro));
  }
}

enum ProvinceType { province, district, commune }



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/posts/post_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../serialization/category/main_category.dart';
import '../../serialization/posts/post_serials.dart';
import '../main/home_provider.dart';

final config = Config();
final labels = Labels();
final myWidgets = MyWidgets();
final myCards = MyCards();
final buttons = Buttons();
final forms = Forms();

Decoration? decoration = BoxDecoration(
  border: const Border(
    top: BorderSide(color: Colors.black12, width: 2),
    // left: BorderSide(color: Colors.black12),
    // right: BorderSide(color: Colors.black12),
  ),
  borderRadius: BorderRadius.circular(6),
);

class PostProductPage extends ConsumerStatefulWidget {
  const PostProductPage({super.key});

  @override
  ConsumerState<PostProductPage> createState() => _PostProductPageState();
}

class _PostProductPageState extends ConsumerState<PostProductPage> {

  StateProvider<MainCategory?> mainPro = StateProvider((ref) => null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if(ref.watch(mainPro)?.id != null) {
              ref.read(mainPro.notifier).update((state) => null);
            } else { Navigator.of(context).pop(); }
          },
          padding: const EdgeInsets.all(14),
          icon: const Icon(Icons.arrow_back),
        ),
        title: labels.label('Choose a Category', fontSize: 20, fontWeight: FontWeight.w500),
        titleSpacing: 6,
      ),
      backgroundColor: config.backgroundColor,
      body: BodyPost(
        mainPro: mainPro,
      ),
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 2, null
      ),
    );
  }
}

class BodyPost extends ConsumerWidget {
  const BodyPost({super.key,
    required this.mainPro,
  });

  final StateProvider<MainCategory?> mainPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainCate = ref.watch(getMainCategoryProvider('0'));
    final watchMain = ref.watch(mainPro);
    final subCate = ref.watch(getMainCategoryProvider('${watchMain?.id}'));

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([

            /// main category ///
            if(watchMain?.id == null) mainCate.when(
              error: (e, st) => Text('Error : $e'),
              loading: () => simmerWidget(),
              data: (data) {
                return Flex(direction: Axis.vertical,
                  children: [

                    for(final datum in data)
                      ListTile(
                        dense: true,
                        leading: SizedBox(width: 38, height: 38,
                          child: FadeInImage.assetNetwork(
                            placeholder: placeholder,
                            image: '${datum.icon?.url}', width: 38, height: 38,
                            fit: BoxFit.cover,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        horizontalTitleGap: 12,
                        title: labels.label('${datum.en_name}', fontSize: 14, color: Colors.black87, maxLines: 1),
                        shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                        tileColor: Colors.white,
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () => ref.read(mainPro.notifier).update((state) => datum),
                      ),

                  ],
                );
              },
            ),

            /// sub category ///
            if(watchMain?.id != null) subCate.when(
              error: (e, st) => Text('Error : $e'),
              loading: () => simmerWidget(),
              data: (data) {
                return Flex(direction: Axis.vertical,
                  children: [

                    for(final datum in data)
                      ListTile(
                        dense: true,
                        leading: SizedBox(width: 38, height: 38,
                          child: FadeInImage.assetNetwork(
                            placeholder: placeholder,
                            image: '${datum.icon?.url}', width: 38, height: 38,
                            fit: BoxFit.cover,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        horizontalTitleGap: 12,
                        title: labels.label('${datum.en_name}', fontSize: 14, color: Colors.black87, maxLines: 1),
                        shape: Border(bottom: BorderSide(color: config.secondaryColor.shade50, width: 1)),
                        tileColor: Colors.white,
                        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {
                          routeAnimation(context, pageBuilder: NewAdPage(
                            mainPro: watchMain,
                            subPro: datum,
                          ));
                        },
                      ),

                  ],
                );
              },
            ),

          ]),
        ),
      ],
    );
  }

  Widget simmerWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey,
      child: Flex(
        direction: Axis.vertical,
        children: [
          for(int i=0; i<6; i++) const ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            leading: SizedBox(width: 38, height: 38, child: Icon(Icons.shopping_cart)),
            title: Text('loading...'),
          ),
        ],
      ),
    );
  }
}

class NewAdPage extends ConsumerStatefulWidget {
  const NewAdPage({
    super.key,
    required this.mainPro,
    required this.subPro,
  });

  final MainCategory? mainPro;
  final MainCategory? subPro;

  @override
  ConsumerState<NewAdPage> createState() => _NewAdPageState();
}

class _NewAdPageState extends ConsumerState<NewAdPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final getPostFilterPro = ref.watch(getPostFilterProvider(ref, '${widget.subPro?.slug}', null));
    final datum = getPostFilterPro.valueOrNull ?? PostSerial(data: PostData());

    print('object: ${getPostFilterPro.valueOrNull?.data.photos}');

    return Scaffold(
      appBar: AppBar(
        title: labels.label('New Ad', fontSize: 20, fontWeight: FontWeight.w500),
        titleSpacing: 6,
      ),
      backgroundColor: config.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([

              if(datum.data.photos != null) PhotosPage(),

              if(getPostFilterPro.hasValue) AdsDetails(
                mainPro: widget.mainPro,
                subPro: widget.subPro,
                datum: datum,
                formKey: _formKey,
              ),

              if(datum.data.deliveries != null) DeliveriesPage(datum: datum),

            ]),
          ),
        ],
      ),
    );
  }
}

class PhotosPage extends ConsumerWidget {
  PhotosPage({super.key});

  final StateProvider<List<XFile>> listIMG = StateProvider((ref) => []);
  final StateProvider<int> limitPro = StateProvider((ref) => 8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final img = ref.watch(listIMG);
    final limit = ref.watch(limitPro);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Flex(direction: Axis.horizontal,
              children: [
                Expanded(
                  child: labels.label('Photos', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                Expanded(
                  child: labels.label('${img.length}/$limit', fontSize: 14, color: Colors.black54, textAlign: TextAlign.end),
                )
              ],
            ),
          ),
          Divider(color: config.secondaryColor.shade50, height: 0),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: config.secondaryColor.shade50),
                  ),
                  child: (img.isNotEmpty) ? InkWell(
                    onTap: () => imagePicker1(ref, 0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.memory(File(img.first.path).readAsBytesSync(), height: 140, fit: BoxFit.cover, width: double.maxFinite),
                        ),

                        Positioned(
                          top: -4,
                          right: -4,
                          child: PopupMenuButton(
                            padding: EdgeInsets.zero,
                            surfaceTintColor: Colors.white,
                            onSelected: (item) {},
                            icon: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black12)
                              ),
                              padding: const EdgeInsets.all(3),
                              child: const Icon(Icons.more_vert_rounded, size: 18, color: Colors.black54),
                            ),
                            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                height: 42,
                                value: 0,
                                onTap: () => { },
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  horizontalTitleGap: 8,
                                  leading: const Icon(Icons.remove_red_eye, size: 18),
                                  title: labels.label('View', fontSize: 13, color: Colors.black87),
                                ),
                              ),
                              PopupMenuItem(
                                height: 42,
                                value: 1,
                                onTap: () => deleteImagePicker1(ref, 0),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  horizontalTitleGap: 8,
                                  leading: const Icon(CupertinoIcons.trash, size: 18),
                                  title: labels.label('Delete', fontSize: 13, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ) : InkWell(
                    onTap: () => imagePicker8(ref),
                    child: Container(
                      height: 140,
                      alignment: Alignment.center,
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.photo_camera_back, color: Colors.black54),
                          const SizedBox(width: 10),
                          labels.label('Upload Photo', fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500),
                        ],
                      ),
                    ),
                  ),
                ),

                if(img.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for(int i=1; i<limit; i++)
                          InkWell(
                            onTap: () => imagePicker1(ref, i),
                            child: Container(
                              width: 85,
                              height: 85,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: config.secondaryColor.shade50),
                              ),
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  if(img.length <= i) const Icon(Icons.add, color: Colors.black54)
                                  else ...[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.memory(File(img[i].path).readAsBytesSync(), height: 85, fit: BoxFit.cover, width: double.maxFinite),
                                    ),

                                    Positioned(
                                      top: -9,
                                      right: -9,
                                      child: PopupMenuButton(
                                        padding: EdgeInsets.zero,
                                        surfaceTintColor: Colors.white,
                                        onSelected: (item) {},
                                        icon: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(color: Colors.black12)
                                          ),
                                          padding: const EdgeInsets.all(3),
                                          child: const Icon(Icons.more_vert_rounded, size: 15, color: Colors.black54),
                                        ),
                                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                          PopupMenuItem(
                                            height: 42,
                                            value: 0,
                                            onTap: () => { },
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              dense: true,
                                              horizontalTitleGap: 8,
                                              leading: const Icon(Icons.remove_red_eye, size: 18),
                                              title: labels.label('View', fontSize: 13, color: Colors.black87),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            height: 42,
                                            value: 1,
                                            onTap: () => deleteImagePicker1(ref, i),
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              dense: true,
                                              horizontalTitleGap: 8,
                                              leading: const Icon(CupertinoIcons.trash, size: 18),
                                              title: labels.label('Delete', fontSize: 13, color: Colors.black87),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  buttons.textButtons(
                      title: 'Upload Photo',
                      onPressed: () => imagePicker8(ref, offset: img.length),
                      padSize: 8,
                      textColor: config.primaryAppColor.shade600,
                      prefixIcon: Icons.photo_camera_back,
                      prefColor: config.primaryAppColor.shade600,
                      borderColor: config.primaryAppColor.shade100,
                      bgColor: config.primaryAppColor.shade50.withOpacity(0.75)
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteImagePicker1(WidgetRef ref, int index) async {
    ref.read(listIMG.notifier).update((state) {
      // Create a copy of the current list
      List<XFile> newMap = List.from(state);

      // Replace or add the image at the specified index
      if (index < newMap.length) {
        newMap.removeAt(index);
      }
      return newMap;
    });
  }

  Future<void> imagePicker1(WidgetRef ref, int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      ref.read(listIMG.notifier).update((state) {
        // Create a copy of the current list
        List<XFile> newMap = List.from(state);

        // Replace or add the image at the specified index
        if (index < newMap.length) {
          newMap[index] = image;
        } else {
          newMap.add(image);
        }

        return newMap;
      });
    }
  }

  Future<void> imagePicker8(WidgetRef ref, { int offset = 0 }) async {
    final limit = ref.watch(limitPro) - offset;
    if(limit > 0) {
      final ImagePicker picker = ImagePicker();
      List<XFile> images = await picker.pickMultiImage();

      if(images.isNotEmpty) {
        for(int i=0; i<limit; i++) {
          if(i < images.length) {
            ref.read(listIMG.notifier).update((state) {
              List<XFile> newMap = state;
              newMap = { ...newMap, ...{images[i]} }.toList();
              return newMap;
            });
          }
        }
      }
    }
  }
}

class AdsDetails extends ConsumerWidget {
  const AdsDetails({super.key,
    required this.mainPro,
    required this.subPro,
    required this.datum,
    required this.formKey,
  });

  final MainCategory? mainPro;
  final MainCategory? subPro;
  final PostSerial datum;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataList = datum.data;
    double space = 12;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Flex(direction: Axis.horizontal,
              children: [
                Expanded(
                  child: labels.label('Ads Details', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ],
            ),
          ),
          Divider(color: config.secondaryColor.shade50, height: 0),

          Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    decoration: decoration,
                    child: forms.labelFormFields(
                      labelText: 'Category: ${mainPro?.en_name}',
                      controller: TextEditingController(text: '${subPro?.en_name}'),
                      suffixIcon: const Icon(Icons.arrow_forward_ios_outlined, size: 16, color: Colors.black54,),
                      readOnly: true,
                      onTap: () => routeAnimation(context, pageBuilder: const PostProductPage()),
                    ),
                  ),
                  SizedBox(height: space),

                  for(final vale in (dataList.headlines ?? [] as List<PostDescription?>)) ...[
                    _fieldGenerator(vale!.toJson()),
                    SizedBox(height: space),
                  ],

                  for(final vale in (dataList.fields ?? [] as List<PostDataField?>)) ...[
                    _fieldGenerator(vale!.toJson()),
                    SizedBox(height: space),
                  ],

                  for(final vale in (dataList.prices ?? [] as List<PostPrice?>)) ...[
                    _fieldGenerator(vale!.toJson()),
                    SizedBox(height: space),
                  ],

                  for(final vale in (dataList.descriptions ?? [] as List<PostDescription?>)) ...[
                    _fieldGenerator(vale!.toJson()),
                    SizedBox(height: space),
                  ],

                  for(final vale in (dataList.locations ?? [] as List<PostLocation?>)) ...[
                    _fieldGenerator(vale!.toJson()),
                    SizedBox(height: space),
                  ],

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldGenerator(Map field) {
    switch(field["type"]) {

      case "text":
        return FieldText(field);

      case "textarea":
        return FieldTextArea(field);

      case "radio":
        return FieldRadio(field);

      // case "min_max":
      //   return _fieldMinMax(field);

      case "switch":
        return FieldSwitch(field);

      // case "group_fields":
      //   return _fieldSelect(field);

      default:
        return FieldText(field);
    }
  }
}

class DeliveriesPage extends ConsumerWidget {
  const DeliveriesPage({super.key,
    required this.datum,
  });

  final PostSerial datum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataList = datum.data;
    double space = 12;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Flex(direction: Axis.horizontal,
              children: [
                Expanded(
                  child: labels.label('Deliveries', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ],
            ),
          ),
          Divider(color: config.secondaryColor.shade50, height: 0),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                for(final vale in (dataList.deliveries ?? [] as List<PostDelivery?>)) ...[
                  _fieldGenerator(vale!.toJson()),
                  SizedBox(height: space),
                ],

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldGenerator(Map field) {
    switch(field["type"]) {

      case "text":
        return FieldText(field);

      case "textarea":
        return FieldTextArea(field);

      case "radio":
        return FieldRadio(field);

      // case "min_max":
      //   return _fieldMinMax(field);

      case "switch":
        return FieldSwitch(field);

      // case "group_fields":
      //   return _fieldSelect(field);

      default:
        return FieldText(field);
    }
  }
}

class FieldText extends ConsumerWidget {
  FieldText(this.field, {super.key});

  final Map field;
  final StateProvider<String> ratePro = StateProvider((ref) => 'percent');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datum = PostPrice.fromJson(field);
    final subFix = datum.subfix;
    final watch = ref.watch(ratePro);

    String? Function(String?)? valid;
    if(datum.validation?.required == true) {
      valid = ValidationBuilder().required().build();
      final min = int.tryParse('${datum.validation?.min_length}');
      if(min != null) {
        valid = ValidationBuilder().required().minLength(min).build();
        final max = int.tryParse('${datum.validation?.max_length}');
        if(max != null) {
          valid = ValidationBuilder().required().minLength(min).maxLength(max).build();
        }
      }
    }

    return Stack(
      children: [
        Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: decoration,
                child: forms.labelFormFields(
                  labelText: '${datum.title}',
                  controller: TextEditingController(text: '${datum.prefix?.text != null ? 0 : ''}'),
                  validator: valid,
                  keyboardType: (datum.validation?.numeric == true) ? const TextInputType.numberWithOptions(decimal: true) : null,
                ),
              ),
            ),

            if(subFix != null && subFix.options!.length > 1) ...[
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: CupertinoSlidingSegmentedControl<String>(
                    backgroundColor: Colors.white,
                    thumbColor: config.secondaryColor.shade50,
                    groupValue: watch,
                    padding: const EdgeInsets.all(6),
                    onValueChanged: (String? value) {
                      ref.read(ratePro.notifier).update((state) => '$value');
                    },
                    children: {
                      for(final val in (subFix.options ?? [] as List<PostValueElement?>))
                        '${val?.value}': Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: labels.label('${val?.title}', fontSize: 18, color: Colors.black87, textAlign: TextAlign.center, fontWeight: FontWeight.w500),
                        ),
                    },
                  ),
                ),
              ),
            ],
          ],
        ),

        if(datum.prefix?.text != null) Positioned(
          top: 26.4,
          left: 0,
          child: labels.label('${datum.prefix?.text?.substring(0, 1)}', color: Colors.black87, fontSize: 15),
        )
      ],
    );
  }
}

class FieldTextArea extends ConsumerWidget {
  const FieldTextArea(this.field, {super.key});

  final Map field;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datum = PostDescription.fromJson(field);

    String? Function(String?)? valid;
    if(datum.validation?.required == true) {
      valid = ValidationBuilder().required().build();
      final min = int.tryParse('${datum.validation?.min_length}');
      if(min != null) {
        valid = ValidationBuilder().required().minLength(min).build();
        final max = int.tryParse('${datum.validation?.max_length}');
        if(max != null) {
          valid = ValidationBuilder().required().minLength(min).maxLength(max).build();
        }
      }
    }

    return Container(
      decoration: decoration,
      child: forms.labelFormFields(
        labelText: '${datum.title}',
        maxLines: 3,
        validator: valid,
      ),
    );
  }
}

class FieldRadio extends ConsumerWidget {
  FieldRadio(this.field, {super.key});

  final Map field;
  final StateProvider<PostFluffyOption?> dataValPro = StateProvider((ref) => PostFluffyOption());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datum = PostDataField.fromJson(field);
    final watch = ref.watch(dataValPro);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labels.label('${datum.title}', color: Colors.black, fontSize: 15),
        const SizedBox(height: 4),

        Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for(final val in (datum.options ?? [] as List<PostFluffyOption?>)) ...[
              Expanded(
                child: buttons.textButtons(
                  title: val?.fieldtitle ?? 'N/A',
                  onPressed: () {
                    ref.read(dataValPro.notifier).update((state) => val);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textSize: 14,
                  bgColor: (watch?.fieldvalue == val?.fieldvalue) ? config.infoColor.shade50 : Colors.white,
                  borderColor: (watch?.fieldvalue == val?.fieldvalue) ? config.infoColor.shade300 : config.secondaryColor.shade100,
                ),
              ),
              const SizedBox(width: 12),
            ],

          ],
        ),

        if(watch?.fieldvalue == null && datum.validation?.required == true) Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 6.0),
          child: labels.label('The field is required.', color: Colors.red.shade800, fontSize: 12),
        ),
      ],
    );
  }
}

class FieldSwitch extends ConsumerWidget {
  FieldSwitch(this.field, {super.key});

  final Map field;
  final StateProvider<bool> switchPro = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datum = PostDataField.fromJson(field);
    final watch = ref.watch(switchPro);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: config.secondaryColor.shade100),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labels.label('${datum.title}', fontSize: 12, color: config.secondaryColor.shade200),
              labels.label(watch ? 'Yes' : 'No', fontSize: 16, color: Colors.black),
            ],
          ),

          CupertinoSwitch(
            activeColor: config.primaryAppColor.shade300,
            thumbColor: Colors.white,
            trackColor: Colors.black12,
            value: watch,
            onChanged: (value) {
              ref.read(switchPro.notifier).update((state) => value);
            },
          ),
        ],
      ),
    );
  }
}


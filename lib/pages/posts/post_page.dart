
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/pages/posts/post_provider.dart';
import 'package:k24/serialization/helper.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

import '../../serialization/category/main_category.dart';
import '../../serialization/filters/radio_select/radio.dart';
import '../../serialization/posts/edit_post/edit_post.dart';
import '../../serialization/posts/post_serials.dart';
import '../../widgets/modals.dart';
import '../main/home_provider.dart';

final config = Config();
final labels = Labels();
final myWidgets = MyWidgets();
final myCards = MyCards();
final buttons = Buttons();
final forms = Forms();

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
    this.type,
    this.editData,
  });

  final MainCategory? mainPro;
  final MainCategory? subPro;
  final String? type;
  final EditPostSerial? editData;

  @override
  ConsumerState<NewAdPage> createState() => _NewAdPageState();
}

class _NewAdPageState extends ConsumerState<NewAdPage> {
  StateProvider<Map> newData = StateProvider((ref) => {});
  StateProvider<List> phonePro = StateProvider((ref) => []);
  final myPostApi = Provider((ref) => MyPostApi());
  final _formKey = GlobalKey<FormState>();

  StateProvider<List<TextEditingController>> controllersPro = StateProvider((ref) => [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ]);

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  void setupPage() {
    final editID = widget.editData;
    futureAwait(duration: 1500, () {

      final getPostFilterPro = ref.watch(getPostFilterProvider(ref, '${widget.subPro?.id}', null));
      final datum = getPostFilterPro.valueOrNull ?? PostSerial(data: PostData());
      final controllers = ref.watch(controllersPro);
      final controllersR = ref.watch(controllersPro.notifier);

      final phone = datum.data.contact?.phone ?? [];
      ref.read(phonePro.notifier).state = phone;

      for (int i = 0; i < controllers.length; i++) {
        if (phone.asMap().containsKey(i)) {
          controllersR.state[i].text = phone[i] ?? '';
          updateNewData(ref, 'phone[$i]', phone[i] ?? '', newData);
        }
      }
      controllersR.state[3].text = datum.data.contact?.name ?? '';
      controllersR.state[4].text = datum.data.contact?.email ?? '';
      updateNewData(ref, 'cateid', widget.subPro?.id ?? '', newData);
      updateNewData(ref, 'filter_version', filterVersion, newData);
      updateNewData(ref, 'name', datum.data.contact?.name ?? '', newData);
      updateNewData(ref, 'email', datum.data.contact?.email ?? '', newData);
      updateNewData(ref, 'available', 'true', newData);
      updateNewData(ref, 'discount_type', 'percent', newData);

      List<PostLocation?> list = [];
      for (final val in datum.data.locations ?? list) {
        final valueList = val?.fields;
        // for check value list locations //
        if (valueList is List) {
          for (final secondVal in valueList!) {
            updateNewData(
                ref, secondVal?.fieldname ?? '', secondVal?.value?.toJson(),
                newData);
          }
        } else {
          // for check value map locations //
          if (val?.value is Map && val?.type == 'data') {
            for (var entry in val?.value.entries) {
              final key = entry.key;
              final value = entry.value;
              updateNewData(ref, 'contact_map[$key]', value, newData);
            }
          } else {
            // default type value //
            updateNewData(ref, val?.fieldname ?? '', val?.value, newData);
          }
        }
      }

      if(widget.type != null && widget.type == 'edit') {
        // print(datum.toJson());
        editID?.data?.toJson().forEach((key, value) {
          if(value is Map) {
            value.forEach((key, val) {
              if(val is Map) {
                final res = val['value'];
                updateNewData(ref, key, res, newData);
              } else {
                updateNewData(ref, key, val, newData);
              }
            });
          }
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final editID = widget.editData;
    final getPostFilterPro = ref.watch(getPostFilterProvider(ref, '${editID?.data?.post?.cateid ?? widget.subPro?.id}', null));
    final datum = getPostFilterPro.valueOrNull ?? PostSerial(data: PostData());
    final controllers = ref.watch(controllersPro);

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

              if(getPostFilterPro.isLoading) const SizedBox(
                height: 350,
                child: Center(child: CircularProgressIndicator()),
              ) else ...[
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [

                      if(datum.data.photos != null) PhotosPage(newData: newData),

                      if(getPostFilterPro.hasValue) AdsDetails(
                        mainPro: widget.mainPro,
                        subPro: widget.subPro,
                        datum: datum,
                        newData: newData,
                      ),

                      if(datum.data.deliveries != null) DeliveriesPage(datum: datum, newData: newData),

                      if(datum.data.contact != null) AdsContacts(
                        datum: datum,
                        newData: newData,
                        phonePro: phonePro,
                        controllers: controllers,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            children: [
                              labels.label('By submitting, I agree to the Advertising rule of Khmer24.com',
                                color: Colors.black87, fontSize: 15, textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),

                              InkWell(
                                onTap: () { },
                                child: labels.label('Read Advertising Rule',
                                  color: config.primaryAppColor.shade600, fontSize: 15, textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ]

            ]),
          ),
        ],
      ),
      bottomNavigationBar: bottomNav(),
    );
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
      child: buttons.textButtons(
        title: 'Submit',
        onPressed: () async {
          final sendPost = ref.watch(myPostApi);

          if (_formKey.currentState!.validate()) {
            // Prepare valData map
            final result = ref.watch(newData);
            final Map<String, dynamic> valData = result.map((key, value) {
              if (value is Map) {
                return MapEntry(key, value['fieldvalue'] ?? (value['value'] ?? value['id']));
              } else {
                return MapEntry(key, value);
              }
            });
            // Alert message show for you.
            final rest = await sendPost.createPosts(context, valData, ref);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
            final returnMessage = ResponseMessagePost.fromJson(rest ?? {});
            if(returnMessage.data?.id != null) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              // final data = returnMessage.data;
              // futureAwait(() {
              //   routeAnimation(
              //     context,
              //     pageBuilder: DetailsPost(title: data?.title ?? 'N/A', data: GridCard(data: Data_.fromJson(data?.toJson() ?? {}))),
              //   );
              // });
            }
          }
        },
        padSize: 12,
        textSize: 16,
        textWeight: FontWeight.w500,
        textColor: Colors.white,
        bgColor: config.warningColor.shade400,
      ),
    );
  }
}

class PhotosPage extends ConsumerWidget {
  PhotosPage({super.key, required this.newData});

  final StateProvider<Map> newData;
  final StateProvider<int> limitPro = StateProvider((ref) => 8);
  final apiServiceProvider = Provider((ref) => UploadApiService());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limit = ref.watch(limitPro);
    final resultSet = ref.watch(newData);
    final Map<String, dynamic> img = resultSet.map((key, value) {
      if(key.toString().contains('item_image[')) return MapEntry(key, value);
      return MapEntry('', value);
    });

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6)
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Flex(direction: Axis.horizontal,
              children: [
                Expanded(
                  child: labels.label('Photos', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                Expanded(
                  child: labels.label('${img.length - 1}/$limit', fontSize: 14, color: Colors.black54, textAlign: TextAlign.end),
                ),
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
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: config.secondaryColor.shade50),
                  ),
                  child: (resultSet['item_image[0]'] != null) ? InkWell(
                    onTap: () => imagePicker1(ref, 0),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: FadeInImage.assetNetwork(
                              placeholder: placeholder,
                              image: '$baseUrl/tmp/s-${resultSet['item_image[0]']}',
                              height: 140,
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                            ),
                          ),
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
                    onTap: () => ((img.length - 1) > 0) ? imagePicker1(ref, 0) : imagePicker8(ref),
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

                if((img.length - 1) > 0) ...[
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
                                  if(resultSet['item_image[$i]'] == null) const Icon(Icons.add, color: Colors.black54)
                                  else ...[
                                    SizedBox(
                                      height: 140,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: placeholder,
                                          image: '$baseUrl/tmp/s-${resultSet['item_image[$i]']}',
                                          height: 85,
                                          fit: BoxFit.cover,
                                          width: double.maxFinite,
                                        ),
                                      ),
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
                      onPressed: () => imagePicker8(ref),
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
    updateNewData(ref, 'item_image[$index]', null, newData);
  }

  Future<void> imagePicker1(WidgetRef ref, int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      final xFiles = result.files.first.xFile;

      await uploadIMG(ref, xFiles, index);
    }
  }

  Future<void> imagePicker8(WidgetRef ref) async {
    final limit = ref.watch(limitPro);
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if(result != null) {
      final xFiles = result.files;
      for(int i=0; i<limit; i++) {
        if(i < xFiles.length) await uploadIMG(ref, xFiles[i].xFile, i);
      }
    }
  }

  Future<void> uploadIMG(WidgetRef ref, XFile? image, int index) async {
    final multipartImage = MultipartFile.fromFileSync(image!.path, filename: image.name);
    final filePath = await ref.read(apiServiceProvider).uploadData({
      "file": multipartImage,
    }, ref);

    updateNewData(ref, 'item_image[$index]', filePath.file, newData);
  }
}

class AdsDetails extends ConsumerWidget {
  const AdsDetails({super.key,
    required this.mainPro,
    required this.subPro,
    required this.datum,
    required this.newData,
  });

  final MainCategory? mainPro;
  final MainCategory? subPro;
  final PostSerial datum;
  final StateProvider<Map> newData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataList = datum.data;
    double space = 14;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Flex(direction: Axis.horizontal,
              children: [
                Expanded(
                  child: labels.label('Ads Details', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ],
            ),
          ),
          Divider(color: config.secondaryColor.shade50, height: 0),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                forms.labelFormFields(
                  labelText: 'Category: ${mainPro?.en_name}',
                  controller: TextEditingController(text: '${subPro?.en_name}'),
                  suffixIcon: const Icon(Icons.arrow_forward_ios_outlined, size: 14, color: Colors.black54,),
                  readOnly: true,
                  onTap: () => routeAnimation(context, pageBuilder: const PostProductPage()),
                ),
                SizedBox(height: space),

                for(final vale in (dataList.headlines ?? [] as List<PostDescription?>)) ...[
                  _fieldGenerator(vale!.toJson(), newData),
                  SizedBox(height: space),
                ],

                for(final vale in (dataList.fields ?? [] as List<PostDataField?>)) ...[
                  _fieldGenerator(vale!.toJson(), newData),
                  SizedBox(height: space),
                ],

                for(final vale in (dataList.prices ?? [] as List<PostPrice?>)) ...[
                  _fieldGenerator(vale!.toJson(), newData),
                  SizedBox(height: space),
                ],

                for(final vale in (dataList.descriptions ?? [] as List<PostDescription?>)) ...[
                  _fieldGenerator(vale!.toJson(), newData),
                  SizedBox(height: space),
                ],

                for(final vale in (dataList.locations ?? [] as List<PostLocation?>)) ...[
                  _fieldGenerator(vale!.toJson(), newData),
                  SizedBox(height: space),
                ],

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdsContacts extends ConsumerWidget {
  const AdsContacts({super.key,
    required this.datum,
    required this.newData,
    required this.phonePro,
    required this.controllers,
  });

  final PostSerial datum;
  final StateProvider<Map> newData;
  final StateProvider<List> phonePro;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double space = 14;
    ref.watch(phonePro);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Flex(direction: Axis.horizontal,
              children: [
                Expanded(
                  child: labels.label('Ads Contact', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ],
            ),
          ),
          Divider(color: config.secondaryColor.shade50, height: 0),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                forms.labelFormFields(
                  labelText: 'Name',
                  controller: controllers[3],
                  hintText: 'Unknown',
                  validator: ValidationBuilder().minLength(2).maxLength(50).build(),
                  onChanged: (val) => updateNewData(ref, 'name', val, newData),
                ),
                SizedBox(height: space),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: forms.labelFormFields(
                        labelText: 'Phone Number 1',
                        controller: controllers.first,
                        hintText: 'Unknown',
                        onChanged: (val) => updateVal(ref, 0, val),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: ValidationBuilder().minLength(6).maxLength(14).build(),
                        inputFormatters: [ FilteringTextInputFormatter.digitsOnly ],
                        maxLength: 14,
                      ),
                    ),
                    if(controllers[1].text == '') IconButton(
                      onPressed: () => updateAt(ref, 1, ' '),
                      icon: Icon(Icons.add_circle, color: config.primaryAppColor.shade700),
                    ),
                  ],
                ),
                SizedBox(height: space),

                for(int i=1; i<3; i++) ...[
                  if(controllers[i].text != '') ...[ Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: forms.labelFormFields(
                            labelText: 'Phone Number ${i+1}',
                            controller: controllers[i],
                            hintText: 'Unknown',
                            onChanged: (val) => updateVal(ref, i, val),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [ FilteringTextInputFormatter.digitsOnly ],
                            maxLength: 14,
                          ),
                        ),
                        IconButton(
                          onPressed: () => updateAt(ref, i, ''),
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                        ),
                        if((i < 2 && i == 2) || controllers[2].text == '') IconButton(
                          onPressed: () => updateAt(ref, i + 1, ' '),
                          icon: Icon(Icons.add_circle, color: config.primaryAppColor.shade700),
                        ),
                      ],
                    ),
                    SizedBox(height: space),
                  ],
                ],

                forms.labelFormFields(
                  labelText: 'Email',
                  controller: controllers[4],
                  hintText: 'Unknown',
                  onChanged: (val) => updateNewData(ref, 'email', val, newData),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateVal(WidgetRef ref, int index, val) {
    ref.read(newData.notifier).update((state) {
      final newMap = Map.from(state);
      newMap['phone[$index]'] = val.toString().trim();
      return newMap;
    });
  }

  void updateAt(WidgetRef ref, index, String val) {
    controllers[index].text = val;
    ref.read(newData.notifier).update((state) {
      Map newMap = Map.from(state);
      if (index < newMap.length) {
        newMap['phone[$index]'] = val;
      } else {
        newMap = { ...newMap, ...{ 'phone[$index]': val } };
      }
      return newMap;
    });
    ref.read(phonePro.notifier).update((state) {
      List newList = List.from(state);
      if (index < newList.length) {
        newList[index] = val;
      } else {
        newList.add(val);
      }
      return newList;
    });
  }
}

Widget _fieldGenerator(Map field, StateProvider<Map> newData) {
  switch(field["type"]) {

    case "text":
      return FieldText(field, newData: newData);

    case "textarea":
      return FieldTextArea(field, newData: newData);

    case "radio":
      return FieldRadio(field, newData: newData);

    case "select":
      return FieldSelect(field, newData: newData);

    case "switch":
      return FieldSwitch(field, newData: newData);

    case "group_fields":
      return GroupField(field, newData: newData);

    case "data":
      return MapField(field, newData: newData);

    default:
      return FieldText(field, newData: newData);
  }
}

class DeliveriesPage extends ConsumerWidget {
  const DeliveriesPage({super.key,
    required this.datum,
    required this.newData,
  });

  final PostSerial datum;
  final StateProvider<Map> newData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataList = datum.data;
    double space = 14;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
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
                  _fieldGenerator(vale!.toJson(), newData),
                  SizedBox(height: space),
                ],

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FieldText extends ConsumerStatefulWidget {
  const FieldText(this.field, {super.key, required this.newData});

  final Map field;
  final StateProvider<Map> newData;

  @override
  ConsumerState<FieldText> createState() => _FieldTextState();
}

class _FieldTextState extends ConsumerState<FieldText> {
  late TextEditingController controller;
  final StateProvider<String> ratePro = StateProvider((ref) => 'percent');
  final StateProvider<bool> hiddenPro = StateProvider((ref) => false);
  String? Function(String?)? valid;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    final datum = PostPrice.fromJson(widget.field);

    if (datum.validation?.required == true) {
      valid = ValidationBuilder().required().build();
      final min = int.tryParse('${datum.validation?.min_length}');
      if (min != null) {
        valid = ValidationBuilder().required().minLength(min).build();
        final max = int.tryParse('${datum.validation?.max_length}');
        if (max != null) {
          valid = ValidationBuilder().required().minLength(min).maxLength(max).build();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final datum = PostPrice.fromJson(widget.field);
    final subFix = datum.subfix;
    final watch = ref.watch(ratePro);
    final hidden = ref.watch(hiddenPro);
    final resultSet = ref.watch(widget.newData);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final fieldValue = resultSet[datum.fieldname] ?? '';
      if (controller.text != fieldValue) {
        final previousSelection = controller.selection;
        controller.text = fieldValue;
        controller.selection = previousSelection;
      }
    });

    return Stack(
      children: [
        Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 5,
              child: forms.labelFormFields(
                labelText: '${datum.title}',
                controller: hidden ? null : controller,
                validator: valid,
                keyboardType: (datum.validation?.numeric == true) ? const TextInputType.numberWithOptions(decimal: true) : null,
                onChanged: (val) => updateNewData(ref, datum.fieldname ?? '', val, widget.newData),
                onTap: () => ref.read(hiddenPro.notifier).update((state) => true),
              ),
            ),
            if (subFix != null && subFix.options!.length > 1) ...[
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: CupertinoSlidingSegmentedControl<String>(
                  backgroundColor: Colors.white,
                  thumbColor: config.secondaryColor.shade50,
                  groupValue: watch,
                  padding: const EdgeInsets.all(4),
                  onValueChanged: (String? value) {
                    ref.read(ratePro.notifier).update((state) => '$value');
                    updateNewData(ref, subFix.fieldname ?? '', '$value', widget.newData);
                  },
                  children: {
                    for (final val in (subFix.options ?? [] as List<PostValueElement?>))
                      '${val?.value}': Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: labels.label(
                          '${val?.title}',
                          fontSize: 18,
                          color: Colors.black87,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  },
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class FieldTextArea extends ConsumerStatefulWidget {
  const FieldTextArea(this.field, {super.key,
    required this.newData,
  });

  final Map field;
  final StateProvider<Map> newData;

  @override
  ConsumerState<FieldTextArea> createState() => _FieldTextAreaState();
}

class _FieldTextAreaState extends ConsumerState<FieldTextArea> {
  late TextEditingController controller;
  String? Function(String?)? valid;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();

    final datum = PostDescription.fromJson(widget.field);
    if (datum.validation?.required == true) {
      valid = ValidationBuilder().required().build();
      final min = int.tryParse('${datum.validation?.min_length}');
      if (min != null) {
        valid = ValidationBuilder().required().minLength(min).build();
        final max = int.tryParse('${datum.validation?.max_length}');
        if (max != null) {
          valid = ValidationBuilder().required().minLength(min).maxLength(max).build();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final datum = PostDescription.fromJson(widget.field);
    final resultSet = ref.watch(widget.newData);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final fieldValue = resultSet[datum.fieldname] ?? '';
      if (controller.text != fieldValue) {
        final previousSelection = controller.selection;
        controller.text = fieldValue;
        controller.selection = previousSelection;
      }
    });

    return forms.labelFormFields(
      labelText: '${datum.title}',
      maxLines: 3,
      controller: controller,
      validator: valid,
      onChanged: (val) => updateNewData(ref, datum.fieldname ?? '', val, widget.newData),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class FieldRadio extends ConsumerWidget {
  const FieldRadio(this.field, {super.key,
    required this.newData,
  });

  final Map field;
  final StateProvider<Map> newData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datum = PostDataField.fromJson(field);
    final resultSet = ref.watch(newData);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labels.label('${datum.title}', color: Colors.black, fontSize: 13),

        Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for(final val in (datum.options ?? [] as List<PostFluffyOption?>)) ...[
              Expanded(
                child: buttons.textButtons(
                  title: val?.fieldtitle ?? 'N/A',
                  onPressed: () {
                    updateNewData(ref, datum.fieldname ?? '', '${val?.fieldvalue}', newData);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textSize: 13,
                  bgColor: (resultSet[datum.fieldname] == val?.fieldvalue) ? config.infoColor.shade50 : Colors.white,
                  borderColor: (resultSet[datum.fieldname] == val?.fieldvalue) ? config.infoColor.shade300 : config.secondaryColor.shade100,
                ),
              ),
              const SizedBox(width: 12),
            ],

          ],
        ),

        if(resultSet[datum.fieldname] == null && datum.validation?.required == true) Padding(
          padding: const EdgeInsets.only(left: 6.0, top: 6.0),
          child: labels.label('The field is required.', color: Colors.red.shade800, fontSize: 12),
        ),
      ],
    );
  }
}

class FieldSwitch extends ConsumerWidget {
  FieldSwitch(this.field, {super.key,
    required this.newData,
  });

  final Map field;
  final StateProvider<Map> newData;
  final StateProvider<bool> switchPro = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datum = PostDataField.fromJson(field);
    final resultSet = ref.watch(newData);
    final watch = (resultSet[datum.fieldname] != null) ? resultSet[datum.fieldname] == 'true' : ref.watch(switchPro);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: config.secondaryColor.shade100),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labels.label('${datum.title}', fontSize: 12, color: config.secondaryColor.shade200),
                labels.label(watch ? 'Yes' : 'No', fontSize: 16, color: Colors.black),
              ],
            ),
          ),

          Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              activeColor: config.primaryAppColor.shade300,
              thumbColor: Colors.white,
              trackColor: Colors.black12,
              value: watch,
              onChanged: (value) {
                ref.read(switchPro.notifier).update((state) => value);
                updateNewData(ref, '${datum.fieldname}', '$value', newData);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FieldSelect extends ConsumerStatefulWidget {
  const FieldSelect(this.field, {super.key, required this.newData});

  final Map field;
  final StateProvider<Map<dynamic, dynamic>> newData;

  @override
  ConsumerState<FieldSelect> createState() => _FieldSelectState();
}

class _FieldSelectState extends ConsumerState<FieldSelect> {
  late StateProvider<RadioSelect> radioField;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    radioField = StateProvider((ref) => RadioSelect.fromJson(widget.field as Map<String, dynamic>));
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // final sRadioField = ref.read(radioField.notifier);
    final wRadioField = ref.watch(radioField);

    String? Function(String?)? valid;
    if(wRadioField.validation is Map) {
      final validate = PostDescriptionValidation.fromJson(wRadioField.validation ?? {});
      if (validate.required == true) {
        valid = ValidationBuilder().required().build();
        final min = int.tryParse('${validate.min_length}');
        if (min != null) {
          valid = ValidationBuilder().required().minLength(min).build();
          final max = int.tryParse('${validate.max_length}');
          if (max != null) {
            valid = ValidationBuilder().required().minLength(min).maxLength(max).build();
          }
        }
      }
    }

    // Check if we need to update the controller's text.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (wRadioField.type == 'group_fields' && wRadioField.fields != null) {
        final result = wRadioField.value ?? [];
        late List resultSetList = [];

        for (final val in wRadioField.fields ?? ([] as List<RadioSelect>)) {
          if (ref.watch(widget.newData)[val.fieldname] != null) {
            if (ref.watch(widget.newData)[val.fieldname] is Map) {
              resultSetList.add('${ref.watch(widget.newData)[val.fieldname]['en_name']}');
            }
          }
        }

        final setList = resultSetList.join(', ');
        final fieldValue = setList.isNotEmpty ? setList : result.join(', ');

        if (controller.text != fieldValue) { controller.text = fieldValue; }
      } else if (ref.watch(widget.newData)[wRadioField.fieldname] != null) {
        final fieldValue = ref.watch(widget.newData)[wRadioField.fieldname]['fieldtitle'] ?? '';
        if (controller.text != fieldValue) {
          controller.text = fieldValue;
        }
      } else {
        controller.text = '';
      }
    });

    bool checkBrand = ref.watch(widget.newData)['ad_field'] != null;

    return forms.labelFormFields(
      labelText: wRadioField.title ?? 'N/A',
      suffixIcon: const Icon(Icons.arrow_drop_down),
      controller: controller,
      readOnly: true,
      validator: valid,
      enabled: wRadioField.fieldname == 'ad_model' ? checkBrand : true,
      onTap: () async {
        if(wRadioField.type == 'group_fields') {
          await showBarModalBottomSheet(
            context: context,
            builder: (context) => ProvincePageView(
              data: widget.field as Map<String, dynamic>,
              newData: widget.newData,
            ),
          );

        } else {
          await showBarModalBottomSheet(
            context: context,
            builder: (context) => SelectTypePageView(
              data: widget.field as Map<String, dynamic>,
              selected: true,
              newData: widget.newData,
              expand: false,
            ),
          );

        }
        // Handle the result and update the newData provider
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class GroupField extends ConsumerWidget {
  const GroupField(this.field, {super.key,
    required this.newData,
  });

  final Map field;
  final StateProvider<Map<dynamic, dynamic>> newData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datum = PostDataField.fromJson(field);

    return Column(
      children: [
        if(datum.slug == 'locations') ...[
          FieldSelect(field, newData: newData),
          const SizedBox(height: 12),
        ] else for(final data in (datum.fields ?? [] as List<PostFieldField?>)) ...[
          _fieldGenerator(data!.toJson(), newData),
          const SizedBox(height: 12),
        ]
      ],
    );
  }
}

class MapField extends ConsumerWidget {
  const MapField(this.field, {super.key,
    required this.newData,
  });

  final Map field;
  final StateProvider<Map<dynamic, dynamic>> newData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datum = PostDataField.fromJson(field);

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/img/maps.png', fit: BoxFit.cover),
          ),
        ),

        Positioned(
          child: Container(
            width: double.infinity,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(25),
            color: Colors.black.withOpacity(0.1),
            child: buttons.textButtons(
              title: 'Change location',
              onPressed: () { 
                final mapV = MapClass.fromJson(datum.value ?? {});
                routeAnimation(context, pageBuilder: MapSample(
                  latitude: double.tryParse(mapV.x.toString()) ?? 0.0,
                  longitude: double.tryParse(mapV.y.toString()) ?? 0.0,
                  zoom: double.tryParse(mapV.z.toString()) ?? 0.0,
                ));
              },
              padSize: 10,
              textSize: 15,
              textColor: config.secondaryColor.shade500,
              textWeight: FontWeight.w500,
              prefixIcon: Icons.location_on_outlined,
              prefColor: config.secondaryColor.shade500,
              prefixSize: 22,
              bgColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

void updateNewData(WidgetRef ref, String index, dynamic val, StateProvider<Map> newData) {
  ref.read(newData.notifier).update((state) {
    final newMap = Map.from(state);
    if(val == null) {
      newMap.remove(index);
    } else {
      newMap[index] = val;
    }
    return newMap;
  });
  print(ref.watch(newData));
}








class MapSample extends StatefulWidget {
  const MapSample({super.key,
    required this.latitude,
    required this.longitude,
    required this.zoom,
  });

  final double latitude;
  final double longitude;
  final double zoom;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();

    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: widget.zoom,
      );
    });
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

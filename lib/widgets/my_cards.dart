
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/serialization/category/main_category.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/config.dart';
import '../helpers/helper.dart';
import '../pages/accounts/likes/my_like_provider.dart';
import '../pages/details/details_post.dart';
import '../pages/listing/sub_category.dart';

final Labels labels = Labels();
final Buttons buttons = Buttons();
final Config config = Config();

class MyCards {

  Widget ads({ required String url, required bool loading, String? links }) {
    return InkWell(
      onTap: links != null ? () async {
        // Replace "https://" and split by "/"
        final String modifiedUrl = links.replaceFirst('https://', '');
        final List<String> urlParts = modifiedUrl.split('/');

        // You can reassemble or manipulate the parts if needed
        const String scheme = 'https';
        final String host = urlParts[0];
        final String path = urlParts.sublist(1).join('/');

        final Uri smsLaunchUri = Uri(
          scheme: scheme,
          host: host,
          path: path,
        );

        await launchUrl(smsLaunchUri);
      } : null,
      child: Container(
        alignment: Alignment.center,
        child: Skeletonizer(
          enabled: loading,
          child: Container(
            constraints: const BoxConstraints(minHeight: 150),
            child: Image.network(url),
          )
        ),
      ),
    );
  }

  Widget postAdsCard(double? width, { double height = 240 }) {
    return Container(
      width: (width != null) ? responsive(width) : null,
      height: height,
      decoration: BoxDecoration(
        color: config.primaryColor.shade900,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              labels.label('Want to see your ads here?', textAlign: TextAlign.center, fontSize: 18),
              const SizedBox(height: 8),

              labels.label('Make some extra cash by selling things in khmer24. Go on, it\' quick and easy.', textAlign: TextAlign.center, fontSize: 13, fontWeight: FontWeight.normal),
            ],
          ),

          SizedBox(
            width: double.infinity,
            child: buttons.button(
                'Start Selling',
                onPressed: () { },
                buttonSize: ButtonSizes.small,
                buttonType: ButtonTypes.subtle,
                backgroundColor: Colors.white,
                textColor: config.primaryColor.shade900,
                fontWeight: FontWeight.w500
            ),
          )

        ],
      ),
    );
  }

  Widget noResultCard() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 44),
      child: Column(
        children: [
          Icon(Icons.info, size: 64, color: config.secondaryColor.shade200),
          const SizedBox(height: 4),
          labels.label('No Result!', color: config.secondaryColor.shade300, fontSize: 16, fontWeight: FontWeight.normal),
        ],
      ),
    );
  }

  Widget notFound(BuildContext context, {String id = '', String message = '', required void Function()? onPressed}) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height - 150,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 110, color: config.secondaryColor.shade300),
          labels.label('Post $id not found.', fontSize: 17, color: config.secondaryColor.shade500, fontWeight: FontWeight.w500),
          labels.label(message, fontSize: 13, color: config.secondaryColor.shade200, textAlign: TextAlign.center, maxLines: 2),
          buttons.textButtons(
            title: 'try again',
            textSize: 15,
            textWeight: FontWeight.w400,
            bgColor: Colors.transparent,
            borderColor: config.primaryAppColor.shade600,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  Widget cardCategory(List<MainCategory> data) {
    return Visibility(
      visible: (data.isEmpty) ? false : true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
        decoration: const BoxDecoration(color: Colors.white),
        alignment: Alignment.center,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double width = constraints.maxWidth;
              return Wrap(
                spacing: spaceMenu,
                runSpacing: spaceMenu,
                children: [

                  for(final v in data) ...[
                    cardMenu(map: {
                      'title': v.en_name,
                      'url': v.icon?.url,
                      'width': width,
                      'img_width': 35.0,
                      'size': 11.0
                    }, onTap: () {
                      if(v.id != null && v.id != '#') {
                        routeNoAnimation(
                          context,
                          pageBuilder: SubCategory(title: 'Sub Category', data: {
                            'id': v.id ?? '',
                            'title': v.en_name ?? '',
                            'slug': v.slug ?? ''
                          }, condition: false, setFilters: jsonEncode({})),
                        );
                      }
                    }),
                  ],

                ],
              );
            }
        ),
      ),
    );
  }

  Widget subCategory(List<MainCategory> list, {
    bool condition = false,
    required Map<dynamic, dynamic> setFilters,
    int? lengths
  }) {
    // count length of item //
    int num = lengths != null ? lengths * 2 : 8;
    int length = (list.length / num).ceil();
    Map<dynamic, List<MainCategory>>? menus = {};

    for(int v=0; v<length; v++) {

      final men = list.getRange(v * num, (num * (v+1) <= list.length) ? num * (v+1) : list.length);

      if(men.isNotEmpty) {
        for (final h in men) {
          if(menus[v] == null) menus[v] = [];
          menus[v]?.add(h);
        }
      }
    }

    double height = 200;
    int current = 0;

    return Visibility(
      visible: list.isNotEmpty ? true : false,
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [

                CarouselSlider(
                  items: [
                    for(int k=0; k<length; k++) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
                        decoration: const BoxDecoration(color: Colors.white),
                        alignment: Alignment.topLeft,
                        child: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) {
                              double width = constraints.maxWidth;

                              return Wrap(
                                spacing: spaceMenu,
                                runSpacing: spaceMenu,
                                children: [

                                  if(menus[k] != null) ...[
                                    for(final v in menus[k] as List<MainCategory>)
                                      cardMenu(map: {
                                        'title': v.en_name,
                                        'url': v.icon?.url,
                                        'width': width,
                                        'img_width': 35.0,
                                        'size': 11.0
                                      }, onTap: () {
                                        if(v.id != null && v.id != '#') {
                                          routeNoAnimation(
                                            context,
                                            pageBuilder: SubCategory(title: 'Sub Category', data: {
                                              'id': v.id ?? '',
                                              'title': v.en_name ?? '',
                                              'slug': v.slug ?? ''
                                            }, condition: condition, setFilters: jsonEncode(setFilters)),
                                          );
                                        }
                                      }),
                                  ],

                                ],
                              );
                            }
                        ),
                      ),
                    ],

                  ],
                  carouselController: CarouselController(),
                  options: CarouselOptions(
                    // autoPlay: true,
                    // enlargeCenterPage: true,
                      height: height + 25,
                      aspectRatio: 2.0,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      }),
                ),



                // indicator //
                if(length > 1) Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: const BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 3,
                    children: [
                      for(int v=0; v<length; v++) ...[
                        if(v == current) ...[ Icon(Icons.radio_button_checked_outlined, color: config.warningColor.shade600, size: 11) ]
                        else ...[ Icon(Icons.radio_button_off, color: config.secondaryColor.shade600, size: 11), ],
                      ],
                    ],
                  ),
                ),


              ],
            );
          }
      ),
    );
  }

  Widget shimmerCategory() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
      decoration: const BoxDecoration(color: Colors.white),
      alignment: Alignment.center,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = constraints.maxWidth;
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.white,
              child: Wrap(
                spacing: spaceMenu,
                runSpacing: spaceMenu,
                children: [

                  for(final v in mainCatSkeleton) ...[
                    cardMenu(map: {
                      'title': v.en_name,
                      'url': v.icon?.url,
                      'width': width,
                      'img_width': 35.0,
                      'size': 11.0
                    }, onTap: () {
                      if(v.id != null && v.id != '#') {
                        //
                      }
                    }),
                  ],

                ],
              ),
            );
          }
      ),
    );
  }

  Widget cardMenu({ required Map map, void Function()? onTap }) {
    double width = 40;
    double wid = responsiveSub(map['width']);

    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: SizedBox(
          width: wid,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width,
                constraints: BoxConstraints(minWidth: width, minHeight: width),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(32)
                ),
                child: (map['url'] != '#') ? Image.network(map['url'], width: map['img_width'], loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) { return child; }
                  else {
                    return Container(
                      width: width,
                      height: width,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(32)
                      ),
                    );
                  }
                }) : null,
              ),
              const SizedBox(height: 8),

              labels.label(map['title'], color: config.secondaryColor.shade900, fontSize: 12, textAlign: TextAlign.center, fontWeight: FontWeight.normal),
            ],
          )
      ),
    );
  }

  Widget cardHome(List<GridCard> data, {
    bool fetching = false,
    bool notRelates = true,
    ViewPage viewPage = ViewPage.grid
  }) {
    return Visibility(
      visible: (data.isEmpty && !notRelates) ? false : true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = constraints.maxWidth;
            return Wrap(
              spacing: spaceGrid,
              runSpacing: spaceGrid,
              children: [
                // post ads //
                if(data.isNotEmpty && notRelates) ...[
                  if(viewPage == ViewPage.grid) postAdsCard(width)
                  else if(viewPage == ViewPage.list) postAdsCard(null, height: 200)
                  else if(viewPage == ViewPage.view) postAdsCard(null, height: 200),
                ],

                // items //
                for(final v in data) ...[
                  if(viewPage == ViewPage.grid) gridCard(width, v, context: context)
                  else if(viewPage == ViewPage.list) listCard(v, context: context)
                  else if(viewPage == ViewPage.view) viewCards(v, context: context),
                ],

                // fetching //
                if(fetching) for(final v in listViewSkeleton) ...[
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.white,
                    child: Column(
                      children: [
                        if(viewPage == ViewPage.grid) gridCard(width, v, context: context)
                        else if(viewPage == ViewPage.list) listCard(v, context: context)
                        else if(viewPage == ViewPage.view) viewCards(v, context: context),
                      ],
                    ),
                  ),
                ],

                // data is empty //
                if(data.isEmpty && notRelates) noResultCard(),

              ],
            );
          },
        ),
      ),
    );
  }

  Widget shimmerHome({ ViewPage viewPage = ViewPage.grid }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            child: Wrap(
              spacing: spaceGrid,
              runSpacing: spaceGrid,
              children: [

                // items //
                for(final v in listViewSkeleton) ...[
                  if(viewPage == ViewPage.grid) gridCard(width, v, context: context),
                  if(viewPage == ViewPage.list) listCard(v, context: context),
                  if(viewPage == ViewPage.view) viewCards(v, context: context),
                ],

              ],
            ),
          );
        },
      ),
    );
  }

  StateProvider<bool> isLikes = StateProvider((ref) => false);

  Widget gridCard(double width, GridCard v, { required BuildContext context }) {
    List listImg = [];
    final data = v.data;
    String thumbnail = '';

    String location = '';
    String type = '';
    if(data != null) {
      listImg = v.data?.photos ?? [];
      thumbnail = v.data?.thumbnail ?? '';

      if(v.data?.location != null) {
        if (v.data?.location?.en_name3 != null) {location += ' • ${v.data?.location?.en_name3 ?? ''}';}
        else if (v.data?.location?.en_name2 != null) {location += ' • ${v.data?.location?.en_name2 ?? ''}';}
        else if (v.data?.location?.en_name != null) {location += ' • ${v.data?.location?.en_name ?? ''}';}
      }

      // check type //
      type += data.type ?? '';
      if(data.condition != null) type += ' • ${data.condition?.title ?? ''}';
      if(data.highlight_specs != null && data.highlight_specs is List) {
        for(final v in data.highlight_specs as List<HighlightSpec?>) {
          type += ' • ${v?.display_value ?? ''}';
        }
      }
    }

    return InkWell(
      onTap: () {
        routeAnimation(
          context,
          pageBuilder: DetailsPost(title: data?.title??'N/A', data: v),
        );
      },
      child: Container(
        width: responsive(width),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 1), // changes position of shadow
              blurStyle:  BlurStyle.solid,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // image //
            Stack(
              children: [
                if(thumbnail == '###') ...[
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: config.secondaryColor.shade50, // Color(0xFFE8F5FB),
                      ),
                    ),
                  ),

                ] else ...[
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    child: (thumbnail.isNotEmpty) ? SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: FadeInImage.assetNetwork(placeholder: placeholder, image:
                        thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ) : Container(
                      height: 150,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: config.infoColor.shade50, // Color(0xFFE8F5FB),
                      ),
                      child: labels.label(data?.title??'N/A', color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center, maxLines: 3),
                    ),
                  ),

                  /// more ///
                  Positioned(
                    top: 6,
                    right: 6,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: const Icon(Icons.more_vert_rounded, size: 15,  color: Colors.white),
                      ),
                    ),
                  ),

                  /// discount ///
                  if(data?.discount != null) Positioned(
                    top: 0,
                    left: 0,
                    child: InkWell(
                      onTap: () { },
                      child: DiscountPage(discount: discountString(data?.discount?.type, data?.discount?.amount_saved, data?.discount?.original_price),),
                    ),
                  ),

                  // more image //
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Row(
                      children: [
                        if(data?.shipping?.title != null) FreeDeliveryPage(title: data?.shipping?.title ?? 'N/A',),
                        if(listImg.isNotEmpty && listImg.length > 1) ...[
                          const SizedBox(width: 6),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.camera_alt_rounded, size: 14, color: Colors.white),
                                const SizedBox(width: 6),
                                labels.label('${listImg.length}', fontWeight: FontWeight.normal),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                ],

              ],
            ),

            // text //
            Stack(
              children:[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labels.label(data?.title??'N/A', color: config.secondaryColor.shade900, fontSize: 14, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal),

                      labels.labelIcon(
                        leftIcon: Icon(Icons.access_time, size: 12, color: config.secondaryColor.shade200),
                        leftTitle: ' ${stringToTimeAgoDay(date: '${data?.renew_date ?? data?.posted_date}', format: 'MMM, yy')}',
                        rightTitle: location,
                        style: TextStyle(color: config.secondaryColor.shade200, fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'en', height: lineHeight),
                      ),
                      //
                      labels.label(type, color: config.secondaryColor.shade200, overflow: TextOverflow.ellipsis),

                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          labels.label('\$${data?.price??'0.0'}', color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                          if(data?.discount?.original_price != null) labels.label(
                            '\$${data?.discount?.original_price ?? '0.0'}',
                            color: Colors.black54,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Positioned(
                  right: 6,
                  bottom: 6,
                  child: MyWidgetLikes(data: data),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget listCard(GridCard v, { required BuildContext context }) {
    List listImg = [];
    final data = v.data;
    // var setting = v['setting'] ?? {};
    String thumbnail = '';

    String location = '';
    String type = '';
    if(data != null) {
      listImg = v.data?.photos ?? [];
      thumbnail = v.data?.thumbnail ?? '';

      if(v.data?.location != null) {
        if (v.data?.location?.en_name3 != null) {location += ' • ${v.data?.location?.en_name3 ?? ''}';}
        else if (v.data?.location?.en_name2 != null) {location += ' • ${v.data?.location?.en_name2 ?? ''}';}
        else if (v.data?.location?.en_name != null) {location += ' • ${v.data?.location?.en_name ?? ''}';}
      }

      // check type //
      type += data.type ?? '';
      if(data.condition != null) type += ' • ${data.condition?.title ?? ''}';
      if(data.highlight_specs != null && data.highlight_specs is List) {
        for(final v in data.highlight_specs as List<HighlightSpec?>) {
          type += ' • ${v?.display_value ?? ''}';
        }
      }
    }

    double height = 160;

    return InkWell(
      onTap: () {
        routeAnimation(
          context,
          pageBuilder: DetailsPost(title: data?.title??'N/A', data: v),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 1), // changes position of shadow
              blurStyle:  BlurStyle.solid,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

            // image //
            Stack(
              children: [

                if(thumbnail == '###') ...[
                  Container(
                    width: height,
                    height: height,
                    color: config.secondaryColor.shade50,
                  ),

                ] else ...[

                  Container(
                    width: height,
                    height: height,
                    color: config.secondaryColor.shade50,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
                      child: thumbnail.isNotEmpty ?
                      FadeInImage.assetNetwork(placeholder: placeholder, image: thumbnail, fit: BoxFit.cover)
                          : Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        color: config.infoColor.shade50, // Color(0xFFE8F5FB),
                        child: labels.label(data?.title??'N/A', color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center, maxLines: 3),
                      ),
                    ),
                  ),

                  /// discount ///
                  if(data?.discount != null) Positioned(
                    top: 0,
                    left: 0,
                    child: InkWell(
                      onTap: () { },
                      child: DiscountPage(discount: discountString(data?.discount?.type, data?.discount?.amount_saved, data?.discount?.original_price),),
                    ),
                  ),

                  // more //
                  Positioned(
                    top: 6,
                    right: 6,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: const Icon(Icons.more_vert_rounded, size: 15,  color: Colors.white),
                      ),
                    ),
                  ),

                  if(listImg.isNotEmpty && listImg.length > 1) Positioned(
                    bottom: 6,
                    left: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                      child: Row(
                        children: [
                          const Icon(Icons.camera_alt_rounded, size: 14, color: Colors.white),
                          const SizedBox(width: 6),

                          labels.label('${listImg.length}', fontWeight: FontWeight.normal),
                        ],
                      ),
                    ),
                  ),

                ],

              ],
            ),

            Expanded(
              child: Stack(
                children: [

                  Container(
                    height: height,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labels.label(data?.title??'N/A', color: config.secondaryColor.shade900, fontSize: 14, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, maxLines: 2),

                            labels.labelIcon(
                              leftIcon: Icon(Icons.access_time, size: 12, color: config.secondaryColor.shade200),
                              leftTitle: ' ${stringToTimeAgoDay(date: '${data?.renew_date ?? data?.posted_date}', format: 'MMM, yy')}',
                              rightTitle: location,
                              style: TextStyle(color: config.secondaryColor.shade200, fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'en', height: lineHeight),
                            ),
                            //
                            labels.label(type, color: config.secondaryColor.shade200, overflow: TextOverflow.ellipsis),

                            const SizedBox(height: 4),

                            if(data?.shipping?.title != null) FreeDeliveryPage(title: data?.shipping?.title ?? 'N/A',)
                          ],
                        ),


                        Wrap(
                          spacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            labels.label('\$${data?.price??'0.00'}', color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                            if(data?.discount?.original_price != null) label.label(
                              '\$${data?.discount?.original_price ?? '0.0'}',
                              color: Colors.black54,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                  // love like //
                  Positioned(
                    right: 6,
                    bottom: 6,
                    child: MyWidgetLikes(data: data),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget viewCards(GridCard v, { required BuildContext context }) {
    final data = v.data;
    String thumbnail = '';
    List listImg = [];

    String location = '';
    if(data != null) {
      thumbnail = v.data?.thumbnail ?? '';
      listImg = data.photos ?? [];

      if(v.data?.location != null) {
        if (v.data?.location?.en_name3 != null) {location += ' • ${v.data?.location?.en_name3 ?? ''}';}
        else if (v.data?.location?.en_name2 != null) {location += ' • ${v.data?.location?.en_name2 ?? ''}';}
        else if (v.data?.location?.en_name != null) {location += ' • ${v.data?.location?.en_name ?? ''}';}
      }
    }

    double height = 220;

    return InkWell(
      onTap: () {
        routeAnimation(
          context,
          pageBuilder: DetailsPost(title: data?.title??'N/A', data: v),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 1), // changes position of shadow
              blurStyle:  BlurStyle.solid,
            ),
          ],
        ),
        child: Column(
          children: [

            // list images //
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    if(thumbnail == '###') ...[
                      Container(
                        height: height,
                        width: double.infinity,
                        color: config.secondaryColor.shade50,
                      ),
                      const SizedBox(height: 3),

                    ] else ...[
                      SizedBox(
                        height: height,
                        width: double.infinity,
                        child: (thumbnail.isNotEmpty) ? ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                          child: FadeInImage.assetNetwork(placeholder: placeholder, image: thumbnail, fit: BoxFit.cover),
                        ) : Container(
                          alignment: Alignment.center,
                          color: config.infoColor.shade50,
                          child: labels.label(data?.title??'N/A', color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center, maxLines: 3),
                        ),
                      ),
                      const SizedBox(height: 3),

                      if(listImg.isNotEmpty && listImg.length > 1) ...[
                        LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                          final conf = responsiveImage(constraints.maxWidth);
                          final width = conf['width'];
                          final length = conf['length'] ?? 0;

                          return Wrap(
                            direction: Axis.horizontal,
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              for(int v=1; v<=length; v++) ... [
                                if(listImg.asMap().containsKey(v)) Stack(
                                  children: [

                                    Container(
                                      height: width ?? 120,
                                      width: width ?? 120,
                                      color: config.secondaryColor.shade50,
                                      child: FadeInImage.assetNetwork(placeholder: placeholder, image: '${listImg[v]}', fit: BoxFit.cover),
                                    ),

                                    if((listImg.length - (length + 1)) > 0 && v == length) Positioned(
                                      height: width ?? 120,
                                      width: width ?? 120,
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.black.withOpacity(0.45),
                                        child: labels.label('+${listImg.length - (length + 1)}', fontSize: 18, color: Colors.white,fontWeight: FontWeight.w500),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ],
                          );
                        }
                        ),
                      ],

                    ],

                  ],
                ),

                /// discount ///
                if(data?.discount != null) Positioned(
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () { },
                    child: DiscountPage(discount: discountString(data?.discount?.type, data?.discount?.amount_saved, data?.discount?.original_price),),
                  ),
                ),
              ],
            ),

            // text body //
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12.0),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  labels.label(data?.title??'N/A', color: config.secondaryColor.shade900, fontSize: 16, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, maxLines: 2),

                  labels.labelIcon(
                    leftIcon: Icon(Icons.access_time, size: 12, color: config.secondaryColor.shade200),
                    leftTitle: ' ${stringToTimeAgoDay(date: '${data?.renew_date ?? data?.posted_date}', format: 'MMM, yy')}',
                    rightTitle: location,
                    style: TextStyle(color: config.secondaryColor.shade200, fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'en', height: lineHeight),
                  ),
                  const SizedBox(height: 4),

                  Wrap(
                    spacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      labels.label('\$${data?.price??'0.00'}', color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                      if(data?.discount?.original_price != null) label.label(
                        '\$${data?.discount?.original_price ?? '0.0'}',
                        color: Colors.black54,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                      if(data?.shipping?.title != null) FreeDeliveryPage(title: data?.shipping?.title ?? 'N/A',)
                    ],
                  ),

                  const SizedBox(height: 8),

                  // action button //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [

                          buttons.invButton(
                            prefixIcons: MyWidgetLikes(data: data),
                            text: 'Like',
                            onTap: () { },
                            color: (data?.is_like == true) ? config.primaryAppColor.shade600 : null
                          ),
                          const SizedBox(width: 14),

                          buttons.invButton(
                            icon: CupertinoIcons.chat_bubble, text: 'Chat',
                            onTap: () { },
                          ),

                        ],
                      ),

                      buttons.invButton(
                        icon: CupertinoIcons.arrowshape_turn_up_right,
                        onTap: () { },
                      ),

                    ],
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );
  }

}

final likeProvider = StateProvider.family<bool, String?>((ref, id) => false);

class MyWidgetLikes extends ConsumerWidget {
  final Data_? data;

  const MyWidgetLikes({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = Config();
    final isLiked = data?.is_like ?? false;
    final likeNotifier = ref.read(likeProvider(data?.id).notifier);
    final likerNotifier = ref.watch(likeProvider(data?.id));

    return InkWell(
      onTap: () async {
        final getTokens = await getSecure('user', type: Map);
        if (getTokens != null) {
          final submit = MyAccountApiService();
          if (likerNotifier || isLiked) {
            data?.is_like = false;
            likeNotifier.state = false;
            final result = await submit.submitRemove(context: context, id: '${data?.id}', ref: ref);
            print(result.toJson());
          } else {
            data?.is_like = true;
            likeNotifier.state = true;
            final dataSend = {'id': '${data?.id}', 'type': 'post'};
            final result = await submit.submitAdd(dataSend, context: context, ref: ref);
            print(result.toJson());
          }
        }
      },
      child: Icon(
        (likerNotifier || isLiked) ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        color: (likerNotifier || isLiked) ? config.primaryAppColor.shade600 : config.secondaryColor.shade200,
        size: 24,
      ),
    );
  }
}

class FreeDeliveryPage extends StatelessWidget {
  const FreeDeliveryPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.delivery_dining_sharp, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          labels.label(title, fontWeight: FontWeight.normal, maxLines: 1, fontSize: 10),
        ],
      ),
    );
  }
}

class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key, required this.discount});

  final String discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4, top: 4, bottom: 6, right: 6),
      decoration: BoxDecoration(
        color: config.warningColor.shade400,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          labels.label(discount, fontSize: 12, lineHeight2: 1.10),
          labels.label('OFF', fontSize: 9),
        ],
      ),
    );
  }
}



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:k24/serialization/category/main_category.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../helpers/config.dart';
import '../pages/details/details_post.dart';
import '../pages/listing/sub_category.dart';

class MyCards {
  final Labels labels = Labels();
  final Buttons buttons = Buttons();
  final Config config = Config();

  ads({ required String url, required bool loading }) {
    return Container(
      alignment: Alignment.center,
      child: Skeletonizer(
        enabled: loading,
        child: Container(
          constraints: const BoxConstraints(minHeight: 150),
          child: Image.network(url),
        )
      ),
    );
  }

  postAdsCard(double? width, { double height = 240 }) {
    return Container(
      width: (width != null) ? config.responsive(width) : null,
      height: height,
      decoration: BoxDecoration(
        color: config.primaryColor.shade900,
        borderRadius: BorderRadius.circular(4),
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

  noResultCard() {
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

  cardCategory(List<MainCategory> data) {
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
                spacing: config.spaceMenu,
                runSpacing: config.spaceMenu,
                children: [

                  for(var v in data) ...[
                    cardMenu(map: {
                      'title': v.en_name,
                      'url': v.icon?.url,
                      'width': width,
                      'img_width': 40.0,
                      'size': 12.0
                    }, onTap: () {
                      if(v.id != null && v.id != '#') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SubCategory(title: 'Sub Category', data: {
                            'id': v.id ?? '',
                            'title': v.en_name ?? '',
                            'slug': v.slug ?? ''
                          }, condition: false, setFilters: jsonEncode(v))),
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

  shimmerCategory() {
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
                spacing: config.spaceMenu,
                runSpacing: config.spaceMenu,
                children: [

                  for(var v in config.mainCatSkeleton) ...[
                    cardMenu(map: {
                      'title': v.en_name,
                      'url': v.icon?.url,
                      'width': width,
                      'img_width': 40.0,
                      'size': 12.0
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

  cardMenu({ required Map map, void Function()? onTap }) {
    double width = 45;
    Map res = config.responsiveSub(map['width']);

    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: SizedBox(
          width: res['width'] as double,
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

  cardHome(List<GridCard> data, { bool fetching = false, bool notRelates = true }) {
    return Visibility(
      visible: (data.isEmpty && !notRelates) ? false : true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double width = constraints.maxWidth;
            return Wrap(
              spacing: config.spaceGrid,
              runSpacing: config.spaceGrid,
              children: [
                // post ads //
                if(data.isNotEmpty && notRelates) postAdsCard(width),

                // items //
                for(var v in data) ...[
                  gridCard(width, v, context: context),
                ],

                // fetching //
                if(fetching) for(var v in config.listViewSkeleton) ...[
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade200,
                    highlightColor: Colors.white,
                    child: gridCard(width, v, context: context),
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

  shimmerHome() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.white,
            child: Wrap(
              spacing: config.spaceGrid,
              runSpacing: config.spaceGrid,
              children: [

                // items //
                for(var v in config.listViewSkeleton) ...[
                  gridCard(width, v, context: context),
                ],

              ],
            ),
          );
        },
      ),
    );
  }

  gridCard(double width, GridCard v, { required BuildContext context }) {
    List listImg = [];
    var data = v.data;
    String thumbnail = '';

    String times = '';
    String location = '';
    String type = '';
    if(data != null) {
      listImg = v.data?.photos ?? [];
      thumbnail = v.data?.thumbnail ?? '';

      // check data //
      if(data.renew_date != null) times = Jiffy.parse('${data.renew_date}').fromNow(withPrefixAndSuffix: false);

      if(v.data?.location != null) {
        if (v.data?.location?.en_name3 != null) {location += ' • ${v.data?.location?.en_name3 ?? ''}';}
        else if (v.data?.location?.en_name2 != null) {location += ' • ${v.data?.location?.en_name2 ?? ''}';}
        else if (v.data?.location?.en_name != null) {location += ' • ${v.data?.location?.en_name ?? ''}';}
      }

      // check type //
      type += data.type ?? '';
      if(data.condition != null) type += ' • ${data.condition?.title ?? ''}';
      if(data.highlight_specs != null && data.highlight_specs is List) {
        for(var v in data.highlight_specs as List<HighlightSpec?>) {
          type += ' • ${v?.display_value ?? ''}';
        }
      }
    }

    return InkWell(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailsPost(title: data?.title??'N/A', data: v),
        ));
      },
      child: Container(
        width: config.responsive(width),
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
                      child: Image.network(
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
                      child: labels.label(data?.title??'N/A', color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center),
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

                  // more image //
                  if(listImg.isNotEmpty && listImg.length > 1) Positioned(
                    bottom: 6,
                    right: 6,
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
                        leftTitle: ' $times',
                        rightTitle: location,
                        style: TextStyle(color: config.secondaryColor.shade200, fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'en', height: config.lineHeight),
                      ),
                      //
                      labels.label(type, color: config.secondaryColor.shade200, overflow: TextOverflow.ellipsis),

                      const SizedBox(height: 4),
                      labels.label('\$${data?.price??'0.00'}', color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                    ],
                  ),
                ),

                Positioned(
                  right: 6,
                  bottom: 6,
                  child: InkWell(
                    onTap: () { },
                    child: Icon(CupertinoIcons.heart, color: config.secondaryColor.shade200, size: 22),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

}
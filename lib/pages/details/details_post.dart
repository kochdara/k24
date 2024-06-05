import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/pages/details/details_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPost extends ConsumerStatefulWidget {
  const DetailsPost({super.key, required this.title, required this.data});

  final String title;
  final GridCard data;

  @override
  ConsumerState<DetailsPost> createState() => _TestingPage4State();
}

class _TestingPage4State extends ConsumerState<DetailsPost> {
  final Config config = Config();
  final Labels label = Labels();
  final MyCards myCards = MyCards();
  final Converts converts = Converts();
  final Buttons buttons = Buttons();
  final Forms forms = Forms();

  final ScrollController scrollController = ScrollController();
  List listImg = [];
  double space = 10;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    setupPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    final dataDetails = widget.data;
    final id = dataDetails.data?.id;

    ref.refresh(getDetailPostProvider(id: '$id').future);
    await ref.read(relateDetailPostProvider('$id').notifier).refresh('$id');
  }

  scrollListener() {
    if(scrollController.position.pixels > ref.watch(heightImgPro) + 200) return;
    ref.read(heightScrollPro.notifier).state = scrollController.position.pixels;
  }

  @override
  Widget build(BuildContext context) {
    final dataDetails = widget.data;
    listImg = dataDetails.data?.photos ?? [];
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: (listImg.isEmpty) ? appBar() : null,
      backgroundColor: config.backgroundColor,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [

            /// image ///
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: config.maxWidth),
                child: Opacity(
                  opacity: 1,
                  child: imageList(dataDetails.data?.thumbnail ?? '', listImg),
                ),
              ),
            ),

            /// body ///
            body(),

            /// app bar ///
            if(listImg.isNotEmpty) ...[
              Positioned(
                top: 0,
                left: 0,
                width: width,
                child: AnimatedOpacity(
                  opacity: ref.watch(heightScrollPro) >= (ref.watch(heightImgPro) - 79) ? 1 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: appBar(),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                width: width,
                child: AnimatedOpacity(
                  opacity: ref.watch(heightScrollPro) >= (ref.watch(heightImgPro) - 79) ? 0 : 1,
                  duration: const Duration(milliseconds: 100),
                  child: appBar2(),
                ),
              ),
            ],

          ],
        ),
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  setupPage() {
    heightScrollPro = StateProvider<double>((ref) => 0.0);
  }

  appBar() {
    return AppBar(
      leading: IconButton(
        padding: const EdgeInsets.all(14),
        onPressed: () {
          if(Navigator.canPop(context)) Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      title: label.label(widget.title, overflow: TextOverflow.ellipsis, fontSize: 20, fontWeight: FontWeight.w500),
      titleSpacing: 0,
      actions: [
        IconButton(
          onPressed: () { },
          icon: const Icon(CupertinoIcons.bookmark, color: Colors.white),
        ),

        IconButton(
          onPressed: () { },
          icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill, color: Colors.white),
        ),
      ],
    );
  }

  appBar2() {
    return AppBar(
      leading: IconButton(
        padding: const EdgeInsets.all(14),
        onPressed: () {
          if(Navigator.canPop(context)) Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () { },
          icon: const Icon(CupertinoIcons.bookmark, color: Colors.white),
        ),

        IconButton(
          onPressed: () { },
          icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill, color: Colors.white),
        ),
      ],
    );
  }

  body() {
    final dataDetails = widget.data;
    final watchDetails = ref.watch(getDetailPostProvider(id: '${dataDetails.data?.id}'));
    final watchRelates = ref.watch(relateDetailPostProvider('${dataDetails.data?.id}'));

    Map loc = {};
    if(dataDetails.data != null) {
      listImg = dataDetails.data?.photos ?? [];

      // check location //
      if (dataDetails.data?.location != null) {
        loc['location'] = dataDetails.data?.location?.en_name ?? '';

        var date = converts.stringToString(date: '${dataDetails.data?.renew_date}', format: 'dd, MMM yyyy');
        if(date != null) loc['location'] += ' • $date';

        loc['location2'] = dataDetails.data?.location?.address??'';
        if(dataDetails.data?.location?.long_location != null) {loc['location2'] += ', ${dataDetails.data?.location?.long_location ?? ''}';}
      }
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: config.maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // header image list //
                Opacity(
                  opacity: 0,
                  child: imageList(dataDetails.data?.thumbnail ?? '', listImg),
                ),

                // body of content //
                Container(
                  color: config.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // title //
                      if(!watchDetails.hasError) Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.white,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label.label(dataDetails.data?.title ?? '', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                            label.label(loc['location']??'N/A', fontSize: 13, color: config.secondaryColor.shade400),
                            label.label('\$${dataDetails.data?.price ?? '0.00'}', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.red),
                          ],
                        ),
                      ),

                      SizedBox(height: space / 2),

                      watchDetails.when(
                        error: (e, st) => notFound(id: '${dataDetails.data?.id}', message: '$e'),
                        loading: () => shimmerDetails(),
                        data: (data) {
                          final datum = data.data;

                          return Column(
                            children: [
                              // top ads //
                              myCards.ads(url: 'https://www.khmer24.ws/www/delivery/ai.php?filename=08232023_bannercarsale_(640x290)-2.jpg%20(3)&contenttype=jpeg', loading: watchDetails.isLoading),

                              SizedBox(height: space / 2),

                              // description //
                              Container(
                                padding: const EdgeInsets.all(12),
                                color: Colors.white,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Wrap(
                                      direction: Axis.vertical,
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        label.label('Description', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),

                                        label.label('ID: ${datum?.id??''}', fontSize: 15, color: Colors.black),
                                        label.labelRich('${datum?.total_like??''}', title2: 'Like: ', fontSize: 15, color: config.primaryAppColor.shade400, color2: Colors.black, fontWeight2: FontWeight.normal),

                                        if(datum?.specs != null && datum?.specs is List)
                                          for(var v in datum?.specs as List<Spec_?>) ...[
                                            label.label('${v?.title}: ${v?.value}', fontSize: 15, color: Colors.black),
                                          ],
                                      ],
                                    ),

                                    SizedBox(height: space * 1.5),

                                    // more description //
                                    if(datum?.description != null) label.label('${datum?.description}', fontSize: 15, color: Colors.black),

                                    SizedBox(height: space * 1.5),

                                    // contact info //
                                    label.labelRich('Please don\'t forget to mention that you found this ad on khmer24.com.',
                                      title2: 'Contact Info: ',
                                      fontSize: 15,
                                    ),

                                    SizedBox(height: space * 1.5),

                                    // contact //
                                    if(datum?.phone_white_operator != null && datum?.phone_white_operator is List) ...[
                                      for(var v in datum?.phone_white_operator as List<PhoneWhiteOperator_?>) ...[
                                        contactCard(tell: '${v?.phone}', url: '${v?.icon}'),

                                        SizedBox(height: space / 2),
                                      ],

                                      SizedBox(height: space),
                                    ],

                                    // location //
                                    if(loc['location2'] != null) ...[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(padding: const EdgeInsets.only(right: 8, top: 2),child: Icon(CupertinoIcons.location_solid, size: 18, color: config.secondaryColor.shade500)),

                                          Expanded(child: label.labelRich(loc['location2'] ?? '',
                                            title2: 'Location: ',
                                            fontSize: 15,
                                          )),
                                        ],
                                      ),

                                      SizedBox(height: space),
                                    ],

                                    // map //
                                    mapCard(),

                                    SizedBox(height: space / 2),

                                  ],
                                ),
                              ),

                              // more button //
                              moreButton(),

                              SizedBox(height: space / 2),

                              // top ads //
                              myCards.ads(url: 'https://www.khmer24.ws/www/delivery/ai.php?filename=08232023_bannercarsale_(640x290)-2.jpg%20(3)&contenttype=jpeg', loading: watchDetails.isLoading),

                              SizedBox(height: space / 2),

                              // user card //
                              userCard(map: datum?.user),

                              SizedBox(height: space),

                              // comment card //
                              commentCard(onTap: () { }),

                              // relate card //
                              watchRelates.when(
                                error: (e, st) => Text('Error : $e'),
                                loading: () => myCards.shimmerHome(),
                                data: (data) => myCards.cardHome(data, fetching: ref.watch(fetchProvider), notRelates: false),
                              ),

                              // top ads //
                              myCards.ads(url: 'https://www.khmer24.ws/www/delivery/ai.php?filename=08232023_bannercarsale_(640x290)-2.jpg%20(3)&contenttype=jpeg', loading: watchDetails.isLoading),

                              SizedBox(height: space / 2),

                            ],
                          );
                        },
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  imageList(thumbnail, listImg) {
    return InkWell(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => PreviewImage(title: widget.title, list: listImg))
        // );
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(thumbnail != '') ...[
              Container(
                height: ref.watch(heightImgPro),
                alignment: Alignment.center,
                child: Image.network(thumbnail, fit: BoxFit.cover),
              ),
            ],

            if(listImg.length > 0) ...[
              const SizedBox(height: 4),

              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    var width = config.responsiveImage(constraints.maxWidth)['width'];
                    var length = config.responsiveImage(constraints.maxWidth)['length'];

                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        for(var v=0; v<length; v++) ... [
                          if(listImg.asMap().containsKey(v))
                            Stack(
                              children: [
                                Container(
                                  height: width ?? 120,
                                  width: width ?? 120,
                                  color: config.secondaryColor.shade50,
                                  child: Image.network(listImg[v], fit: BoxFit.cover),
                                ),

                                if((listImg.length - length) > 0 && v == (length - 1))
                                  Positioned(
                                    height: width ?? 120,
                                    width: width ?? 120,
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.black.withOpacity(0.45),
                                      child: label.label('+${(listImg.length - length)}', fontSize: 18, color: Colors.white,fontWeight: FontWeight.w500),
                                    ),
                                  )
                              ],
                            ),
                        ],
                      ],
                    );
                  }
              ),
            ],
          ],
        ),
      ),
    );
  }

  contactCard({ bool hidden = true, String tell = '', String url = '', }) {
    var sub3 = tell;
    final length = sub3.length;
    if(length > 3) {
      sub3 = sub3.substring(length - 3, length).trim();
      tell = tell.substring(0, length - 3).trim();
    }

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          reload() { setState(() {}); }
          return Row(
            children: [
              // const Padding(padding: EdgeInsets.all(4),child: Icon(CupertinoIcons.location_solid, size: 18)),
              if(url.isNotEmpty)
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(right: 10),
                  child: Image.network(url),
                ),

              Expanded(
                child: InkWell(
                  onTap: () async {
                    if(!hidden) {
                      final Uri smsLaunchUri = Uri(
                        scheme: 'tel',
                        path: '$tell$sub3',
                      );
                      await launchUrl(smsLaunchUri);
                    }
                  },
                  child: Row(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: label.label(hidden ? '${tell}xxx' : '$tell$sub3',
                          fontSize: 16,
                          color: hidden ? Colors.black : config.primaryAppColor.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(width: 4),

                      if(hidden)
                        InkWell(
                          onTap: () { hidden = false; reload(); },
                          child: label.label('Click to Show',
                            fontSize: 14,
                            color: config.primaryAppColor.shade600,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
    );
  }

  mapCard() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 100,
          child: Image.asset('assets/img/maps.png', fit: BoxFit.cover),
        ),

        Positioned(
          child: Container(
            width: double.infinity,
            height: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(25),
            color: Colors.black.withOpacity(0.1),
            child: buttons.textButtons(
              title: 'Show Location on Map',
              onPressed: () { },
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
    );
  }

  moreButton() {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: config.secondaryColor.shade100, width: 0.5))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: buttons.textButtons(
              title: 'Save',
              onPressed: () { },
              padSize: 12,
              textSize: 15,
              textWeight: FontWeight.w500,
              textColor: config.secondaryColor.shade300,
              prefixIcon: Icons.bookmark,
              prefColor: config.secondaryColor.shade300,
              prefixSize: 22,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: buttons.textButtons(
              title: 'Report',
              onPressed: () { },
              padSize: 12,
              textSize: 15,
              textWeight: FontWeight.w500,
              textColor: config.secondaryColor.shade300,
              prefixIcon: Icons.report,
              prefColor: config.secondaryColor.shade300,
              prefixSize: 22,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: buttons.textButtons(
              title: 'Share',
              onPressed: () { },
              padSize: 12,
              textSize: 15,
              textWeight: FontWeight.w500,
              textColor: config.secondaryColor.shade300,
              prefixIcon: CupertinoIcons.arrowshape_turn_up_right_fill,
              prefColor: config.secondaryColor.shade300,
              prefixSize: 18,
            ),
          )
        ],
      ),
    );
  }

  userCard({ User_? map }) {
    var syncDate = '';
    var date = converts.stringToString(date: '${map?.registered_date}', format: 'dd, MMM yyyy');
    if(date != null) syncDate = date;

    var photos = map?.photo;
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (photos?.small != null) ? SizedBox(width: 60, height: 60,
                  child: Image.network('${photos?.small?.url}', fit: BoxFit.cover)
              ) : Container(width: 60, height: 60,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 40),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label.label(map?.name??'N/A', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                    label.label('@${map?.username??'n/a'}', fontSize: 13, color: Colors.black),
                    label.label('Member Since $syncDate', fontSize: 13, color: config.secondaryColor.shade300),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: buttons.textButtons(
                  title: 'View Profile',
                  onPressed: () { },
                  padSize: 10,
                  textSize: 14,
                  textWeight: FontWeight.w500,
                  textColor: config.primaryAppColor.shade600,
                  bgColor: config.primaryAppColor.shade50.withOpacity(0.75),
                ),
              ),

              const SizedBox(width: 12),

              buttons.textButtons(
                title: 'Report',
                onPressed: () { },
                padSize: 10,
                textSize: 14,
                textWeight: FontWeight.w500,
                textColor: config.primaryAppColor.shade600,
                prefixIcon: Icons.add,
                prefColor: config.primaryAppColor.shade600,
                prefixSize: 16,
                bgColor: Colors.transparent,
                borderColor: config.primaryAppColor.shade100,
              ),

            ],
          ),

        ],
      ),
    );
  }

  commentCard({ Map? map, void Function()? onTap }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                label.label('Comment', fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),

                buttons.textButtons(
                  title: 'View All',
                  onPressed: onTap,
                  padSize: 9,
                  textSize: 13,
                  textWeight: FontWeight.w500,
                  textColor: config.primaryAppColor.shade600,
                  bgColor: Colors.transparent,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Icon(Icons.person, size: 28, color: Colors.white),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: forms.labelFormFields(null, hintText: 'Be the first to comment', radius: 20, readOnly: true,
                      fillColor: config.secondaryColor.shade50.withOpacity(0.5), borderColor: Colors.transparent,
                      suffixIcon: InkWell(
                        onTap: () { },
                        child: Icon(Icons.send, size: 20, color: config.secondaryColor.shade300),
                      ),
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }

  shimmerDetails() {
    return Container(
      color: Colors.white,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade200,
        highlightColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Row(
                children: [
                  Container(width: 70, height: 70,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(50)),
                  ),
                  const SizedBox(width: 14),

                  Expanded(
                    child: Wrap(
                      runSpacing: 4,
                      children: [
                        Container(height: 20, color: Colors.grey),
                        Container(height: 14, color: Colors.grey),
                        Container(height: 14, color: Colors.grey),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  const Icon(Icons.arrow_forward_ios, size: 28)
                ],
              ),
            ),

            Container(height: space, color: Colors.grey),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20, width: 250, color: Colors.grey),

                  const SizedBox(height: 10),

                  Wrap(
                    runSpacing: 6,
                    children: [

                      for(var v=0; v<10; v++) ...[
                        Row(
                          children: [
                            Container(height: 14, width: 100, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(child: Container(height: 14, width: 50, color: Colors.grey)),
                          ],
                        ),
                      ]

                    ],
                  ),
                ],
              ),
            ),

            Container(height: space, color: Colors.grey),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container(height: 40, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(6)))),
                  SizedBox(width: space),
                  Expanded(child: Container(height: 40, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(6)))),
                  SizedBox(width: space),
                  Expanded(child: Container(height: 40, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(6)))),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  notFound({String id = '', String message = ''}) {
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
          label.label('Post $id not found.', fontSize: 17, color: config.secondaryColor.shade500, fontWeight: FontWeight.w500),
          label.label(message, fontSize: 13, color: config.secondaryColor.shade200, textAlign: TextAlign.center, maxLines: 2),
          buttons.textButtons(
            title: 'try again',
            textSize: 15,
            textWeight: FontWeight.w400,
            bgColor: Colors.transparent,
            borderColor: config.primaryAppColor.shade600,
            onPressed: () { if(Navigator.canPop(context)) Navigator.pop(context); },
          ),
        ],
      ),
    );
  }

  bottomNav() {
    final dataDetails = widget.data;

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
            double width = constraints.maxWidth;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (width * 0.30) - 6,
                  child: buttons.textButtons(
                    title: '${dataDetails.data?.total_like}',
                    onPressed: () { },
                    padSize: 10,
                    textSize: 14,
                    textWeight: FontWeight.w500,
                    bgColor: Colors.transparent,
                    prefixIcon: CupertinoIcons.heart,
                    prefixSize: 26,
                  ),
                ),

                SizedBox(
                  width: (width * 0.35) - 6,
                  child: buttons.textButtons(
                    title: 'Call',
                    onPressed: () { },
                    padSize: 10,
                    textSize: 18,
                    textWeight: FontWeight.w500,
                    textColor: Colors.white,
                    bgColor: config.infoColor.shade400,
                    prefixIcon: Icons.call,
                    prefColor: Colors.white,
                    prefixSize: 22,
                  ),
                ),

                SizedBox(
                  width: (width * 0.35) - 6,
                  child: buttons.textButtons(
                    title: 'Chat',
                    onPressed: () { },
                    padSize: 10,
                    textSize: 18,
                    textWeight: FontWeight.w500,
                    textColor: Colors.white,
                    bgColor: config.warningColor.shade400,
                    prefixIcon: CupertinoIcons.chat_bubble_fill,
                    prefColor: Colors.white,
                    prefixSize: 22,
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}



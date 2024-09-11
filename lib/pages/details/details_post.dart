// ignore_for_file: unused_result, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/functions.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/profile_public/another_profile.dart';
import 'package:k24/pages/accounts/profile_public/profile_provider.dart';
import 'package:k24/pages/chats/conversations/chat_conversation_provider.dart';
import 'package:k24/pages/details/details_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/saves/save_provider.dart';
import 'package:k24/serialization/chats/chat_serial.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/converts.dart';
import '../../serialization/chats/comments/comments_serial.dart';
import '../../serialization/helper.dart';
import '../chats/comments/conversation_comment.dart';
import '../chats/conversations/chat_conversation.dart';
import '../more_provider.dart';

final Config config = Config();
final Labels label = Labels();
final MyCards myCards = MyCards();
final Buttons buttons = Buttons();
final Forms forms = Forms();
final MyWidgets myWidgets = MyWidgets();

class DetailsPost extends ConsumerStatefulWidget {
  const DetailsPost({super.key, required this.title, required this.data});

  final String title;
  final GridCard data;

  @override
  ConsumerState<DetailsPost> createState() => _TestingPage4State();
}

class _TestingPage4State extends ConsumerState<DetailsPost> {
  final ScrollController scrollController = ScrollController();
  StateProvider<String> location = StateProvider<String>((ref) => '');
  StateProvider<String> location2 = StateProvider<String>((ref) => '');
  StateProvider<bool> hidden = StateProvider<bool>((ref) => true);
  StateProvider<double> heightScrollProvider = StateProvider<double>((ref) => 0.0);

  List<String?>? listImg = [];
  double space = 10;
  double heightImg = 300.0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    final dataDetails = widget.data;
    final id = dataDetails.data?.id;

    ref.refresh(getDetailPostProvider(ref, '$id').future);
    await ref.read(relateDetailPostProvider(ref, '$id').notifier).refresh();
  }

  void scrollListener() {
    final heightScroll = ref.read(heightScrollProvider.notifier);
    heightScroll.state = scrollController.position.pixels;
  }

  @override
  Widget build(BuildContext context) {
    final dataDetails = widget.data;
    final adid = dataDetails.data?.id;
    final userTokens = ref.watch(usersProvider);
    final providerDe = getDetailPostProvider(ref, '$adid');
    final watchDetails = ref.watch(providerDe);
    final provider = relateDetailPostProvider(ref, '$adid');
    final watchRelates = ref.watch(provider);
    final watchChat = ref.watch(getTopByUidProvider(ref, adid: '$adid'));

    final dataRes = watchDetails.valueOrNull ?? dataDetails;

    if(dataRes.data != null) {
      listImg = (dataRes.data?.photos ?? dataRes.data?.photos) ?? [];

      // check location //
      if (dataRes.data?.location != null) {
        futureAwait(duration: 10, () {
          ref.read(location.notifier).state = dataRes.data?.location?.en_name ?? '';

          String? date = stringToTimeAgoDay(date: '${dataRes.data?.renew_date}', format: 'dd, MMM yyyy');
          if(date != null) ref.read(location.notifier).state += ' • $date';
        });
      }
    }

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: (listImg!.isEmpty || (dataRes.data?.thumbnail ?? '').isEmpty) ? appBar(watchDetails.valueOrNull, providerDe) : null,
      backgroundColor: config.backgroundColor,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [

            /// image ///
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Opacity(
                  opacity: 1,
                  child: myWidgets.imageList(context, ref, listImg!, widget.title, heightImg: heightImg),
                ),
              ),
            ),

            /// body ///
            RefreshIndicator(
              onRefresh: _handleRefresh,
              notificationPredicate: (notification) => !watchRelates.isLoading,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: maxWidth),
                    child: BodyWidget(
                      title: widget.title,
                      dataDetails: dataRes,
                      listImg: listImg!,
                      space: space,
                      heightImg: heightImg,
                      hidden: hidden,
                      watchDetails: watchDetails,
                      watchRelates: watchRelates,
                      location: location,
                      location2: location2,
                      onPressed: _handleRefresh,
                      provider: provider,
                      providerDe: providerDe,
                    ),
                  ),
                ),
              ),
            ),

            /// app bar ///
            if(listImg!.isNotEmpty) ...[
              Positioned(
                top: 0,
                left: 0,
                width: width,
                child: AnimatedOpacity(
                  opacity: ref.watch(heightScrollProvider) >= (heightImg - 100) ? 1 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: appBar(watchDetails.valueOrNull, providerDe),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                width: width,
                child: AnimatedOpacity(
                  opacity: ref.watch(heightScrollProvider) >= (heightImg - 100) ? 0 : 1,
                  duration: const Duration(milliseconds: 100),
                  child: appBar(watchDetails.valueOrNull, providerDe, transparent: true),
                ),
              ),
            ],

          ],
        ),
      ),
      bottomNavigationBar: (watchChat.valueOrNull != null && dataRes.data?.user?.id != userTokens.user?.id) ?
      bottomNav(watchChat.valueOrNull, watchDetails.valueOrNull, providerDe) : null,
    );
  }

  PreferredSizeWidget appBar(GridCard? dataDetails, dynamic provider, { bool transparent = false }) {
    final datum = dataDetails?.data;

    return AppBar(
      leading: IconButton(
        visualDensity: VisualDensity.standard,
        tooltip: 'Back',
        onPressed: () => Navigator.pop(context),
        iconSize: 18,
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(32),
          ),
          child: const Icon(Icons.arrow_back, size: 24,),
        ),
      ),
      title: transparent ? null : label.label(widget.title, overflow: TextOverflow.ellipsis, fontSize: 20, fontWeight: FontWeight.w500),
      titleSpacing: 0,
      backgroundColor: transparent ? Colors.transparent : null,
      shadowColor: transparent ? Colors.transparent : null,
      surfaceTintColor: transparent ? Colors.transparent : null,
      actions: (datum == null) ? [] : [
        Container(
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(32),
          ),
          child: IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: 'Save',
            onPressed: () {
              savedFunctions(ref, datum.id, provider, isSaved: datum.is_saved, type: 'post', typeRemove: 'post');
            },
            iconSize: 20,
            icon: Icon((datum.is_saved == true) ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark, color: Colors.white),
          ),
        ),
        const SizedBox(width: 6,),

        Container(
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(32),
          ),
          child: IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: 'Share',
            onPressed: () { sharedLinks(context, datum.short_link); },
            iconSize: 20,
            icon: const Icon(CupertinoIcons.arrowshape_turn_up_right_fill, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget bottomNav(ChatData? chatData, GridCard? dataDetails, dynamic provider) {
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
            final isLiked = dataDetails?.data?.is_like ?? false;

            return Row(
              children: [
                Expanded(
                  child: buttons.textButtons(
                    title: formatNumber('${dataDetails?.data?.total_like ?? 0}'),
                    onPressed: () {
                      likedFunction(ref, dataDetails?.data?.id ?? '', isLiked, provider);
                    },
                    padSize: 10,
                    textSize: 14,
                    textWeight: FontWeight.w500,
                    bgColor: Colors.transparent,
                    prefixIcon: (isLiked) ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    prefixSize: 24,
                    prefColor: (isLiked) ? config.primaryAppColor.shade600 : Colors.black,
                  ),
                ),

                const SizedBox(width: 6),

                SizedBox(
                  width: width,
                  child: buttons.textButtons(
                    title: 'Call',
                    onPressed: () => callFun(dataDetails?.data?.phone_white_operator),
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

                const SizedBox(width: 6),

                SizedBox(
                  width: width,
                  child: buttons.textButtons(
                    title: 'Chat',
                    onPressed: (chatData?.user?.id != '') ? () {
                      if(checkLogs(ref)) routeAnimation(context, pageBuilder: ChatConversations(chatData: chatData ?? ChatData()));
                    } : null,
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

  Future<void> callFun(List<PhoneWhiteOperator?>? phones) async {
    if(checkLogs(ref)) {
      final phone = phones ?? [];
      showActionSheet(ref.context, [
        for(final v in phone)
          MoreTypeInfo(v?.slug ?? '', v?.phone ?? '', null, null, () async {
            final Uri smsLaunchUri = Uri(
              scheme: 'tel',
              path: v?.phone ?? '',
            );
            await launchUrl(smsLaunchUri);
          }),
      ]);
    }
  }
}



// ############### //
// body of content //
// ############### //
class BodyWidget extends ConsumerWidget {
  const BodyWidget({super.key,
    required this.title,
    required this.dataDetails,
    required this.listImg,
    required this.space,
    required this.heightImg,
    required this.hidden,
    required this.watchDetails,
    required this.watchRelates,
    required this.location,
    required this.location2,
    this.onPressed,
    this.provider,
    required this.providerDe,
  });

  final String title;
  final dynamic provider;
  final GetDetailPostProvider providerDe;
  final GridCard dataDetails;
  final List listImg;
  final double space;
  final double heightImg;
  final StateProvider<bool> hidden;
  final AsyncValue<GridCard> watchDetails;
  final AsyncValue<List<GridCard>> watchRelates;
  final StateProvider<String> location;
  final StateProvider<String> location2;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerAds = ref.watch(getBannerAdsProvider('app', 'image'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// header image list ///
        Opacity(
          opacity: 0,
          child: myWidgets.imageList(context, ref, listImg, title, heightImg: heightImg),
        ),

        /// body of content ///
        Container(
          color: config.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// title ///
              if(!watchDetails.hasError) Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label.label(dataDetails.data?.title ?? 'Title: N/A', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                    label.label(ref.watch(location)??'Location: N/A', fontSize: 13, color: config.secondaryColor.shade400),
                    Wrap(
                      spacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        label.label('\$${dataDetails.data?.price ?? '0.00'}', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.red),
                        if(dataDetails.data?.discount?.original_price != null) label.label(
                          '\$${dataDetails.data?.discount?.original_price ?? '0.0'}',
                          color: Colors.black54,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                        ),
                        if(dataDetails.data?.discount?.original_price != null) label.label(
                          '${discountString(dataDetails. data?.discount?.type, dataDetails.data?.discount?.amount_saved, dataDetails.data?.discount?.original_price)} OFF',
                          color: config.warningColor.shade500,
                          fontSize: 16,
                        ),
                      ],
                    ),
                    if(dataDetails.data?.shipping?.title != null) ...[
                      const SizedBox(height: 3,),
                      FreeDeliveryPage(title: dataDetails.data?.shipping?.title ?? 'Shipping: N/A',),
                    ],
                  ],
                ),
              ),

              SizedBox(height: space / 2),

              watchDetails.when(
                error: (e, st) => myCards.notFound(context, id: '${dataDetails.data?.id}', message: '$e', onPressed: onPressed),
                loading: () => shimmerDetails(),
                data: (data) {
                  final datum = data.data ?? dataDetails.data;

                  if (datum?.location != null) {
                    futureAwait(duration: 1, () {
                      ref.read(location.notifier).state = datum?.location?.en_name ?? '';

                      String? date = stringToTimeAgoDay(date: '${datum?.renew_date}', format: 'dd, MMM yyyy');
                      if(date != null) ref.read(location.notifier).state += ' • $date';

                      ref.read(location2.notifier).state = datum?.location?.address??'';
                      if(datum?.location?.long_location != null) {ref.read(location2.notifier).state += ', ${datum?.location?.long_location ?? ''}';}
                    });
                  }

                  return Column(
                    children: [
                      /// top ads ///
                      if(bannerAds.hasValue && (bannerAds.value?.data?.detail?.a?.data?.first?.image != null ||
                          bannerAds.value?.data?.detail?.b?.data?.first?.image != null)) ...[
                        myCards.ads(
                          url: '${bannerAds.value?.data?.detail?.a?.data?.first?.image ?? bannerAds.value?.data?.detail?.b?.data?.first?.image}',
                          loading: bannerAds.isLoading,
                          links: bannerAds.value?.data?.detail?.a?.data?.first?.link ?? bannerAds.value?.data?.detail?.b?.data?.first?.link,
                        ),
                        SizedBox(height: space / 2),
                      ],

                      /// description ///
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
                                label.label('Description', fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.8)),

                                label.label('ID: ${datum?.id??''}', fontSize: 15, color: Colors.black),
                                label.labelRich(formatNumber('${datum?.total_like??''}'), title2: 'Like: ', fontSize: 15, color: config.primaryAppColor.shade400, color2: Colors.black, fontWeight2: FontWeight.normal),

                                if(datum?.specs != null && datum?.specs is List)
                                  for(final v in datum?.specs as List<Spec_?>) ...[
                                    label.labelRich(
                                      '${v?.value}', title2: '${v?.title}: ',
                                      fontSize: 15,
                                      color: (v!.field.toString().contains('category')) ? config.primaryAppColor.shade400 : Colors.black,
                                      color2: Colors.black,
                                      fontWeight2: FontWeight.normal,
                                    ),
                                  ],
                              ],
                            ),

                            SizedBox(height: space * 1.5),

                            // more description //
                            if(datum?.description != null) label.selectLabel('${datum?.description}', fontSize: 15, color: Colors.black),

                            SizedBox(height: space * 1.5),

                            // contact info //
                            label.labelRich('Please don\'t forget to mention that you found this ad on khmer24.com.',
                              title2: 'Contact Info: ',
                              fontSize: 15,
                            ),

                            SizedBox(height: space * 1.5),

                            // contact //
                            if(datum?.phone_white_operator != null && datum?.phone_white_operator is List) ...[
                              for(final v in datum?.phone_white_operator as List<PhoneWhiteOperator?>) ...[
                                contactCard(ref, tell: '${v?.phone}', url: '${v?.icon}'),

                                SizedBox(height: space / 2),
                              ],

                              SizedBox(height: space),
                            ],

                            // location //
                            if(ref.watch(location2).isNotEmpty) ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: const EdgeInsets.only(right: 8, top: 3),child: Icon(CupertinoIcons.location_solid, size: 18, color: config.secondaryColor.shade500)),

                                  Expanded(child: label.labelRich(ref.watch(location2) ?? '',
                                    title2: 'Location: ',
                                    fontSize: 15,
                                  )),
                                ],
                              ),

                              SizedBox(height: space),
                            ],

                            // map location //
                            Stack(
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
                            ),

                            SizedBox(height: space / 2),

                          ],
                        ),
                      ),

                      /// more button ///
                      Container(
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
                                onPressed: () async {
                                  savedFunctions(ref, datum?.id, providerDe, isSaved: datum?.is_saved, type: 'post', typeRemove: 'post');
                                },
                                padSize: 10,
                                textSize: 14,
                                textWeight: FontWeight.w500,
                                textColor: config.secondaryColor.shade300,
                                prefixIcon: (datum?.is_saved == true) ? Icons.bookmark : Icons.bookmark_border,
                                prefColor: config.secondaryColor.shade300,
                                prefixSize: 20,
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: buttons.textButtons(
                                title: 'Report',
                                onPressed: () { },
                                padSize: 10,
                                textSize: 14,
                                textWeight: FontWeight.w500,
                                textColor: config.secondaryColor.shade300,
                                prefixIcon: Icons.report,
                                prefColor: config.secondaryColor.shade300,
                                prefixSize: 20,
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: buttons.textButtons(
                                title: 'Share',
                                onPressed: () { sharedLinks(context, datum?.short_link); },
                                padSize: 10,
                                textSize: 14,
                                textWeight: FontWeight.w500,
                                textColor: config.secondaryColor.shade300,
                                prefixIcon: CupertinoIcons.arrowshape_turn_up_right_fill,
                                prefColor: config.secondaryColor.shade300,
                                prefixSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: space / 2),

                      /// top ads ///
                      if(bannerAds.hasValue && (bannerAds.value?.data?.detail?.a?.data?.first?.image != null ||
                          bannerAds.value?.data?.detail?.b?.data?.first?.image != null)) ...[
                        myCards.ads(
                          url: '${bannerAds.value?.data?.detail?.a?.data?.first?.image ?? bannerAds.value?.data?.detail?.b?.data?.first?.image}',
                          loading: bannerAds.isLoading,
                          links: bannerAds.value?.data?.detail?.a?.data?.first?.link ?? bannerAds.value?.data?.detail?.b?.data?.first?.link,
                        ),
                        SizedBox(height: space / 2),
                      ],

                      /// user card ///
                      InkWell(
                        onTap: () => routeAnimation(context, pageBuilder: AnotherProfilePage(userData: datum!.user)),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      if (datum?.user?.photo?.small != null) SizedBox(width: 60, height: 60,
                                          child: ClipOval(child: FadeInImage.assetNetwork(image: '${datum?.user?.photo?.small?.url}', fit: BoxFit.cover, placeholder: placeholder))
                                      ) else Container(width: 60, height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                        child: const Icon(Icons.person, color: Colors.white, size: 40),
                                      ),

                                      if(datum?.user?.online_status?.is_active == true) Positioned(
                                        bottom: 2,
                                        right: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(60),
                                            border: Border.all(color: Colors.white, width: 1),
                                          ),
                                          child: Icon(Icons.circle_rounded, color: Colors.greenAccent.shade700, size: 10),
                                        ),
                                      ),
                                    ],
                                  ),


                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        label.label(datum?.user?.name??'N/A', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
                                        label.label('@${datum?.user?.username??'n/a'}', fontSize: 13, color: Colors.black),
                                        label.label('Member Since ${stringToString(date: '${datum?.user?.registered_date}', format: 'dd, MMM yyyy')}', fontSize: 13, color: config.secondaryColor.shade300),
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
                                      onPressed: () => routeAnimation(context, pageBuilder: AnotherProfilePage(userData: datum!.user)),
                                      padSize: 10,
                                      textSize: 14,
                                      textWeight: FontWeight.w500,
                                      textColor: config.primaryAppColor.shade600,
                                      bgColor: config.primaryAppColor.shade50.withOpacity(0.75),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  buttons.textButtons(
                                    title: 'Follow${(datum?.is_follow == true) ? 'ing' : ''}',
                                    onPressed: () => submitFollow(ref, datum, providerDe),
                                    padSize: 10,
                                    textSize: 14,
                                    textWeight: FontWeight.w500,
                                    textColor: config.primaryAppColor.shade600,
                                    prefixIcon: (datum?.is_follow == true) ? Icons.check : Icons.add,
                                    prefColor: config.primaryAppColor.shade600,
                                    prefixSize: 16,
                                    bgColor: Colors.transparent,
                                    borderColor: config.primaryAppColor.shade100,
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: space / 2),

                      /// comment card ///
                      InkWell(
                        onTap: () => commentClick(context, datum),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  label.label('Comment (${data.data?.total_comment ?? 0})', fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),

                                  buttons.textButtons(
                                    title: 'View All',
                                    onPressed: () => commentClick(context, datum),
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
                                      height: 40,
                                      child: forms.formField(hintText: 'Be the first to comment', radius: 20, readOnly: true,
                                        enabled: false,
                                        fillColor: config.secondaryColor.shade50.withOpacity(0.5),
                                        suffixIcon: Icon(Icons.send, size: 20, color: config.secondaryColor.shade300),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),

                      /// relate card ///
                      watchRelates.when(
                        error: (e, st) => myCards.notFound(context, id: '${dataDetails.data?.id}', message: '$e', onPressed: onPressed),
                        loading: () => myCards.shimmerHome(ref,),
                        data: (data) => myCards.cardHome(
                          context, ref, data, fetching: false, notRelates: false,
                          provider: provider,
                        ),
                      ),

                      /// top ads ///
                      if(bannerAds.hasValue && (bannerAds.value?.data?.detail?.a?.data?.first?.image != null ||
                          bannerAds.value?.data?.detail?.b?.data?.first?.image != null)) ...[
                        myCards.ads(
                          url: '${bannerAds.value?.data?.detail?.a?.data?.first?.image ?? bannerAds.value?.data?.detail?.b?.data?.first?.image}',
                          loading: bannerAds.isLoading,
                          links: bannerAds.value?.data?.detail?.a?.data?.first?.link ?? bannerAds.value?.data?.detail?.b?.data?.first?.link,
                        ),
                        SizedBox(height: space / 2),
                      ],

                    ],
                  );
                },
              ),

            ],
          ),
        ),

      ],
    );
  }

  void commentClick(BuildContext context, Data_? datum) {
    routeAnimation(context, pageBuilder: ConversationCommentPage(
      commentData: CommentDatum(),
      comObject: CommentObject(data: ObjectData.fromJson((datum?.toJson() ?? {}) as Map<String, dynamic>)),
    ));
  }

  Widget contactCard(WidgetRef ref, {String tell = '', String url = '', }) {
    String sub3 = tell;
    final length = sub3.length;
    if(length > 3) {
      sub3 = sub3.substring(length - 3, length).trim();
      tell = tell.substring(0, length - 3).trim();
    }

    return Row(
      children: [
        // const Padding(padding: EdgeInsets.all(4),child: Icon(CupertinoIcons.location_solid, size: 18)),
        if(url.isNotEmpty)
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 10),
            child: FadeInImage.assetNetwork(placeholder: placeholder, image: url),
          ),

        Expanded(
          child: InkWell(
            onTap: () async {
              if(!ref.watch(hidden)) {
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
                  child: label.label(ref.watch(hidden) ? '${tell}xxx' : '$tell$sub3',
                    fontSize: 16,
                    color: ref.watch(hidden) ? Colors.black : config.primaryAppColor.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(width: 4),

                if(ref.watch(hidden))
                  InkWell(
                    onTap: () { ref.read(hidden.notifier).state = false; },
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

  Widget shimmerDetails() {
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

                      for(int v=0; v<10; v++) ...[
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
}





// ############# //
// preview image //
// ############# //
class PreviewImage extends ConsumerStatefulWidget {
  const PreviewImage({super.key, required this.title, required this.list});

  final String title;
  final List list;

  @override
  ConsumerState<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends ConsumerState<PreviewImage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: label.label(widget.title, overflow: TextOverflow.ellipsis, fontSize: 20, fontWeight: FontWeight.w500),
        titleSpacing: 0,
      ),
      backgroundColor: config.backgroundColor,
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          alignment: Alignment.center,
          child: Column(
            children: [
              for(final v in widget.list) ...[
                Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minHeight: 250, minWidth: double.infinity),
                  color: Colors.grey.shade50,
                  child: PhotoHero(
                    photo: '$v',
                    onTap: () => viewImage(context, v),
                  ),
                ),

                const SizedBox(height: 4),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    this.onTap,
  });

  final String photo;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        // width: double.infinity,
        child: Hero(
          tag: photo,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: FadeInImage.assetNetwork(
                placeholder: placeholder,
                image: photo,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


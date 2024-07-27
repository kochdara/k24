
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/pages/notifys/notify_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../helpers/helper.dart';
import '../../serialization/notify/nortify_serial.dart';
import '../details/details_post.dart';

final myWidgets = MyWidgets();
final labels = Labels();
final config = Config();
final myCards = MyCards();

class NotifyPage extends ConsumerStatefulWidget {
  const NotifyPage({super.key});

  @override
  ConsumerState<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends ConsumerState<NotifyPage> {
  final ScrollController _scrollController = ScrollController();
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final pixels = _scrollController.position.pixels;
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent-50 && pixels <= maxScrollExtent) {
        _fetchMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMoreData() async {
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(notifyListProvider(ref).notifier);
    fetchMore.fetchHome();
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  Widget build(BuildContext context) {
    final listNotify = ref.watch(notifyListProvider(ref));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: labels.label('Notifications', fontSize: 20, fontWeight: FontWeight.w500),
        ),
        titleSpacing: 6,
        actions: [
          IconButton(
            onPressed: () =>  { },
            padding: const EdgeInsets.all(14),
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      backgroundColor: config.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(notifyListProvider(ref).notifier).refresh(),
        child: BodyNotify(
          scrollController: _scrollController,
          listNotify: listNotify,
          isLoadingPro: isLoadingPro,
          lengthPro: lengthPro,
        ),
      ),
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 1, null,
      ),
    );
  }
}

class BodyNotify extends ConsumerWidget {
  const BodyNotify({super.key,
    required this.scrollController,
    required this.isLoadingPro,
    required this.listNotify,
    required this.lengthPro,
  });

  final ScrollController scrollController;
  final StateProvider<bool> isLoadingPro;
  final AsyncValue<List<NotifyDatum>> listNotify;
  final StateProvider<int> lengthPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(delegate: SliverChildListDelegate([
          listNotify.when(
            error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () => { }),
            loading: () => Container(
              height: 250,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            data: (data) {
              return Column(
                children: [
                  for(final datum in data) ListTile(
                    onTap: () {
                      switch(datum.type) {
                        case 'apply_job':
                          routeAnimation(
                            context,
                            pageBuilder: ReviewResumePage(
                              datum: datum,
                            ),
                          );
                          break;
                        default:
                          routeAnimation(
                            context,
                            pageBuilder: DetailsPost(title: datum.data?.post?.title ?? 'N/A', data: GridCard(data: datum.data?.post)),
                          );
                          break;
                      }
                    },
                    dense: true,
                    isThreeLine: true,
                    tileColor: (datum.is_open == false) ? config.primaryAppColor.shade50 : Colors.white,
                    leading: (datum.data?.user?.photo?.url != null) ? SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: FadeInImage.assetNetwork(placeholder: placeholder, image: '${datum.data?.user?.photo?.url}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ) : Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: config.secondaryColor.shade50,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        datum.type == 'comment' ? Icons.person : Icons.notifications,
                        size: 24, color: Colors.black38,),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    horizontalTitleGap: 10,
                    title: labels.label(datum.title ?? 'N/A', fontSize: 14, color: Colors.black87,),
                    shape: const Border(bottom: BorderSide(color: Colors.black12)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label(datum.message ?? 'N/A',
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                        labels.label(stringToTimeAgoDay(date: '${datum.send_date}', format: 'dd, MMM yyyy') ?? 'N/A',
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),

                  if(ref.watch(isLoadingPro) && ref.watch(lengthPro) > 0) Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: const CircularProgressIndicator(),
                  ) else if(ref.watch(lengthPro) <= 0) Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(noMore, fit: BoxFit.contain,),
                        ),
                        labels.label('No More', fontSize: 15, color: Colors.black54),
                      ],
                    ),
                  ),

                ],
              );
            },
          ),
        ]),),
      ],
    );
  }
}


class ReviewResumePage extends ConsumerWidget {
  const ReviewResumePage({super.key,
    required this.datum,
  });

  final NotifyDatum datum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getResume = ref.watch(notifyGetDetailsResumeProvider(ref, datum.data?.cv?.id ?? 'N/A'));

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: labels.label('Resume (CV)', fontSize: 20, fontWeight: FontWeight.w500),
        ),
        titleSpacing: 0,
      ),
      backgroundColor: config.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: getResume.when(
            error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () => { }),
            loading: () => Container(
              height: 250,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
            data: (data) {
              final post = data?.post;
              final application = data?.application;
              final personalDetails = application?.personal_details;

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14, top: 8,),
                          child: labels.label('Apply for', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),
                        ),
                        ListTile(
                          onTap: () { },
                          dense: true,
                          leading: post?.logo != null ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: FadeInImage.assetNetwork(placeholder: placeholder, image: '${post?.logo}'),
                          ) : Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.photo_camera_back, color: Colors.black45,),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                          title: labels.label(datum.data?.post?.title ?? 'N/A', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87,),
                          horizontalTitleGap: 8,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              labels.label('Apply Date: ${stringToTimeAgoDay(date: '${datum.send_date}', format: 'dd, MMM yyyy') ?? 'N/A'}', fontSize: 13, color: Colors.black54,),
                              labels.labelRich('\$${datum.data?.post?.price ?? '0.0'}+', title2: '${datum.data?.post?.ad_field ?? ''} • ',
                                  fontSize: 13,
                                  color: Colors.red,
                                  color2: Colors.black54,
                                  fontWeight2: FontWeight.normal,
                                  fontWeight: FontWeight.w500
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black54, size: 18,),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                labels.label(personalDetails?.name ?? 'N/A', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),
                                const SizedBox(height: 8,),

                                LabelIcons(title: 'Gender', subTitle: personalDetails?.gender?.title ?? 'N/A', icon: Icons.transgender,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Date Of Birth', subTitle: stringToString(date: '${personalDetails?.dob}', format: 'dd, MMM yyyy') ?? 'N/A', icon: Icons.calendar_month_sharp,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Nationality', subTitle: personalDetails?.nationality ?? 'N/A', icon: CupertinoIcons.globe,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Phone', subTitle: (personalDetails?.phone ?? []).join(', '), icon: Icons.call,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Email', subTitle: personalDetails?.email ?? 'N/A', icon: Icons.email,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Education Level', subTitle: personalDetails?.education_level?.title ?? 'N/A', icon: Icons.school,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Marital Status', subTitle: personalDetails?.marital_status?.title ?? 'N/A', icon: CupertinoIcons.link,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Locations', subTitle: '${personalDetails?.location?.long_location ?? ''} '
                                '${personalDetails?.address ?? 'N/A'}', icon: Icons.location_on,),
                              ],
                            ),
                          ),

                          // image //

                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LabelIcons extends StatelessWidget {
  const LabelIcons({super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  final String title;
  final String? subTitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black54,),
        const SizedBox(width: 8,),
        Expanded(
          child: labels.label(subTitle != null ? '$title: $subTitle' : title, fontSize: 14, color: Colors.black54,),
        ),
      ],
    );
  }
}



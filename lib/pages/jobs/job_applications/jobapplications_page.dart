
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/functions.dart';
import 'package:k24/pages/jobs/job_applications/application_provider.dart';
import 'package:k24/pages/jobs/job_applications/details_applications.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/serialization/jobs/applications/jobapplications_serial.dart';
import 'package:k24/serialization/notify/nortify_serial.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../../helpers/helper.dart';

final myWidgets = MyWidgets();
final config = Config();
final labels = Labels();
final myCards = MyCards();

class JobApplicationPage extends ConsumerStatefulWidget {
  const JobApplicationPage({super.key});

  @override
  ConsumerState<JobApplicationPage> createState() => _JobApplicationPageState();
}

class _JobApplicationPageState extends ConsumerState<JobApplicationPage> {
  final scrollController = ScrollController();
  late StateProvider newMap;
  StateProvider<bool> isLoadingPro = StateProvider((ref) => false);
  StateProvider<int> lengthPro = StateProvider((ref) => 1);

  @override
  void initState() {
    super.initState();
    newMap = StateProvider((ref) => { 'status': 'all', 'sort': 'newest'});
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if (pixels > maxScrollExtent - 150 && pixels <= maxScrollExtent) {
        fetchMoreData();
      }
    });
  }

  Future<void> fetchMoreData() async {
    final oldMap = ref.watch(newMap);
    final watch = ref.watch(isLoadingPro);
    final read = ref.read(isLoadingPro.notifier);
    final readLen = ref.read(lengthPro.notifier);
    if (watch) return;
    read.state = true;

    final fetchMore = ref.read(getJobApplicationProvider(ref, oldMap).notifier);
    fetchMore.fetchJobApp();
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    readLen.state = fetchMore.length;
    read.state = false;
  }

  @override
  Widget build(BuildContext context) {
    final oldMap = ref.watch(newMap);
    final provider = getJobApplicationProvider(ref, oldMap);
    final getJobApp = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Job Applications', fontSize: 20, fontWeight: FontWeight.w500, maxLines: 1),
        centerTitle: true,
        titleSpacing: 6,
        elevation: 0.0,
        shadowColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: () => reloadData(),
        child: BodyJobApplication(
          newMap: newMap,
          getJobApp: getJobApp,
          scrollController: scrollController,
          isLoadingPro: ref.watch(isLoadingPro),
          lengthPro: ref.watch(lengthPro),
        ),
      ),
      backgroundColor: config.backgroundColor,
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 4, null,
      ),
    );
  }

  Future<void> reloadData() async {
    final oldMap = ref.watch(newMap);
    ref.refresh(getJobApplicationProvider(ref, oldMap).notifier).refresh();
    ref.read(isLoadingPro.notifier).state = false;
    ref.read(lengthPro.notifier).state = 1;
  }
}


class BodyJobApplication extends ConsumerWidget {
  const BodyJobApplication({super.key,
    required this.newMap,
    required this.getJobApp,
    required this.scrollController,
    required this.isLoadingPro,
    required this.lengthPro,
  });

  final StateProvider newMap;
  final AsyncValue<List<JobAppData?>?> getJobApp;
  final ScrollController scrollController;
  final bool isLoadingPro;
  final int lengthPro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oldMap = ref.watch(newMap);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints cons) {
          double width = cons.maxWidth;

          return Stack(
            children: [
              CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverList(delegate: SliverChildListDelegate([
                    const SizedBox(height: 54,),

                    getJobApp.when(
                        error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
                        loading: () => const SizedBox(
                          height: 250,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        data: (data) {
                          return Column(
                              children: [

                                for(final datum in data!)
                                  InkWell(
                                    onTap: () {
                                      final Map oldSchool = datum?.toJson() ?? {};
                                      routeAnimation(
                                        context,
                                        pageBuilder: ReviewResumePage(
                                          datum: NotifyDatum(
                                            notid: datum?.id,
                                            is_open: datum?.status?.value != 'new',
                                            send_date: datum?.apply_date,
                                            data: NotifyData(
                                              cv: ResumeData.fromJson(oldSchool as Map<String, dynamic>),
                                              post: datum?.post,
                                              id: datum?.application?.userid,
                                              adid: datum?.post?.id,
                                              apply_date: datum?.apply_date,
                                              application_type: datum?.application_type,
                                              user: User_(
                                                id: datum?.application?.userid,
                                                name: datum?.application?.name,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      surfaceTintColor: Colors.white,
                                      elevation: 1,
                                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      child: Container(
                                        width: width,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            labels.label(datum?.application?.name ?? 'N/A', color: config.secondaryColor.shade900, fontSize: 18, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, maxLines: 2),

                                            labels.label('Apply: ${datum?.post?.title ?? 'N/A'} • ${datum?.post?.type ?? 'N/A'}', color: Colors.black87, fontSize: 14, overflow: TextOverflow.ellipsis, maxLines: 1),
                                            labels.label('Phone: ${(datum?.application?.phone ?? []).join(', ')}', color: Colors.black87, fontSize: 14, overflow: TextOverflow.ellipsis, maxLines: 1),
                                            labels.label('Email: ${datum?.application?.email ?? 'N/A'}', color: Colors.black87, fontSize: 14, overflow: TextOverflow.ellipsis, maxLines: 1),
                                            labels.label(stringToTimeAgoDay(date: '${datum?.apply_date}', format: 'dd, MMM yyyy') ?? 'N/A', color: Colors.black54, fontSize: 13, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, maxLines: 1),

                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6.0),
                                                border: Border.all(color: config.primaryAppColor.shade200),
                                              ),
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                                              margin: const EdgeInsets.symmetric(vertical: 6),
                                              child: labels.label(datum?.status?.title ?? 'N/A', color: config.primaryAppColor.shade600, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                if(isLoadingPro && lengthPro > 0) Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(20),
                                  child: const CircularProgressIndicator(),
                                ) else if(lengthPro <= 0) const NoMoreResult(),

                              ]
                          );
                        }
                    ),

                    const SizedBox(height: 10,),

                  ])),
                ],
              ),

              Positioned(
                top: 0,
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Wrap(
                    spacing: 30,
                    runSpacing: 4,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            showActionSheet2(context, [
                              MoreTypeInfo('All', '', null, null, () => updateMap(ref, 'status', 'all')),
                              MoreTypeInfo('Pending', '', null, null, () => updateMap(ref, 'status', 'pending')),
                              MoreTypeInfo('Viewed', '', null, null, () => updateMap(ref, 'status', 'viewed')),
                              MoreTypeInfo('Hired', '', null, null, () => updateMap(ref, 'status', 'hired')),
                              MoreTypeInfo('Rejected', '', null, null, () => updateMap(ref, 'status', 'rejected')),
                            ], title: 'Status');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              labels.label('Status: ${capitalizeFirstLetter(oldMap['status'] ?? 'all')}', color: Colors.black87, fontSize: 14),
                              const Icon(Icons.arrow_drop_down_outlined, color: Colors.black87, size: 20,),
                            ],
                          ),
                        ),
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            showActionSheet2(context, [
                              MoreTypeInfo('Newest', '', null, null, () => updateMap(ref, 'sort', 'newest')),
                              MoreTypeInfo('Oldest', '', null, null, () => updateMap(ref, 'sort', 'oldest')),
                            ], title: 'Sort');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              labels.label('Sort: ${capitalizeFirstLetter(oldMap['sort'] ?? 'newest')}', color: Colors.black87, fontSize: 14),
                              const Icon(Icons.arrow_drop_down_outlined, color: Colors.black87, size: 20,),
                            ],
                          ),
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

  void updateMap(WidgetRef ref, String keys, String val,) {
    ref.read(newMap.notifier).update((state) {
      return {...state, ...{ keys: val } };
    });
  }
}



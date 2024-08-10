
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/jobs/job_applications/application_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/buttons.dart';

import '../../../helpers/config.dart';
import '../../../helpers/converts.dart';
import '../../../serialization/notify/nortify_serial.dart';
import '../../../widgets/labels.dart';
import '../../../widgets/my_cards.dart';
import '../../../widgets/my_widgets.dart';
import '../../details/details_post.dart';
import '../../notifys/notify_provider.dart';

final myWidgets = MyWidgets();
final labels = Labels();
final config = Config();
final myCards = MyCards();
final buttons = Buttons();

class ReviewResumePage extends ConsumerStatefulWidget {
  const ReviewResumePage({super.key,
    required this.datum,
  });

  final NotifyDatum datum;

  @override
  ConsumerState<ReviewResumePage> createState() => _ReviewResumePageState();
}

class _ReviewResumePageState extends ConsumerState<ReviewResumePage> {
  final apiService = Provider((ref) => MarkApiServiceApp());

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  Future<void> setupPage() async {
    // final datum = widget.datum;
    // Map<String, dynamic> data = {"action": "mark_as_read",};
    // futureAwait(() async {
    //   final send = ref.watch(apiService);
    //   if(mounted && datum.is_open == false) {
    //     await send.submitMarkRead(data, '${datum.notid}', ref);
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final datum = widget.datum;
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
              final experiences = application?.experiences;
              final educations = application?.educations;
              final skills = application?.skills;
              final languages = application?.languages;
              final references = application?.references;

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
                          onTap: () {
                            print({
                              ...?post?.toJson(),
                              ...{'user': datum.data?.user?.toJson()},
                            });
                            routeAnimation(
                              context,
                              pageBuilder: DetailsPost(title: post?.title ?? 'N/A', data: GridCard(
                                type: datum.type,
                                data: Data_.fromJson({
                                  ...?post?.toJson(),
                                  ...{'price': post?.salary, 'thumbnail': post?.logo, 'photos': post?.thumbnails},
                                  ...{'user': datum.data?.cv?.toJson()},
                                }),
                              ),),
                            );
                          },
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
                              labels.labelRich('\$${(datum.data?.post?.price != 0) ? datum.data?.post?.price : (post?.salary ?? '0.0')}+', title2: '${datum.data?.post?.ad_field ?? post?.type} • ',
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
                                LabelIcons(
                                  title: 'Phone',
                                  subTitle: (personalDetails?.phone ?? []).join(', '),
                                  icon: Icons.call,
                                  color: (personalDetails!.phone!.isNotEmpty) ? config.primaryAppColor.shade600 : null,
                                  onTap: () { },
                                ),
                                const SizedBox(height: 6,),
                                LabelIcons(
                                  title: 'Email',
                                  subTitle: personalDetails.email ?? 'N/A',
                                  icon: Icons.email,
                                  color: (personalDetails.email != null) ? config.primaryAppColor.shade600 : null,
                                  onTap: () { },
                                ),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Education Level', subTitle: personalDetails.education_level?.title ?? 'N/A', icon: Icons.school,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Marital Status', subTitle: personalDetails.marital_status?.title ?? 'N/A', icon: CupertinoIcons.link,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Locations', subTitle: '${personalDetails.location?.long_location ?? ''} '
                                    '${personalDetails.address ?? 'N/A'}', icon: Icons.location_on,),
                              ],
                            ),
                          ),

                          // image //

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12,),

                  if(data?.application?.summary != null) ...[ Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label('Summary', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8,),
                          child: labels.label(data?.application?.summary ?? '', fontSize: 14, color: Colors.black54,),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),],

                  if(experiences != null) ...[ Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label('Work Experiences', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),

                        for(final val in experiences) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8,),
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                labels.label('${val?.position ?? ''} at ${val?.company ?? ''}', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),
                                labels.label('${stringToTimeAgoDay(date: '${val?.start_date}') ?? 'Present'} • ${stringToTimeAgoDay(date: '${val?.end_date}') ?? 'Present'}', fontSize: 14, color: Colors.black54,),
                                labels.label(val?.location?.long_location ?? 'Locations: N/A', fontSize: 14, color: Colors.black54,),
                                labels.label(val?.description ?? '', fontSize: 14, color: Colors.black54,),
                              ],
                            ),
                          ),
                        ],

                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),],

                  if(educations != null) ...[ Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label('Educations', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),

                        for(final val in educations) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8,),
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                labels.label(val?.school ?? 'School: N/A', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),
                                labels.label('${stringToTimeAgoDay(date: '${val?.start_date}') ?? 'Present'} • ${stringToTimeAgoDay(date: '${val?.end_date}') ?? 'Present'}', fontSize: 14, color: Colors.black54,),
                                labels.label('${val?.degree?.title ?? ''} in ${val?.major ?? 'N/A'}', fontSize: 14, color: Colors.black54,),
                                labels.label(val?.description ?? '', fontSize: 14, color: Colors.black54,),
                              ],
                            ),
                          ),
                        ],

                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),],

                  if(skills != null) ...[ Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label('Skills', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for(final val in skills) ...[
                                labels.label('${val?.title ?? ''} - ${val?.level?.title ?? 'Level: N/A'}', fontSize: 14, color: Colors.black54,),
                                const SizedBox(height: 4,),
                              ],
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 12,), ],

                  if(languages != null) ...[ Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label('Languages', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for(final val in languages) ...[
                                labels.label('${val?.title ?? ''} - ${val?.level?.title ?? 'Level: N/A'}', fontSize: 14, color: Colors.black54,),
                                const SizedBox(height: 4,),
                              ],
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),],

                  if(data?.application?.hobbies != null) ...[ Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label('Hobbies & Interests', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
                          child: labels.label(data?.application?.hobbies ?? 'Hobbies & Interests: N/A', fontSize: 14, color: Colors.black54,),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),],

                  if(references != null) ...[ Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labels.label('References', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),

                        for(final val in references) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8,),
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                labels.label(val?.name ?? 'N/A', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),
                                labels.label('${val?.position ?? ''} at ${val?.company ?? ''}', fontSize: 14, color: Colors.black54,),
                                labels.label('Tell: ${(val?.phone ?? []).join(', ')}', fontSize: 14, color: Colors.black54,),
                                labels.label('Email: ${val?.email ?? 'N/A'}', fontSize: 14, color: Colors.black54,),
                              ],
                            ),
                          ),
                        ],

                      ],
                    ),
                  ),],

                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: bottomNav(getResume.hasValue),
    );
  }

  Widget bottomNav(bool show) {
    return Visibility(
      visible: show,
      child: Container(
        height: !show ? 0 : null,
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
        child: Row(
          children: [
            Expanded(
              child: buttons.textButtons(
                title: '',
                onPressed: () { },
                padSize: 10,
                textSize: 14,
                textWeight: FontWeight.w500,
                bgColor: config.primaryAppColor.shade600,
                prefixIcon: Icons.email,
                prefColor: Colors.white,
                prefixSize: 22,
              ),
            ),
            const SizedBox(width: 6),

            Expanded(
              child: buttons.textButtons(
                title: '',
                onPressed: () { },
                padSize: 10,
                textSize: 14,
                textWeight: FontWeight.w500,
                bgColor: config.primaryAppColor.shade600,
                prefixIcon: Icons.call,
                prefColor: Colors.white,
                prefixSize: 22,
              ),
            ),
            const SizedBox(width: 6),

            Expanded(
              child: buttons.textButtons(
                title: '',
                onPressed: () { },
                padSize: 10,
                textSize: 14,
                textWeight: FontWeight.w500,
                bgColor: config.warningColor.shade400,
                prefixIcon: CupertinoIcons.chat_bubble_fill,
                prefColor: Colors.white,
                prefixSize: 22,
              ),
            ),

          ],
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
    this.color,
    this.onTap,
  });

  final String title;
  final String? subTitle;
  final IconData? icon;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.black54,),
          const SizedBox(width: 8,),
          Expanded(
            child: labels.label(subTitle != null ? '$title: $subTitle' : title, fontSize: 14, color: color ?? Colors.black54,),
          ),
        ],
      ),
    );
  }
}

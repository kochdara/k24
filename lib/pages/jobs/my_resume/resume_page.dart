


// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/jobs/my_resume/personal_details/personal_details_page.dart';
import 'package:k24/pages/jobs/my_resume/resume_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../../helpers/config.dart';
import '../job_applications/details_applications.dart';

final myWidgets = MyWidgets();
final labels = Labels();
final config = Config();
final myCards = MyCards();
final buttons = Buttons();

class ResumePage extends ConsumerStatefulWidget {
  const ResumePage({super.key,
    required this.provider,
  });

  final GetResumeInfoProvider provider;

  @override
  ConsumerState<ResumePage> createState() => _ResumePagePageState();
}

class _ResumePagePageState extends ConsumerState<ResumePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: ResumeBody(
        provider: widget.provider,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ResumeBody extends ConsumerWidget {
  const ResumeBody({super.key,
    required this.provider,
  });

  final GetResumeInfoProvider provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getData = ref.watch(provider);

    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildListDelegate([

          getData.when( //
            error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () => { }),
            loading: () => const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
            ),
            data: (data) {
              final datum = data?.data;
              final personalDetails = datum?.personal_details;
              final experiences = datum?.experiences;
              final educations = datum?.educations;
              final skills = datum?.skills;
              final languages = datum?.languages;
              final references = datum?.references;
              final preference = datum?.preference;
              final attachment = datum?.attachment;

              List position = [];
              if(personalDetails?.position != null) position.add(personalDetails?.position);
              if(personalDetails?.work_experience != null) position.add('${personalDetails?.work_experience} years experience');

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                labels.label(personalDetails?.name ?? 'N/A', fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87,),
                                if(position.isNotEmpty) labels.label(position.join(' • '), fontSize: 14, color: Colors.black54,),
                                const SizedBox(height: 8,),

                                LabelIcons(title: 'Gender', subTitle: personalDetails?.gender?.title ?? 'N/A', icon: Icons.transgender, color: Colors.black87,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Date Of Birth', subTitle: stringToString(date: '${personalDetails?.dob}', format: 'dd, MMM yyyy') ?? 'N/A', icon: Icons.calendar_month_sharp,color: Colors.black87,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Nationality', subTitle: personalDetails?.nationality ?? 'N/A', icon: CupertinoIcons.globe,color: Colors.black87,),
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
                                LabelIcons(title: 'Education Level', subTitle: personalDetails.education_level?.title ?? 'N/A', icon: Icons.school,color: Colors.black87,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Marital Status', subTitle: personalDetails.marital_status?.title ?? 'N/A', icon: CupertinoIcons.link,color: Colors.black87,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Locations', subTitle: '${personalDetails.location?.long_location ?? ''} '
                                    '${personalDetails.address ?? 'N/A'}', icon: Icons.location_on,
                                  color: Colors.black87,
                                ),
                                const SizedBox(height: 10,),

                                // button //
                                buttons.textButtons(
                                  title: 'Edit Personal Information',
                                  onPressed: () {
                                    routeAnimation(context, pageBuilder: PersonalsDataPage());
                                  },
                                  padSize: 8,
                                  textSize: 14,
                                  textWeight: FontWeight.w600,
                                  textColor: config.primaryAppColor.shade600,
                                  bgColor: config.primaryAppColor.shade50.withOpacity(0.5),
                                ),
                              ],
                            ),

                            // image //
                            Positioned(
                              top: 4,
                              right: 0,
                              child: SizedBox(
                                height: 130,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: (personalDetails.photo?.url != null) ? FadeInImage.assetNetwork(
                                    placeholder: placeholder,
                                    image: '${personalDetails.photo?.url}',
                                    fit: BoxFit.cover,
                                  ) : Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(color: config.primaryAppColor.shade600),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.person, color: config.primaryAppColor.shade600, size: 40,),
                                            labels.label('4 x 6', fontSize: 14, color: config.primaryAppColor.shade600),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(title: 'Summary', status: datum?.summary != null ? 'edit' : 'add', onPressed: () { }),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              datum?.summary ?? 'Write 2-4 short & energetic sentences to interest the reader! Mention your role, experience & most importantly-your biggest achievenments, best qualities and skills.',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),

                          // buttons //
                          ButtonAddUI(title: 'Summary', status: datum?.summary != null ? 'Edit' : 'Add', onPressed: () { }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(title: 'Work Experiences', status: 'add', onPressed: () { }),

                          for(final val in experiences ?? []) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 8,),
                              child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labels.label('${val?.position ?? ''} at ${val?.company ?? ''}', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),
                                  labels.label('${stringToTimeAgoDay(date: '${val?.start_date}') ?? 'Present'} • ${stringToTimeAgoDay(date: '${val?.end_date}') ?? 'Present'}', fontSize: 14, color: Colors.black54,),
                                  labels.label(val?.location?.long_location ?? 'Locations: N/A', fontSize: 14, color: Colors.black54,),
                                  labels.label(val?.description ?? 'Description: N/A', fontSize: 14, color: Colors.black54,),
                                ],
                              ),
                            ),
                          ],

                          ButtonAddUI(title: 'Work Experiences', status: 'Add', onPressed: () { }),

                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(title: 'Educations', status: 'add', onPressed: () { }),

                          for(final val in educations ?? []) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 8,),
                              child: Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labels.label(val?.school ?? 'School: N/A', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,),
                                  labels.label('${stringToTimeAgoDay(date: '${val?.start_date}') ?? 'Present'} • ${stringToTimeAgoDay(date: '${val?.end_date}') ?? 'Present'}', fontSize: 14, color: Colors.black54,),
                                  labels.label('${val?.degree?.title ?? ''} in ${val?.major ?? 'N/A'}', fontSize: 14, color: Colors.black54,),
                                  labels.label(val?.description ?? 'Description: N/A', fontSize: 14, color: Colors.black54,),
                                ],
                              ),
                            ),
                          ],

                          if((educations ?? []).isEmpty) Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              'A varied education on your resume sums up the value that your learning and background will bring to job.',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),

                          ButtonAddUI(title: 'Educations', status: 'Add', onPressed: () { }),

                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(title: 'Skills', status: 'add', onPressed: () { }),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8.0),
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for(final val in skills ?? []) ...[
                                  labels.label('${val?.title ?? ''} - ${val?.level?.title ?? 'Level: N/A'}', fontSize: 14, color: Colors.black54,),
                                  const SizedBox(height: 4,),
                                ],

                                if((skills ?? []).isEmpty) labels.label(
                                  'Stand out from other candidates with relevant skills.',
                                  fontSize: 14, color: Colors.black54,
                                ),

                              ],
                            ),
                          ),

                          ButtonAddUI(title: 'Skills', status: 'Add', onPressed: () { }),

                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(title: 'Languages', status: 'add', onPressed: () { }),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8.0),
                            child: Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for(final val in languages ?? []) ...[
                                  labels.label('${val?.title ?? ''} - ${val?.level?.title ?? 'Level: N/A'}', fontSize: 14, color: Colors.black54,),
                                  const SizedBox(height: 4,),
                                ],

                                if((languages ?? []).isEmpty) labels.label(
                                  'Add languages to appeal to more companies and employers.',
                                  fontSize: 14, color: Colors.black54,
                                ),
                              ],
                            ),
                          ),

                          ButtonAddUI(title: 'Languages', status: 'Add', onPressed: () { }),

                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(title: 'Hobbies & Interests', status: datum?.hobbies != null ? 'edit' : 'add', onPressed: () { }),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8.0),
                            child: labels.label(datum?.hobbies ?? 'What do you like?', fontSize: 14, color: Colors.black54,),
                          ),

                          ButtonAddUI(title: 'Hobbies & Interests', status: datum?.hobbies != null ? 'Edit' : 'Add', onPressed: () { }),

                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(title: 'References', status: 'add', onPressed: () { }),

                          for(final val in references ?? []) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 8,),
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

                          if((references ?? []).isEmpty) Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              'increase your credibility with trustworthy reference.',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),

                          ButtonAddUI(title: 'References', status: 'Add', onPressed: () { }),

                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, top: 8, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(
                            title: 'Attach file',
                            subTitle: 'Support file type: doc, DOCX, PDF, txt (Max size: 5MB)',
                            status: (attachment?.toJson() ?? {}).isEmpty ? 'add' : null,
                            onPressed: () { },
                          ),

                          if((attachment?.toJson() ?? {}).isNotEmpty) ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            onTap: () { },
                            leading: const Icon(Icons.file_open_outlined, color: Colors.black54, size: 28,),
                            title: labels.label(attachment?.name ?? 'N/A', fontSize: 14, color: Colors.black54,),
                            subtitle: labels.label('${attachment?.size ?? 'N/A'}', fontSize: 11, color: Colors.black54,),
                          )
                          else ButtonAddUI(title: 'Attach file', status: 'Add', onPressed: () { }),

                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.only(left: 14, bottom: 10,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleUI(title: 'Job Preferences', status: (preference?.toJson() ?? {}).isNotEmpty ? 'edit' : 'add', onPressed: () { }),

                          PreferUI(title: 'Open Job', subTitle: preference?.open_job == true ? 'Enable' : 'Disable'),
                          PreferUI(title: 'Preferred Position', subTitle: preference?.position ?? 'N/A'),
                          PreferUI(title: 'Categories', subTitle: (preference?.category?.map((item) => item?.en_name).toList() ?? []).join(', ')),
                          PreferUI(title: 'Location', subTitle: (preference?.location?.map((item) => item?.en_name).toList() ?? []).join(', ')),
                          PreferUI(title: 'Job Type', subTitle: (preference?.job_type?.map((item) => item?.title).toList() ?? []).join(', ')),

                          if((preference?.toJson() ?? {}).isEmpty) Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              'Tell us about your job preferences to let us help you find the job of your dreams quickly.',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),

                          ButtonAddUI(title: 'Job Preferences', status: (preference?.toJson() ?? {}).isNotEmpty ? 'Edit' : 'Add', onPressed: () { }),

                        ],
                      ),
                    ),

                  ],
                ),
              );
            },
          ),

        ])),
      ],
    );
  }
}

class PreferUI extends StatelessWidget {
  const PreferUI({super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.black12, height: 0,),
        ListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          contentPadding: EdgeInsets.zero,
          title: labels.label(title, fontSize: 12, color: Colors.black54,),
          subtitle: labels.label(subTitle, fontSize: 15, color: Colors.black87,),
        ),
      ],
    );
  }
}



class TitleUI extends StatelessWidget {
  const TitleUI({super.key,
    required this.title,
    this.subTitle,
    this.status,
    required this.onPressed,
  });

  final String title;
  final String? subTitle;
  final String? status;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              labels.label(title, fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87,),
              if(subTitle != null) labels.label(subTitle!, fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54,),
            ],
          ),
        ),
        IconButton(onPressed: onPressed, icon: (status != null) ? Icon(
          (status?.toLowerCase() == 'edit') ? CupertinoIcons.pencil_circle : Icons.add_circle_outline,
          color: config.primaryAppColor.shade600, size: 22,) : Container(),
        ),
      ],
    );
  }
}

class ButtonAddUI extends StatelessWidget {
  const ButtonAddUI({super.key,
    required this.title,
    required this.status,
    required this.onPressed,
  });

  final String title;
  final String? status;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return buttons.textButtons(
      title: '$status $title',
      onPressed: onPressed,
      padSize: 8,
      textSize: 14,
      textWeight: FontWeight.w600,
      textColor: config.primaryAppColor.shade600,
      bgColor: Colors.transparent,
      prefixIcon: (status?.toLowerCase() == 'edit') ? CupertinoIcons.pencil_circle : Icons.add_circle_outline,
      prefColor: config.primaryAppColor.shade600,
      prefixSize: 20,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}





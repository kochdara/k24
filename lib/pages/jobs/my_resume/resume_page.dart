


// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/converts.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/jobs/my_resume/educations/educations_page.dart';
import 'package:k24/pages/jobs/my_resume/educations/educations_provider.dart';
import 'package:k24/pages/jobs/my_resume/experiences/experiences_page.dart';
import 'package:k24/pages/jobs/my_resume/experiences/experiences_provider.dart';
import 'package:k24/pages/jobs/my_resume/hobbies/hobbies_page.dart';
import 'package:k24/pages/jobs/my_resume/languages/languages_page.dart';
import 'package:k24/pages/jobs/my_resume/languages/languages_provider.dart';
import 'package:k24/pages/jobs/my_resume/personal_details/personal_details_page.dart';
import 'package:k24/pages/jobs/my_resume/preferences/preference_page.dart';
import 'package:k24/pages/jobs/my_resume/references/references_page.dart';
import 'package:k24/pages/jobs/my_resume/references/references_provider.dart';
import 'package:k24/pages/jobs/my_resume/resume_provider.dart';
import 'package:k24/pages/jobs/my_resume/skills/skills_page.dart';
import 'package:k24/pages/jobs/my_resume/skills/skills_provider.dart';
import 'package:k24/pages/jobs/my_resume/summary/summary_page.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
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
                                  color: ((personalDetails?.phone ?? []).isNotEmpty) ? config.primaryAppColor.shade600 : null,
                                  onTap: () { },
                                ),
                                const SizedBox(height: 6,),
                                LabelIcons(
                                  title: 'Email',
                                  subTitle: personalDetails?.email ?? 'N/A',
                                  icon: Icons.email,
                                  color: (personalDetails?.email != null) ? config.primaryAppColor.shade600 : null,
                                  onTap: () { },
                                ),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Education Level', subTitle: personalDetails?.education_level?.title ?? 'N/A', icon: Icons.school,color: Colors.black87,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Marital Status', subTitle: personalDetails?.marital_status?.title ?? 'N/A', icon: CupertinoIcons.link,color: Colors.black87,),
                                const SizedBox(height: 6,),
                                LabelIcons(title: 'Locations', subTitle: '${personalDetails?.location?.long_location ?? ''} '
                                    '${personalDetails?.address ?? 'N/A'}', icon: Icons.location_on,
                                  color: Colors.black87,
                                ),
                                const SizedBox(height: 10,),

                                // button //
                                buttons.textButtons(
                                  title: 'Edit Personal Information',
                                  onPressed: () {
                                    routeAnimation(context, pageBuilder: const PersonalsDataPage());
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
                                  child: (personalDetails?.photo?.url != null) ? InkWell(
                                    onTap: () => viewImage(context, '${personalDetails?.photo?.url}'),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: placeholder,
                                      image: '${personalDetails?.photo?.url}',
                                      fit: BoxFit.cover,
                                    ),
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
                          TitleUI(title: 'Summary', status: datum?.summary != null ? 'edit' : 'add', onPressed: () {
                            routeAnimation(context, pageBuilder: const SummaryPage());
                          }),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              datum?.summary ?? 'Write 2-4 short & energetic sentences to interest the reader! Mention your role, experience & most importantly-your biggest achievenments, best qualities and skills.',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),

                          // buttons //
                          ButtonAddUI(title: 'Summary', status: datum?.summary != null ? 'Edit' : 'Add', onPressed: () {
                            routeAnimation(context, pageBuilder: const SummaryPage());
                          }),
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
                          TitleUI(title: 'Work Experiences', status: 'add', onPressed: () {
                            routeAnimation(context, pageBuilder: const ExperiencesPage());
                          }),

                          for(int ind=0; ind<(experiences ?? []).length; ind++ ) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 10,),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        labels.label('${experiences?[ind]?.position ?? ''} at ${experiences?[ind]?.company ?? ''}', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600,),
                                        labels.label('${stringToTimeAgoDay(date: '${experiences?[ind]?.start_date}') ?? 'Present'} • ${stringToTimeAgoDay(date: '${experiences?[ind]?.end_date}') ?? 'Present'}', fontSize: 14, color: Colors.black54,),
                                        labels.label(experiences?[ind]?.location?.long_location ?? 'Locations: N/A', fontSize: 14, color: Colors.black54,),
                                        labels.label(experiences?[ind]?.description ?? 'Description: N/A', fontSize: 14, color: Colors.black54,),
                                      ],
                                    ),
                                  ),

                                  IconButton(onPressed: () {
                                    showActionSheet(context, [
                                      if(ind != 0) MoreTypeInfo('Move to Top', 'Move to Top', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${experiences?[ind]?.id}', 'move_to_top');
                                      },),
                                      if(ind != 0) MoreTypeInfo('Move Up', 'Move Up', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${experiences?[ind]?.id}', 'move_up');
                                      },),
                                      if(ind != (experiences ?? []).length - 1) MoreTypeInfo('Move Down', 'Move Down', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${experiences?[ind]?.id}', 'move_down');
                                      },),
                                      if(ind != (experiences ?? []).length - 1) MoreTypeInfo('Move to Bottom', 'Move to Bottom', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${experiences?[ind]?.id}', 'move_to_bottom');
                                      },),
                                      MoreTypeInfo('Edit', 'Edit', CupertinoIcons.pencil_circle, null, () {
                                        routeAnimation(context, pageBuilder: ExperiencesPage(
                                          id: experiences?[ind]?.id,
                                        ));
                                      }),
                                      MoreTypeInfo('Delete', 'Delete', CupertinoIcons.delete, null, () async {
                                        final sendApi = ExperienceApiService();
                                        final result = await sendApi.deleteExperience(ref, '${experiences?[ind]?.id}');
                                        if(result.status == 'success') {
                                          alertSnack(context, '${result.message}');
                                          ref.read(provider.notifier).removeAt('${experiences?[ind]?.id}', 'experiences');
                                        }
                                      },),
                                    ]);
                                  }, icon: const Icon(Icons.more_vert_rounded)),
                                ],
                              ),
                            ),
                          ],

                          if((experiences ?? []).isEmpty) Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              'Show your relevant experience (last 10 years)',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),

                          ButtonAddUI(title: 'Work Experiences', status: 'Add', onPressed: () {
                            routeAnimation(context, pageBuilder: const ExperiencesPage());
                          }),

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
                          TitleUI(title: 'Educations', status: 'add', onPressed: () {
                            routeAnimation(context, pageBuilder: const EducationsPage());
                          }),

                          for(int ind=0; ind<(educations ?? []).length; ind++ ) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 8,),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        labels.label(educations?[ind]?.school ?? 'School: N/A', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600,),
                                        labels.label('${stringToTimeAgoDay(date: '${educations?[ind]?.start_date}') ?? 'Present'} • ${stringToTimeAgoDay(date: '${educations?[ind]?.end_date}') ?? 'Present'}', fontSize: 14, color: Colors.black54,),
                                        labels.label('${educations?[ind]?.degree?.title ?? ''} in ${educations?[ind]?.major ?? 'N/A'}', fontSize: 14, color: Colors.black54,),
                                        labels.label(educations?[ind]?.description ?? 'Description: N/A', fontSize: 14, color: Colors.black54,),
                                      ],
                                    ),
                                  ),

                                  IconButton(onPressed: () {
                                    showActionSheet(context, [
                                      if(ind != 0) MoreTypeInfo('Move to Top', 'Move to Top', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${educations?[ind]?.id}', 'edu_move_to_top');
                                      },),
                                      if(ind != 0) MoreTypeInfo('Move Up', 'Move Up', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${educations?[ind]?.id}', 'edu_move_up');
                                      },),
                                      if(ind != (educations ?? []).length - 1) MoreTypeInfo('Move Down', 'Move Down', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${educations?[ind]?.id}', 'edu_move_down');
                                      },),
                                      if(ind != (educations ?? []).length - 1) MoreTypeInfo('Move to Bottom', 'Move to Bottom', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${educations?[ind]?.id}', 'edu_move_to_bottom');
                                      },),
                                      MoreTypeInfo('Edit', 'Edit', CupertinoIcons.pencil_circle, null, () {
                                        routeAnimation(context, pageBuilder: EducationsPage(
                                          id: educations?[ind]?.id,
                                        ));
                                      }),
                                      MoreTypeInfo('Delete', 'Delete', CupertinoIcons.delete, null, () async {
                                        final sendApi = EducationsApiService();
                                        final result = await sendApi.deleteEducations(ref, '${educations?[ind]?.id}');
                                        if(result.status == 'success') {
                                          alertSnack(context, '${result.message}');
                                          ref.read(provider.notifier).removeAt('${educations?[ind]?.id}', 'educations');
                                        }
                                      },),
                                    ]);
                                  }, icon: const Icon(Icons.more_vert_rounded)),
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

                          ButtonAddUI(title: 'Educations', status: 'Add', onPressed: () {
                            routeAnimation(context, pageBuilder: const EducationsPage());
                          }),

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
                          TitleUI(title: 'Skills', status: 'add', onPressed: () {
                            routeAnimation(context, pageBuilder: const SkillsPage());
                          }),

                          for(int ind=0; ind<(skills ?? []).length; ind++ ) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 0.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: labels.label('${skills?[ind]?.title ?? ''} - ${skills?[ind]?.level?.title ?? 'Level: N/A'}', fontSize: 14, color: Colors.black87,),
                                  ),

                                  IconButton(onPressed: () {
                                    showActionSheet(context, [
                                      if(ind != 0) MoreTypeInfo('Move to Top', 'Move to Top', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${skills?[ind]?.id}', 'skill_move_to_top');
                                      },),
                                      if(ind != 0) MoreTypeInfo('Move Up', 'Move Up', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${skills?[ind]?.id}', 'skill_move_up');
                                      },),
                                      if(ind != (skills ?? []).length - 1) MoreTypeInfo('Move Down', 'Move Down', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${skills?[ind]?.id}', 'skill_move_down');
                                      },),
                                      if(ind != (skills ?? []).length - 1) MoreTypeInfo('Move to Bottom', 'Move to Bottom', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${skills?[ind]?.id}', 'skill_move_to_bottom');
                                      },),
                                      MoreTypeInfo('Edit', 'Edit', CupertinoIcons.pencil_circle, null, () {
                                        routeAnimation(context, pageBuilder: SkillsPage(
                                          id: skills?[ind]?.id,
                                        ));
                                      }),
                                      MoreTypeInfo('Delete', 'Delete', CupertinoIcons.delete, null, () async {
                                        final sendApi = SkillsApiService();
                                        final result = await sendApi.deleteSkills(ref, '${skills?[ind]?.id}');
                                        if(result.status == 'success') {
                                          alertSnack(context, '${result.message}');
                                          ref.read(provider.notifier).removeAt('${skills?[ind]?.id}', 'skills');
                                        }
                                      },),
                                    ]);
                                  }, icon: const Icon(Icons.more_vert_rounded)),
                                ],
                              ),
                            ),
                          ],

                          if((skills ?? []).isEmpty) Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              'Stand out from other candidates with relevant skills.',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),


                          ButtonAddUI(title: 'Skills', status: 'Add', onPressed: () {
                            routeAnimation(context, pageBuilder: const SkillsPage());
                          }),

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
                          TitleUI(title: 'Languages', status: 'add', onPressed: () {
                            routeAnimation(context, pageBuilder: const LanguagesPage());
                          }),

                          for(int ind=0; ind<(languages ?? []).length; ind++ ) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 0.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: labels.label('${languages?[ind]?.title ?? ''} - ${languages?[ind]?.level?.title ?? 'Level: N/A'}', fontSize: 14, color: Colors.black87,),
                                  ),

                                  IconButton(onPressed: () {
                                    showActionSheet(context, [
                                      if(ind != 0) MoreTypeInfo('Move to Top', 'Move to Top', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${languages?[ind]?.id}', 'lang_move_to_top');
                                      },),
                                      if(ind != 0) MoreTypeInfo('Move Up', 'Move Up', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${languages?[ind]?.id}', 'lang_move_up');
                                      },),
                                      if(ind != (languages ?? []).length - 1) MoreTypeInfo('Move Down', 'Move Down', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${languages?[ind]?.id}', 'lang_move_down');
                                      },),
                                      if(ind != (languages ?? []).length - 1) MoreTypeInfo('Move to Bottom', 'Move to Bottom', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${languages?[ind]?.id}', 'lang_move_to_bottom');
                                      },),
                                      MoreTypeInfo('Edit', 'Edit', CupertinoIcons.pencil_circle, null, () {
                                        routeAnimation(context, pageBuilder: LanguagesPage(
                                          id: languages?[ind]?.id,
                                        ));
                                      }),
                                      MoreTypeInfo('Delete', 'Delete', CupertinoIcons.delete, null, () async {
                                        final sendApi = LanguagesApiService();
                                        final result = await sendApi.deleteLanguages(ref, '${languages?[ind]?.id}');
                                        if(result.status == 'success') {
                                          alertSnack(context, '${result.message}');
                                          ref.read(provider.notifier).removeAt('${languages?[ind]?.id}', 'languages');
                                        }
                                      },),
                                    ]);
                                  }, icon: const Icon(Icons.more_vert_rounded)),
                                ],
                              ),
                            ),
                          ],

                          if((languages ?? []).isEmpty) Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              'Add languages to appeal to more companies and employers.',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),

                          ButtonAddUI(title: 'Languages', status: 'Add', onPressed: () {
                            routeAnimation(context, pageBuilder: const LanguagesPage());
                          }),

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
                          TitleUI(title: 'Hobbies & Interests', status: datum?.hobbies != null ? 'edit' : 'add', onPressed: () {
                            routeAnimation(context, pageBuilder: const HobbiesPage());
                          }),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8.0),
                            child: labels.label(datum?.hobbies ?? 'What do you like?', fontSize: 14, color: Colors.black54,),
                          ),

                          ButtonAddUI(title: 'Hobbies & Interests', status: datum?.hobbies != null ? 'Edit' : 'Add', onPressed: () {
                            routeAnimation(context, pageBuilder: const HobbiesPage());
                          }),

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
                          TitleUI(title: 'References', status: 'add', onPressed: () {
                            routeAnimation(context, pageBuilder: const ReferencesPage());
                          }),

                          for(int ind=0; ind<(references ?? []).length; ind++ ) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 8,),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        labels.label(references?[ind]?.name ?? 'N/A', fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600,),
                                        labels.label('${references?[ind]?.position ?? ''} at ${references?[ind]?.company ?? ''}', fontSize: 14, color: Colors.black54,),
                                        labels.label('Tell: ${(references?[ind]?.phone ?? []).join(', ')}', fontSize: 14, color: Colors.black54,),
                                        labels.label('Email: ${references?[ind]?.email ?? 'N/A'}', fontSize: 14, color: Colors.black54,),
                                      ],
                                    ),
                                  ),

                                  IconButton(onPressed: () {
                                    showActionSheet(context, [
                                      if(ind != 0) MoreTypeInfo('Move to Top', 'Move to Top', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${references?[ind]?.id}', 'ref_move_to_top');
                                      },),
                                      if(ind != 0) MoreTypeInfo('Move Up', 'Move Up', Icons.arrow_circle_up, null, () {
                                        ref.read(provider.notifier).removeAt('${references?[ind]?.id}', 'ref_move_up');
                                      },),
                                      if(ind != (references ?? []).length - 1) MoreTypeInfo('Move Down', 'Move Down', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${references?[ind]?.id}', 'ref_move_down');
                                      },),
                                      if(ind != (references ?? []).length - 1) MoreTypeInfo('Move to Bottom', 'Move to Bottom', Icons.arrow_circle_down, null, () {
                                        ref.read(provider.notifier).removeAt('${references?[ind]?.id}', 'ref_move_to_bottom');
                                      },),
                                      MoreTypeInfo('Edit', 'Edit', CupertinoIcons.pencil_circle, null, () {
                                        routeAnimation(context, pageBuilder: ReferencesPage(
                                          id: references?[ind]?.id,
                                        ));
                                      }),
                                      MoreTypeInfo('Delete', 'Delete', CupertinoIcons.delete, null, () async {
                                        final sendApi = ReferencesApiService();
                                        final result = await sendApi.deleteReferences(ref, '${references?[ind]?.id}');
                                        if(result.status == 'success') {
                                          alertSnack(context, '${result.message}');
                                          ref.read(provider.notifier).removeAt('${references?[ind]?.id}', 'references');
                                        }
                                      },),
                                    ]);
                                  }, icon: const Icon(Icons.more_vert_rounded)),
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

                          ButtonAddUI(title: 'References', status: 'Add', onPressed: () {
                            routeAnimation(context, pageBuilder: const ReferencesPage());
                          }),

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
                            contentPadding: EdgeInsets.zero,
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
                          TitleUI(title: 'Job Preferences', status: (preference?.toJson() ?? {}).isNotEmpty ? 'edit' : 'add', onPressed: () {
                            routeAnimation(context, pageBuilder: const PreferencesPage());
                          }),

                          if((preference?.toJson() ?? {}).isNotEmpty) ...[
                            PreferUI(title: 'Open Job', subTitle: preference?.open_job == true ? 'Enable' : 'Disable'),
                            PreferUI(title: 'Preferred Position', subTitle: preference?.position ?? 'N/A'),
                            PreferUI(title: 'Categories', subTitle: (preference?.category != null) ? (preference?.category?.map((item) => item?.en_name).toList() ?? []).join(', ') : 'N/A'),
                            PreferUI(title: 'Location', subTitle: (preference?.location != null) ? (preference?.location?.map((item) => item?.en_name).toList() ?? []).join(', ') : 'N/A'),
                            PreferUI(title: 'Job Type', subTitle: (preference?.job_type != null) ? (preference?.job_type?.map((item) => item?.title).toList() ?? []).join(', ') : 'N/A'),
                          ] else Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 8,),
                            child: labels.label(
                              'Tell us about your job preferences to let us help you find the job of your dreams quickly.',
                              fontSize: 14, color: Colors.black54,
                            ),
                          ),

                          ButtonAddUI(title: 'Job Preferences', status: (preference?.toJson() ?? {}).isNotEmpty ? 'Edit' : 'Add', onPressed: () {
                            routeAnimation(context, pageBuilder: const PreferencesPage());
                          }),

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
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
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
      ),
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





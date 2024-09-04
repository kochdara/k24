
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/jobs/my_resume/personal_details/personal_details_page.dart';
import 'package:k24/pages/jobs/my_resume/resume_page.dart';
import 'package:k24/pages/jobs/my_resume/resume_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../../helpers/config.dart';
import '../../../helpers/functions.dart';
import '../../more_provider.dart';

final myWidgets = MyWidgets();
final labels = Labels();
final config = Config();
final myCards = MyCards();
final buttons = Buttons();

class CheckInfoResumePage extends ConsumerStatefulWidget {
  const CheckInfoResumePage({super.key});

  @override
  ConsumerState<CheckInfoResumePage> createState() => _CheckInfoPageState();
}

class _CheckInfoPageState extends ConsumerState<CheckInfoResumePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = GetResumeInfoProvider(ref);
    final checkResume = ref.watch(provider);
    
    return Scaffold(
      appBar: AppBar(
        title: labels.label('Resume (CV)', fontSize: 20, fontWeight: FontWeight.w500),
        titleSpacing: 6,
        actions: [
          if(checkResume.hasValue) IconButton(onPressed: () async {
            final sendApi = MoreApiService();
            final result = await sendApi.downloadAttachment(ref, {
              'summary': 'true',
              'educations': 'all',
              'experiences': 'all',
              'skills': 'all',
              'languages': 'all',
              'hobbies': 'true',
              'references': 'all',
            });
            if(result?.data != null) {
              alertSnack(context, 'Success');
              await openLinkFunction(result?.data['url'] ?? '');
            }
          }, icon: const Icon(Icons.playlist_add_check_circle_outlined, color: Colors.white70, size: 28,))
        ],
      ),
      backgroundColor: config.backgroundColor,
      body: checkResume.when( //
        error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () => { }),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (data) {
          if(data == null) return VerifyResumeBody();
          return ResumePage(provider: provider,);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class VerifyResumeBody extends ConsumerWidget {
  VerifyResumeBody({super.key,
  });

  final List dataField = [
    'File you personal details',
    'Write a resume summary or objective',
    'List your work experiences',
    'List your languages',
    'List your skills',
    'Write your hobbies & interests',
    'List your references',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildListDelegate([

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Image.asset('assets/img/resume.png', fit: BoxFit.contain,),
                ),

                const SizedBox(height: 10,),
                labels.label('You don\'t have a resume yet', color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600, textAlign: TextAlign.center),
                labels.label('Create online an attractive resume for free, making you stand out from other applicants.', color: Colors.black87, fontSize: 14, textAlign: TextAlign.center),

                const SizedBox(height: 10,),
                for(int i=0; i<dataField.length; i++) ...[
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    leading: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        color: config.primaryAppColor.shade600,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: labels.label('${i+1}', color: Colors.white, fontSize: 14,),
                    ),
                    title: labels.label(dataField[i], color: Colors.black87, fontSize: 14,),
                  ),
                ],
                const SizedBox(height: 10,),

                buttons.textButtons(
                  title: 'Get Start',
                  onPressed: () {
                    routeAnimation(context, pageBuilder: const PersonalsDataPage());
                  },
                  padSize: 9,
                  textSize: 18,
                  radius: 8,
                  textWeight: FontWeight.w500,
                  textColor: Colors.white,
                  bgColor: config.warningColor.shade400,
                ),

              ],
            ),
          )

        ])),
      ],
    );
  }
}





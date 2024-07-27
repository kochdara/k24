
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/jobs/public_resumes/detail_provider.dart';
import 'package:k24/widgets/labels.dart';

import '../../../helpers/converts.dart';
import '../../../serialization/notify/nortify_serial.dart';

final labels = Labels();
final config = Config();

class ReviewResumePage extends ConsumerStatefulWidget {
  const ReviewResumePage({super.key,
    required this.datum,
  });

  final NotifyDatum datum;

  @override
  ConsumerState<ReviewResumePage> createState() => _ReviewResumePageState();
}


class _ReviewResumePageState extends ConsumerState<ReviewResumePage> {
  late NotifyDatum data;

  @override
  void initState() {
    super.initState();
    data = widget.datum;
  }

  @override
  Widget build(BuildContext context) {
    final datum = data;
    final getResume = ref.watch(getDetailsResumeProvider(ref, datum.data?.cv?.id ?? 'N/A'));

    print('object: ${getResume.valueOrNull}');

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
          child: Column(
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
                      leading: Container(
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
                            labels.label(datum.data?.cv?.name ?? 'N/A', fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black87,),
                            const SizedBox(height: 8,),

                            LabelIcons(title: 'Female', subTitle: null, icon: Icons.transgender,),
                            const SizedBox(height: 6,),
                            LabelIcons(title: 'Email', subTitle: '12', icon: Icons.email,)
                          ],
                        ),
                      ),

                      // image //

                    ],
                  ),
                ),
              ),
            ],
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


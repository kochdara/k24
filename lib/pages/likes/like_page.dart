
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../../helpers/config.dart';

final myWidgets = MyWidgets();
final labels = Labels();

class LikesPage extends ConsumerStatefulWidget {
  const LikesPage({super.key});

  @override
  ConsumerState<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends ConsumerState<LikesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LikesBody(),
      backgroundColor: config.backgroundColor,
      bottomNavigationBar: myWidgets.bottomBarPage(
        context, ref, 4, null,
      ),
    );
  }
}

class LikesBody extends StatelessWidget {
  const LikesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Data_();
    double height = 140;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: labels.label('Likes', fontSize: 20, fontWeight: FontWeight.w500),
          titleSpacing: 6,
        ),

        SliverList(delegate: SliverChildListDelegate([
          const SizedBox(height: 12,),

          for(int i=0; i<2; i++)
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: const BorderSide(
                color: Colors.black12,
              ),
            ),
            surfaceTintColor: Colors.white,
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: height,
                    height: height,
                    color: config.secondaryColor.shade50,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(5)),
                      child: ((data.thumbnail ?? '').isNotEmpty) ?
                      FadeInImage.assetNetwork(placeholder: placeholder, image: data.thumbnail ?? '', fit: BoxFit.cover)
                      : Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        color: config.infoColor.shade50, // Color(0xFFE8F5FB),
                        child: labels.label(data.title ?? 'N/A', color: config.infoColor.shade600, fontSize: 14, textAlign: TextAlign.center, maxLines: 3,),
                      ),
                    ),
                  ),

                  Container(
                    height: height,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            labels.label(data.title??'N/A', color: config.secondaryColor.shade900, fontSize: 15, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, maxLines: 2),

                            labels.labelIcon(
                              leftIcon: Icon(Icons.location_on_outlined, size: 12, color: config.secondaryColor.shade200),
                              leftTitle: ' N/A',
                              style: TextStyle(color: config.secondaryColor.shade200, fontSize: 11, fontWeight: FontWeight.normal, fontFamily: 'en', height: lineHeight),
                            ),
                          ],
                        ),

                        labels.label('\$${data.price??'0.00'}', color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12,),

        ])),
      ],
    );
  }
}



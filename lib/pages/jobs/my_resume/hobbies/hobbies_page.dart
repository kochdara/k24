
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/jobs/my_resume/hobbies/hobbies_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

import '../../../more_provider.dart';
import '../check_informations.dart';

final labels = Labels();
final config = Config();
final myCards = MyCards();
final forms = Forms();
final buttons = Buttons();

class HobbiesPage extends ConsumerStatefulWidget {
  const HobbiesPage({super.key});

  @override
  ConsumerState<HobbiesPage> createState() => _HobbiesPageState();
}

class _HobbiesPageState extends ConsumerState<HobbiesPage> {
  final _formKey = GlobalKey<FormState>();
  final StateProvider<Map> newMap = StateProvider((ref) => {});
  final StateProvider<bool> loadings = StateProvider((ref) => true);
  late TextEditingController hobController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hobController = TextEditingController(text: ' ');
    setupPage();
  }

  void setupPage() async {
    await futureAwait(duration: 1000, () {
      ref.read(loadings.notifier).state = false;
      if(mounted) {
        final provider = getHobbiesProvider(ref);
        final summary = ref.watch(provider);
        final datum = summary.valueOrNull;
        if(datum != null) {
          hobController.text = datum is Map ? datum['data'].toString() : datum.toString();
        }
      }
    },);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = getHobbiesProvider(ref);
    final summary = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Hobbies & Interests', fontSize: 20, fontWeight: FontWeight.w500,),
        titleSpacing: 6,
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNav(),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([

            if(ref.watch(loadings)) const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
            ) else summary.when(
              error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () { }),
              loading: () => const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator()),
              ),
              data: (data) {
                return Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [

                        forms.labelFormFields(
                          labelText: 'Hobbies & Interests',
                          controller: hobController,
                          onChanged: (val) => updateNewMap('hobbies', val),
                          maxLines: 15,
                        ),

                      ],
                    ),
                  ),
                );
              }
            ),

          ])),
        ],
      ),
    );
  }

  void updateNewMap(String key, dynamic val) {
    ref.read(newMap.notifier).update((state) {
      return {...state, key: val};
    });
    print(ref.watch(newMap));
  }

  Widget bottomNav() {
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
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: width,
                    child: buttons.textButtons(
                      title: 'Save',
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          final sendApi = HobbiesApiService();
                          Map<String, dynamic> data = {
                            'hobbies': hobController.text,
                          };
                          final result = await sendApi.submitHobbies(ref, data);
                          if(result != null && result['status'] == 'success') {
                            alertSnack(context, result['message'] ?? 'Save successful.');
                            routeAnimation(context, pageBuilder: const CheckInfoResumePage());
                          }
                        }
                      },
                      padSize: 10,
                      textSize: 18,
                      textWeight: FontWeight.w500,
                      textColor: Colors.white,
                      bgColor: config.warningColor.shade400,
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}



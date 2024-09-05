
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/accounts/check_login.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/pages/settings/privacy/privacy_provider.dart';
import 'package:k24/pages/settings/settings_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_cards.dart';

final labels = Labels();
final config = Config();
final forms = Forms();
final buttons = Buttons();
final myCards = MyCards();

class PrivacyPage extends ConsumerStatefulWidget {
  const PrivacyPage({super.key,
  });

  @override
  ConsumerState<PrivacyPage> createState() => _PrivacyPageState();
}

Future<void> submitDataForms(WidgetRef ref, String type, String val, GetPrivacyProvider provider) async {
  final sendApi = SettingsApiService();
  final res = await sendApi.dataSubmit(ref.context, ref, 'privacy', { type: val });
  if(res?.status == 'success') {
    alertSnack(ref.context, res?.message ?? 'Saved success');
    ref.read(provider.notifier).updateAt(type, val);
  } else {
    myWidgets.showAlert(ref.context, res?.message ?? 'Warning about submit key!.', title: 'Alert',);

  }
}

class _PrivacyPageState extends ConsumerState<PrivacyPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = getPrivacyProvider(ref);
    final getPro = ref.watch(provider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: labels.label('Privacy', fontSize: 20, color: Colors.white,),
      ),
      backgroundColor: config.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([

            getPro.when(
              error: (e, st) => myCards.notFound(context, id: '', message: '$e', onPressed: () {}),
              loading: () => const SizedBox(
                height: 350,
                child: Center(child: CircularProgressIndicator()),
              ),
              data: (data) {
                final datum = data?.data;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// for gender ///
                    ListTile(
                      onTap: () => showActionSheet(context, [
                        MoreTypeInfo('public', 'Public', null, null, () => submitDataForms(ref, 'gender', 'public', provider)),
                        MoreTypeInfo('only_me', 'Only Me', null, null, () => submitDataForms(ref, 'gender', 'private', provider)),
                      ]),
                      tileColor: Colors.white,
                      shape: const Border(bottom: BorderSide(color: Colors.black12,)),
                      title: labels.label('Who can look you up using the Gender you provided?', fontSize: 15, color: Colors.black87,),
                      subtitle: InkWell(
                        child: labels.label(datum?.gender == 'private' ? 'Only Me' : 'Public', fontSize: 14, color: Colors.blue.shade500, fontWeight: FontWeight.w600,),
                      ),
                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black54, size: 28,),
                    ),

                    ListTile(
                      onTap: () => showActionSheet(context, [
                        MoreTypeInfo('public', 'Public', null, null, () => submitDataForms(ref, 'dob', 'public', provider)),
                        MoreTypeInfo('only_me', 'Only Me', null, null, () => submitDataForms(ref, 'dob', 'private', provider)),
                      ]),
                      tileColor: Colors.white,
                      shape: const Border(bottom: BorderSide(color: Colors.black12,)),
                      title: labels.label('Who can look you up using the Date Of Birth you provided?', fontSize: 15, color: Colors.black87,),
                      subtitle: InkWell(
                        child: labels.label(datum?.dob == 'private' ? 'Only Me' : 'Public', fontSize: 14, color: Colors.blue.shade500, fontWeight: FontWeight.w600,),
                      ),
                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black54, size: 28,),
                    ),

                    ListTile(
                      onTap: () => showActionSheet(context, [
                        MoreTypeInfo('public', 'Public', null, null, () => submitDataForms(ref, 'phone', 'public', provider)),
                        MoreTypeInfo('only_me', 'Only Me', null, null, () => submitDataForms(ref, 'phone', 'private', provider)),
                      ]),
                      tileColor: Colors.white,
                      shape: const Border(bottom: BorderSide(color: Colors.black12,)),
                      title: labels.label('Who can look you up using the Phone you provided?', fontSize: 15, color: Colors.black87,),
                      subtitle: InkWell(
                        child: labels.label(datum?.phone == 'private' ? 'Only Me' : 'Public', fontSize: 14, color: Colors.blue.shade500, fontWeight: FontWeight.w600,),
                      ),
                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black54, size: 28,),
                    ),

                    ListTile(
                      onTap: () => showActionSheet(context, [
                        MoreTypeInfo('public', 'Public', null, null, () => submitDataForms(ref, 'email', 'public', provider)),
                        MoreTypeInfo('only_me', 'Only Me', null, null, () => submitDataForms(ref, 'email', 'private', provider)),
                      ]),
                      tileColor: Colors.white,
                      shape: const Border(bottom: BorderSide(color: Colors.black12,)),
                      title: labels.label('Who can look you up using the Email you provided?', fontSize: 14, color: Colors.black87,),
                      subtitle: InkWell(
                        child: labels.label(datum?.email == 'private' ? 'Only Me' : 'Public', fontSize: 14, color: Colors.blue.shade500, fontWeight: FontWeight.w600,),
                      ),
                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black54, size: 28,),
                    ),

                    ListTile(
                      onTap: () => showActionSheet(context, [
                        MoreTypeInfo('public', 'Public', null, null, () => submitDataForms(ref, 'location', 'public', provider)),
                        MoreTypeInfo('only_me', 'Only Me', null, null, () => submitDataForms(ref, 'location', 'private', provider)),
                      ]),
                      tileColor: Colors.white,
                      shape: const Border(bottom: BorderSide(color: Colors.black12,)),
                      title: labels.label('Who can look you up using the Location you provided?', fontSize: 15, color: Colors.black87,),
                      subtitle: InkWell(
                        child: labels.label(datum?.location == 'private' ? 'Only Me' : 'Public', fontSize: 14, color: Colors.blue.shade500, fontWeight: FontWeight.w600,),
                      ),
                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black54, size: 28,),
                    ),

                  ],
                );
              },
            ),

          ])),
        ],
      ),
    );
  }
}



// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/accounts/check_login.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/pages/settings/settings_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';

final labels = Labels();
final config = Config();
final forms = Forms();
final buttons = Buttons();

class EditUsernamePage extends ConsumerStatefulWidget {
  const EditUsernamePage({super.key,
    required this.oldUsername,
  });

  final String oldUsername;

  @override
  ConsumerState<EditUsernamePage> createState() => _EditUsernamePageState();
}

class _EditUsernamePageState extends ConsumerState<EditUsernamePage> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode userNode;
  late TextEditingController userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNode = FocusNode();
    userController = TextEditingController(text: widget.oldUsername ?? '');
  }

  @override
  Widget build(BuildContext context) {

    double height = 15;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: labels.label('Edit Username', fontSize: 20, color: Colors.white,),
      ),
      backgroundColor: config.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18,),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labels.label('You\'ll use the new username to access your account', fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500,),
                    SizedBox(height: height,),

                    forms.labelFormFields(
                      labelText: 'Username',
                      focusNode: userNode,
                      controller: userController,
                      validator: ValidationBuilder().required().build(),
                      onChanged: (val) { },
                    ),
                    SizedBox(height: height * 2,),

                    buttons.textButtons(
                      title: 'Submit',
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          final sendApi = SettingsApiService();
                          Map<String, dynamic> data = {
                            'username': userController.text,
                          };
                          final result = await sendApi.dataSubmit(context, ref, 'change_username', data);
                          if(result?.status == 'success') {
                            alertSnack(context, result?.message ?? 'Success');
                            Navigator.of(context).pop(userController.text);

                          } else {
                            myWidgets.showAlert(context, result?.message ?? 'Please check username again!.', title: 'Alert',);

                          }

                        } else {
                          alertSnack(context, 'Please check validate again!.');

                        }
                       },
                      padSize: 12,
                      textSize: 15,
                      textWeight: FontWeight.w600,
                      textColor: Colors.white,
                      bgColor: config.warningColor.shade400,
                    ),

                  ],
                ),
              ),
            )

          ])),
        ],
      ),
    );
  }
}


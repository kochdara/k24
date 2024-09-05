
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
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

class EditPhonePage extends ConsumerStatefulWidget {
  const EditPhonePage({super.key,
    required this.oldPhone,
  });

  final dynamic oldPhone;

  @override
  ConsumerState<EditPhonePage> createState() => _EditPhonePageState();
}

class _EditPhonePageState extends ConsumerState<EditPhonePage> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode phoneNode;
  late TextEditingController phoneController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNode = FocusNode();
    final phone = (widget.oldPhone is List) ? widget.oldPhone.first : '';
    phoneController = TextEditingController(text: phone);
  }

  @override
  Widget build(BuildContext context) {

    double height = 15;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: labels.label('Change Activate Phone', fontSize: 20, color: Colors.white,),
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
                    labels.label('Please enter your phone number in the box below to verify your phone number. We will send the verification code to your device.', fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500,),
                    SizedBox(height: height,),

                    forms.labelFormFields(
                      labelText: 'Phone',
                      focusNode: phoneNode,
                      controller: phoneController,
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
                            'phone': phoneController.text,
                          };
                          final result = await sendApi.dataSubmit(context, ref, 'set_new_phone', data);
                          if(result?.status == 'success') {
                            alertSnack(context, result?.message ?? 'Success');
                            Navigator.of(context).pop(phoneController.text);

                          } else if(result?.next_page?.page != null) {
                            /// confirm page ///
                            routeNoAnimation(context, pageBuilder: ConfirmEditPhonePage(oldPhone: [phoneController.text]));

                          } else {
                            myWidgets.showAlert(context, result?.message ?? 'Please check phone number again!.', title: 'Alert',);

                          }
                          print(result?.toJson());

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

class ConfirmEditPhonePage extends ConsumerStatefulWidget {
  const ConfirmEditPhonePage({super.key,
    required this.oldPhone,
  });

  final dynamic oldPhone;

  @override
  ConsumerState<ConfirmEditPhonePage> createState() => _ConfirmEditPhonePageState();
}

class _ConfirmEditPhonePageState extends ConsumerState<ConfirmEditPhonePage> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode codeNode;
  late TextEditingController codeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeNode = FocusNode();
    codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final phone = (widget.oldPhone is List) ? widget.oldPhone.first : '';

    double height = 15;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: labels.label('Confirm Phone', fontSize: 20, color: Colors.white,),
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
                    labels.label(phone, fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w600,),

                    labels.label('We just sent the verify code to $phone. Enter the code from that massage here', fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500,),
                    SizedBox(height: height,),

                    forms.labelFormFields(
                      labelText: 'Verify Code',
                      focusNode: codeNode,
                      controller: codeController,
                      validator: ValidationBuilder().required().build(),
                      onChanged: (val) { },
                      maxLength: 4,
                    ),
                    SizedBox(height: height * 2,),

                    buttons.textButtons(
                      title: 'Verify',
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          final sendApi = SettingsApiService();
                          Map<String, dynamic> data = {
                            'code': codeController.text,
                          };
                          final result = await sendApi.dataSubmit(context, ref, 'verify_new_phone', data);
                          if(result?.status == 'success') {
                            alertSnack(context, result?.message ?? 'Success');
                            Navigator.of(context).pop(phone); /// back to edit phone ///
                            Navigator.of(context).pop(phone); /// back to profile ///

                          } else {
                            myWidgets.showAlert(context, result?.message ?? 'Please check phone number again!.', title: 'Alert',);

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


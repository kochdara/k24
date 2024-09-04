
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';

final labels = Labels();
final config = Config();
final forms = Forms();
final buttons = Buttons();

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late StateProvider<bool> obscureText;
  late FocusNode passwordNode;
  late FocusNode conPasswordNode;
  late TextEditingController passController;
  late TextEditingController conPassController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = StateProvider((ref) => true,);
    passwordNode = FocusNode();
    conPasswordNode = FocusNode();
    passController = TextEditingController();
    conPassController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    double height = 15;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: labels.label('Change Password', fontSize: 20, color: Colors.white,),
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
                    labels.label('You\'ll use this password to access your account', fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500,),
                    SizedBox(height: height,),

                    forms.labelFormFields(
                      labelText: 'New Password',
                      focusNode: passwordNode,
                      controller: passController,
                      obscureText: ref.watch(obscureText),
                      validator: ValidationBuilder().minLength(8).maxLength(50).build(),
                      onChanged: (val) { },
                      suffixIcon: IconButton(
                        onPressed: () => ref.read(obscureText.notifier).state = !ref.watch(obscureText),
                        icon: Icon(ref.watch(obscureText) ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 24, color: config.secondaryColor.shade200),
                      ),
                    ),
                    SizedBox(height: height,),

                    forms.labelFormFields(
                      labelText: 'Confirm Password',
                      focusNode: conPasswordNode,
                      controller: conPassController,
                      obscureText: ref.watch(obscureText),
                      validator: ValidationBuilder().minLength(8).maxLength(50).build(),
                      onChanged: (val) { },
                      suffixIcon: IconButton(
                        onPressed: () => ref.read(obscureText.notifier).state = !ref.watch(obscureText),
                        icon: Icon(ref.watch(obscureText) ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 24, color: config.secondaryColor.shade200),
                      ),
                    ),
                    SizedBox(height: height * 2,),

                    buttons.textButtons(
                      title: 'Submit',
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          //
                        } else {
                          alertSnack(context, 'Please check validate again!.');
                        }
                       },
                      padSize: 10,
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


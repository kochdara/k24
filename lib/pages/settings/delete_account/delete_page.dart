
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_widgets.dart';

import '../settings_provider.dart';

final labels = Labels();
final config = Config();
final forms = Forms();
final buttons = Buttons();
final myWidgets = MyWidgets();

class DeleteAccountPage extends ConsumerStatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  ConsumerState<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends ConsumerState<DeleteAccountPage> {
  final _formKey = GlobalKey<FormState>();
  late StateProvider<bool> obscureText;
  late FocusNode passwordNode;
  late TextEditingController passController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = StateProvider((ref) => true,);
    passwordNode = FocusNode();
    passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final userPro = ref.watch(usersProvider);
    double height = 20;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: labels.label('Delete account', fontSize: 20, color: Colors.white,),
      ),
      backgroundColor: config.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labels.label('${userPro.user?.name}: Delete this account?', fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w600,),
                  SizedBox(height: height,),

                  labels.label('Your account will be deactivated and won\'t be visible to the public.'
                      ' During deactivation, you can reactivate your account anytime. After 90 days,'
                      ' your data will be deleted permanently.',
                    fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500,
                  ),

                ],
              ),
            )

          ])),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4,),
        child: buttons.textButtons(
          title: 'Delete',
          onPressed: () => _dialogBuilder(ref, context),
          padSize: 12,
          textSize: 15,
          textWeight: FontWeight.w600,
          textColor: Colors.white,
          bgColor: config.dangerColor.shade600,
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(WidgetRef ref, BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          content: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListForms(
              passController: passController,
              passwordNode: passwordNode,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600,),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Delete',style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,),),
              onPressed: () async {
                if(_formKey.currentState!.validate()) {
                  final sendApi = SettingsApiService();
                  Map<String, dynamic> data = {'password': passController.text,};
                  final result = await sendApi.dataSubmit(context, ref, 'deactivate', data);
                  if(result?.status == 'success') {
                    alertSnack(context, result?.message ?? 'Success');
                    Navigator.of(context).pop(); /// back to delete page
                    Navigator.of(context).pop(); /// back to profile page

                  } else {
                    myWidgets.showAlert(context, result?.message ?? 'Please check password again!.', title: 'Alert',);

                  }

                } else {
                  alertSnack(context, 'Please check validate again!.');

                }
              },
            ),
          ],
        );
      },
    );
  }
}

class ListForms extends StatefulWidget {
  const ListForms({super.key,
    required this.passwordNode,
    required this.passController,
  });

  final FocusNode passwordNode;
  final TextEditingController passController;

  @override
  State<ListForms> createState() => _ListFormsState();
}

class _ListFormsState extends State<ListForms> {
  bool obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        labels.label('I would like to inform you that, you attempt to delete your account!', fontSize: 15, color: Colors.black87,),
        const SizedBox(height: 15,),

        forms.labelFormFields(
          labelText: 'Password',
          focusNode: widget.passwordNode,
          controller: widget.passController,
          obscureText: obscureText,
          validator: ValidationBuilder().minLength(8).maxLength(50).build(),
          onChanged: (val) { },
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 24, color: config.secondaryColor.shade200),
          ),
        ),
      ],
    );
  }
}




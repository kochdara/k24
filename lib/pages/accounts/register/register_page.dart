
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/accounts/check_login.dart';
import 'package:k24/pages/accounts/login/login.dart';
import 'package:k24/pages/accounts/register/register_provider.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/accounts/register/register_serial.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:form_validator/form_validator.dart';

import '../../../helpers/config.dart';

final Labels labels = Labels();
final Forms forms = Forms();
final Buttons buttons = Buttons();
final Config config = Config();

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key,});

  @override
  ConsumerState<RegisterPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final StateProvider<Map<String, dynamic>> newMap = StateProvider((ref) => {});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(newMap);
    final read = ref.read(newMap.notifier);
    final sendData = RegisterApiService();

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Register', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        titleSpacing: 8,
      ),
      backgroundColor: config.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 14,),

                    labels.label('Please enter your phone number and we\'ll send the code to register your new account.', fontSize: 16, color: Colors.black87, textAlign: TextAlign.center),
                    const SizedBox(height: 14,),

                    forms.labelFormFields(
                      hintText: '090-7413-15',
                      labelText: 'Phone Number',
                      validator: ValidationBuilder().minLength(8).build(),
                      keyboardType: const TextInputType.numberWithOptions(),
                      onChanged: (val) => read.state['phone'] = val,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const SizedBox(height: 18,),

                    buttons.textButtons(
                      title: 'Submit',
                      onPressed: () async {
                        String phone = watch['phone'] ?? '';
                        if(formKey.currentState!.validate()) {
                          final result = await sendData.checkAccount(context, ref, {
                            'login': phone,
                          });
                          /// already account to login ///
                          if(result?.name != null || result?.photo != null) {
                            routeAnimation(context, pageBuilder: LoginPage(
                              log: phone,
                            ));
                            /// not have account to register /// 000 is for check valid phone
                          } else if(result?.id != '000') {
                            routeAnimation(context, pageBuilder: BodyRegister(
                              newMap: newMap,
                            ));
                          }

                        }
                      },
                      textSize: 16,
                      padSize: 11,
                      textColor: Colors.white,
                      textWeight: FontWeight.w500,
                      bgColor: config.warningColor.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }
}


class BodyRegister extends ConsumerStatefulWidget {
  const BodyRegister({super.key,
    required this.newMap,
  });

  final StateProvider<Map<String, dynamic>> newMap;

  @override
  ConsumerState<BodyRegister> createState() => _BodyRegisterState();
}

class _BodyRegisterState extends ConsumerState<BodyRegister> {
  final StateProvider<GlobalKey<FormState>> formKeyPro = StateProvider((ref) => GlobalKey<FormState>());
  late StateProvider<bool> obscureText = StateProvider((ref) => true);

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setupPage() {
    futureAwait(duration: 10, () {
      ref.watch(widget.newMap).forEach((key, value) {
        if(key != 'phone') updatedMap(key, null);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sendData = RegisterApiService();
    final nMap = widget.newMap;
    final watch = ref.watch(nMap);
    final watchForm = ref.watch(formKeyPro);

    final pass = watch['password'] ?? '';
    final conPass = watch['con_password'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Register', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        titleSpacing: 8,
        actions: [
          IconButton(
            onPressed: () { },
            alignment: Alignment.center,
            icon: labels.label('Settings', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      backgroundColor: config.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            Form(
              key: watchForm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    /// profile //
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: config.borderColor),
                      ),
                      child: Icon(Icons.person, size: 60, color: config.secondaryColor.shade100),
                    ),

                    const SizedBox(height: 40),

                    forms.labelFormFields(
                      hintText: 'Sam Eng',
                      labelText: 'First Name',
                      validator: ValidationBuilder().minLength(1).maxLength(50).build(),
                      onChanged: (val) => updatedMap('first_name', val),
                    ),
                    const SizedBox(height: 14,),

                    forms.labelFormFields(
                      hintText: 'Eath',
                      labelText: 'Last Name',
                      validator: ValidationBuilder().minLength(1).maxLength(50).build(),
                      onChanged: (val) => updatedMap('last_name', val),
                    ),
                    const SizedBox(height: 14,),

                    forms.labelFormFields(
                      hintText: '. . . . . . . .',
                      labelText: 'Password',
                      validator: ValidationBuilder().minLength(8).maxLength(50).build(),
                      onChanged: (val) => updatedMap('password', val),
                      obscureText: ref.watch(obscureText),
                      suffixIcon: IconButton(
                        onPressed: () => ref.read(obscureText.notifier).state = !ref.watch(obscureText),
                        icon: ref.watch(obscureText) ? Icon(Icons.visibility_outlined, size: 24, color: config.secondaryColor.shade200)
                            :  Icon(Icons.visibility_off_outlined, size: 24, color: config.secondaryColor.shade200),
                      ),
                    ),
                    const SizedBox(height: 14,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        forms.labelFormFields(
                          hintText: '. . . . . . . .',
                          labelText: 'Confirm Password',
                          validator: ValidationBuilder().minLength(8).maxLength(50).build(),
                          onChanged: (val) => updatedMap('con_password', val),
                          obscureText: ref.watch(obscureText),
                          suffixIcon: IconButton(
                            onPressed: () => ref.read(obscureText.notifier).state = !ref.watch(obscureText),
                            icon: ref.watch(obscureText) ? Icon(Icons.visibility_outlined, size: 24, color: config.secondaryColor.shade200)
                                :  Icon(Icons.visibility_off_outlined, size: 24, color: config.secondaryColor.shade200),
                          ),
                        ),

                        if(pass.length >= 6 && conPass.length >= 6 && pass.compareTo(conPass) != 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            child: labels.label('Password is not match. Please check again.', color: Colors.red.shade800, fontSize: 12, maxLines: 1),
                          ),
                      ],
                    ),
                    const SizedBox(height: 18,),

                    buttons.textButtons(
                      title: 'Submit',
                      onPressed: () async {
                        if(watchForm.currentState!.validate() && pass.compareTo(conPass) == 0) {
                          final result = await sendData.submitRegisterAccount(context, ref, watch);
                          if(result?.next_page?.token != null) {
                            routeAnimation(context, pageBuilder: ConfirmPage(
                              registerData: result, newMap: widget.newMap,
                            ));
                          } else {
                            myWidgets.showAlert(context, result?.next_page?.message ?? 'N/A', title: result?.message ?? 'Alert');
                          }
                        }
                      },
                      textSize: 16,
                      padSize: 11,
                      textColor: Colors.white,
                      textWeight: FontWeight.w500,
                      bgColor: config.warningColor.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }

  void updatedMap(String key, String? val) {
    setState(() {
      ref.read(widget.newMap.notifier).update((state) {
        return { ...state, ...{ key: val } };
      });
    });
  }
}




class ConfirmPage extends ConsumerStatefulWidget {
  const ConfirmPage({super.key,
    required this.registerData,
    required this.newMap,
  });

  final RegisterSerial? registerData;
  final StateProvider<Map<String, dynamic>> newMap;

  @override
  ConsumerState<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends ConsumerState<ConfirmPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(widget.newMap);
    final read = ref.read(widget.newMap.notifier);
    final sendData = RegisterApiService();
    final confirmData = widget.registerData;

    return Scaffold(
      appBar: AppBar(
        title: labels.label('Confirm', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        titleSpacing: 8,
      ),
      backgroundColor: config.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 14,),

                    labels.label(confirmData?.message ?? 'N/A', fontSize: 16, color: Colors.black87, textAlign: TextAlign.center),
                    const SizedBox(height: 14,),

                    forms.labelFormFields(
                      hintText: '1234',
                      labelText: 'OPT Code',
                      validator: ValidationBuilder().minLength(4).build(),
                      keyboardType: const TextInputType.numberWithOptions(),
                      onChanged: (val) => read.state['code'] = val,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 4,
                    ),
                    const SizedBox(height: 18,),

                    buttons.textButtons(
                      title: 'Submit',
                      onPressed: () async {
                        if(formKey.currentState!.validate()) {
                          final result = await sendData.submitOPTCode(
                            context, ref, watch,
                            accessToken: confirmData?.next_page?.token,
                          );
                          if(result?.data?.user != null) {
                            ref.read(usersProvider.notifier).update((state) => result?.data ?? DataUser());
                            // direct to home page
                            Navigator.of(context).popUntil((route) => route.isFirst);
                            alertSnack(ref.context, 'User created successfully!');
                          }
                          print(result?.toJson());
                        }
                      },
                      textSize: 16,
                      padSize: 11,
                      textColor: Colors.white,
                      textWeight: FontWeight.w500,
                      bgColor: config.warningColor.shade400,
                    ),
                  ],
                ),
              ),
            ),
          ])),
        ],
      ),
    );
  }
}


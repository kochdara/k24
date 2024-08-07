
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/accounts/login/login_provider.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:form_validator/form_validator.dart';

import '../../../helpers/config.dart';
import '../../../serialization/users/user_serial.dart';

final Labels labels = Labels();
final Forms forms = Forms();
final Buttons buttons = Buttons();
final Config config = Config();

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<LoginPage> {
  StateProvider<bool> obscureText = StateProvider((ref) => true);
  final _formKey = GlobalKey<FormState>();
  final StateProvider<Map<String, dynamic>> loginAuth = StateProvider((ref) => {});
  final StateProvider<MessageLogin> loginMessage = StateProvider((ref) => MessageLogin());
  final loginNode = FocusNode();
  final passwordNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: BodyProfile(
        ref,
        obscureText: obscureText,
        formKey: _formKey,
        loginAuth: loginAuth,
        loginMessage: loginMessage,
        loginNode: loginNode,
        passwordNode: passwordNode,
      ),
    );
  }
}

class BodyProfile extends StatelessWidget {
  BodyProfile(this.ref, {super.key, required this.obscureText, required this.formKey,
    required this.loginAuth,
    required this.loginMessage,
    required this.loginNode,
    required this.passwordNode,
  });

  final WidgetRef ref;
  final GlobalKey<FormState> formKey;
  final StateProvider<bool> obscureText;
  final StateProvider<Map<String, dynamic>> loginAuth;
  final StateProvider<MessageLogin> loginMessage;
  final apiServiceProvider = Provider((ref) => MyApiService());
  final FocusNode loginNode;
  final FocusNode passwordNode;

  @override
  Widget build(BuildContext context) {
    final watchAuth = ref.watch(loginAuth);
    final watchMessage = ref.watch(loginMessage);

    return CustomScrollView(
      slivers: [
        /// app bar ///
        SliverAppBar(
          pinned: true,
          title: labels.label(
            'Login',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.all(12),
              onPressed: () { },
              icon: const Icon(Icons.settings, color: Colors.white, size: 28),
            ),
          ],
        ),

        /// body //
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1, (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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

                  /// form //
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // phone //
                        forms.labelFormFields(
                          labelText: 'Phone Number or Username',
                          autofocus: true,
                          focusNode: loginNode,
                          textInputAction: TextInputAction.next,
                          validator: ValidationBuilder().minLength(3).maxLength(50).build(),
                          onChanged: (val) {
                            ref.read(loginMessage.notifier).update((state) => MessageLogin());
                            ref.read(loginAuth.notifier).update((state) => {...state, ...{'login': val}});
                          },
                        ),

                        if(watchAuth['login'] != null && (watchAuth['login'].toString().length >= 3
                            || watchAuth['login'].toString().length <= 50) && watchMessage.errors?.login?.message != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: labels.label('${watchMessage.errors?.login?.message}', color: Colors.red.shade800, fontSize: 12),
                          ),

                        const SizedBox(height: 20),

                        // phone //
                        forms.labelFormFields(
                          labelText: 'Password',
                          focusNode: passwordNode,
                          obscureText: ref.watch(obscureText),
                          validator: ValidationBuilder().minLength(8).maxLength(50).build(),
                          onChanged: (val) {
                            ref.read(loginMessage.notifier).update((state) => MessageLogin());
                            ref.read(loginAuth.notifier).update((state) => {...state, ...{'password': val}});
                          },
                          suffixIcon: IconButton(
                            onPressed: () => ref.read(obscureText.notifier).state = !ref.watch(obscureText),
                            icon: ref.watch(obscureText) ? Icon(Icons.visibility_outlined, size: 24, color: config.secondaryColor.shade200)
                            :  Icon(Icons.visibility_off_outlined, size: 24, color: config.secondaryColor.shade200),
                          ),
                          onFieldSubmitted: (val) => onSubmit(context,
                            ref,
                            loginAuth,
                            loginMessage,
                            formKey,
                            apiServiceProvider,
                            loginNode,
                            passwordNode,
                          ),
                        ),

                        if(watchAuth['password'] != null && (watchAuth['password'].toString().length >= 8
                            || watchAuth['password'].toString().length <= 50) && watchMessage.errors?.password?.message != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: labels.label('${watchMessage.errors?.password?.message}', color: Colors.red.shade800, fontSize: 12),
                          ),

                        const SizedBox(height: 15),

                        // forgot password //
                        InkWell(
                          onTap: () { },
                          child: labels.label(
                            'Forgot Password?',
                            color: config.primaryAppColor.shade600,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// apply ///
                  buttons.textButtons(
                    title: 'Submit',
                    onPressed: () => onSubmit(context,
                      ref,
                      loginAuth,
                      loginMessage,
                      formKey,
                      apiServiceProvider,
                      loginNode,
                      passwordNode,
                    ),
                    padSize: 14,
                    textSize: 16,
                    radius: 6,
                    textWeight: FontWeight.w500,
                    textColor: Colors.white,
                    bgColor: config.warningColor.shade400,
                  ),

                ],
              ),
            );
          },
          ),
        )

      ],
    );
  }
}


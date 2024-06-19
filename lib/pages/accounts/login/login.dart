
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/accounts/login/login_provider.dart';
import 'package:k24/pages/details/details_post.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:form_validator/form_validator.dart';

import '../../../helpers/config.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.backgroundColor,
      body: BodyProfile(
        ref,
        obscureText: obscureText,
        formKey: _formKey,
        loginAuth: loginAuth,
      ),
    );
  }
}

class BodyProfile extends StatelessWidget {
  BodyProfile(this.ref, {super.key, required this.obscureText, required this.formKey,
    required this.loginAuth});

  final WidgetRef ref;
  final GlobalKey<FormState> formKey;
  final StateProvider<bool> obscureText;
  final StateProvider<Map<String, dynamic>> loginAuth;
  final apiServiceProvider = Provider((ref) => MyApiService());

  void onSubmit(BuildContext context) async {
    final data = ref.watch(loginAuth);
    if(formKey.currentState!.validate()) {
      try {
        final response = await ref.read(apiServiceProvider).submitData(data);

        myWidgets.showAlert(context, '${response.data?.toJson()}');
      } on Exception catch (e) {
        print('Error submitting data: $e');
        myWidgets.showAlert(context, '$e');

      }

    }
  }

  @override
  Widget build(BuildContext context) {
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        // phone //
                        forms.labelFormFields(
                          'Phone Number or Username',
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          validator: ValidationBuilder().minLength(3).maxLength(50).build(),
                          onChanged: (val) => ref.read(loginAuth.notifier).update((state) => {...state, ...{'login': val}}),
                        ),

                        const SizedBox(height: 20),

                        // phone //
                        forms.labelFormFields(
                          'Password',
                          obscureText: ref.watch(obscureText),
                          validator: ValidationBuilder().minLength(8).maxLength(50).build(),
                          onChanged: (val) => ref.read(loginAuth.notifier).update((state) => {...state, ...{'password': val}}),
                          suffixIcon: IconButton(
                            onPressed: () => ref.read(obscureText.notifier).state = !ref.watch(obscureText),
                            icon: ref.watch(obscureText) ? Icon(Icons.visibility_outlined, size: 26, color: config.secondaryColor.shade300)
                            :  Icon(Icons.visibility_off_outlined, size: 26, color: config.secondaryColor.shade300),
                          ),
                          onFieldSubmitted: (val) => onSubmit(context),
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
                    onPressed: () => onSubmit(context),
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



// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/chats/chat_page.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/users/user_serial.dart';

import '../../../widgets/dialog_builder.dart';
import '../../main/home_provider.dart';

class MyApiService {
  final Dio dio = Dio();

  Future submitData(Map<String, dynamic> data, WidgetRef ref, { required BuildContext context }) async {
    dialogBuilder(context);

    final formData = FormData.fromMap(data);

    final subs = 'auth/login?lang=$lang';

    try {
      final res = await dio.post('$baseUrl/$subs', data: formData);

      final resp = UserSerial.fromJson(res.data ?? {});
      await saveSecure('user', resp.data?.toJson() ?? {});
      ref.read(usersProvider.notifier).update((state) => DataUser.fromJson(resp.data?.toJson() ?? {}));

      /// close dialog ///
      Navigator.pop(context);

      return res.data;
    } on DioError catch (e) {
      /// close dialog ///
      Navigator.pop(context);

      if (e.response != null) {
        // Handle DioError with response
        return e.response?.data;
      } else {
        // load dialog error
        myWidgets.showAlert(context, '$e');
      }

    }
  }

  Future<Tokens> getNewToken(WidgetRef ref) async {
    final tokens = ref.watch(usersProvider);
    final subs = 'auth/token?lang=$lang';
    final res = await dio.post('$baseUrl/$subs', options: Options(headers: {
      'Refresh-Token': '${tokens.tokens?.refresh_token}'
    }));

    if(res.data != null) {
      final resp = Tokens.fromJson(res.data['data'] ?? {});

      Map tk = {};
      tk['user'] = tokens.user?.toJson();
      tk['tokens'] = resp.toJson();

      await saveSecure('user', tk);
      ref.read(usersProvider.notifier).update((state) => DataUser.fromJson(tk));
      return resp;
    }
    return Tokens();
  }
}

void onSubmit(BuildContext context,
    WidgetRef ref,
    StateProvider<Map<String, dynamic>> loginAuth,
    StateProvider<MessageLogin> loginMessage,
    GlobalKey<FormState> formKey,
    apiServiceProvider,
    FocusNode loginNode,
    FocusNode passwordNode,
  ) async {

  final data = ref.watch(loginAuth);
  ref.read(loginMessage.notifier).update((state) => MessageLogin());
  if(formKey.currentState!.validate()) {
    final result = await ref.read(apiServiceProvider).submitData(data, ref, context: context);
    if (result is Map && result['data'] != null) {
      Map<String, dynamic> updateRes = { ...result, ...data };
      final res = UserSerial.fromJson(updateRes);

      final list = await getSecure('list_user', type: List);

      // Ensure list is not null and is a List
      List<dynamic> userList = list ?? [];

      bool updated = false;

      // Iterate over the list to find and update the existing entry
      for (int i = 0; i < userList.length; i++) {
        final val = userList[i];
        final resp = UserSerial.fromJson(val as Map<String, dynamic>);
        if (resp.data?.user?.id == res.data?.user?.id) {
          userList[i] = updateRes;
          updated = true;
          break;
        }
      }

      // If the entry was not found, add it to the list
      if (!updated) {
        userList.add(updateRes);
      }

      // Save the updated list
      await saveSecure('list_user', userList);

      // direct to home page
      Navigator.of(context).popUntil((route) => route.isFirst);
      alertSnack(ref.context, 'User login successfully!');
    } else {
      // check error
      final keyLog = MessageLogin.fromJson(result ?? {});
      final login = keyLog.errors?.login;
      final password = keyLog.errors?.password;
      ref.read(loginMessage.notifier).update((state) => keyLog);

      if(login?.message != null) {loginNode.requestFocus();}
      else if(password?.message != null) {passwordNode.requestFocus();}
      else { myWidgets.showAlert(context, '${keyLog.message}'); }
      print('error: ${keyLog.toJson()}');
    }
  }
}


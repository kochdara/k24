
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/chats/chat_page.dart';

import '../../../helpers/helper.dart';
import '../../../helpers/storage.dart';
import '../../../serialization/users/user_serial.dart';
import '../../../widgets/dialog_builder.dart';
import '../../main/home_provider.dart';

class MyAccountApiService {
  final Dio dio = Dio();

  Future<MessageLogin> submitAdd(Map<String, dynamic> data, {
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    dialogBuilder(context);

    final tokens = ref.watch(usersProvider);

    final formData = FormData.fromMap(data);
    final subs = 'me?lang=$lang';

    try {
      final res = await dio.post('$likeUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }, contentType: Headers.formUrlEncodedContentType));

      /// close dialog ///
      Navigator.pop(context);

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      /// close dialog ///
      Navigator.pop(context);

      if (e.response != null) {
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await submitAdd(data, context: context, ref: ref); // Retry the request after refreshing the token
        }
      } else {
        // load dialog error
        myWidgets.showAlert(context, '$e');
      }
    }
    return MessageLogin();
  }

  Future<MessageLogin> submitRemove({ required BuildContext context, String? id, String type = 'post', required WidgetRef ref }) async {
    dialogBuilder(context);
    final tokens = ref.watch(usersProvider);

    final subs = 'me?lang=$lang&id=$id&type=$type';
    try {
      final res = await dio.delete('$likeUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }));

      /// close dialog ///
      Navigator.pop(context);

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      /// close dialog ///
      Navigator.pop(context);

      if (e.response != null) {
        // Handle DioError with response
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await submitRemove(id: id, context: context, ref: ref); // Retry the request after refreshing the token
        }
      } else {
        // load dialog error
        myWidgets.showAlert(context, '$e');
      }
    }
    return MessageLogin();
  }
}



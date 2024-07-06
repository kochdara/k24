
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/chats/chat_page.dart';

import '../../../helpers/storage.dart';
import '../../../serialization/users/user_serial.dart';
import '../../../widgets/dialog_builder.dart';

class MyAccountApiService {
  final Dio dio = Dio();

  Future<MessageLogin> submitAdd(Map<String, dynamic> data, { required BuildContext context }) async {
    dialogBuilder(context);

    final getTokens = await getSecure('user', type: Map);
    final users = DataUser.fromJson(getTokens ?? {});

    final formData = FormData.fromMap(data);
    final subs = 'me?lang=$lang';

    try {
      final res = await dio.post('$likeUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': users.tokens?.access_token
      }, contentType: Headers.formUrlEncodedContentType));

      /// close dialog ///
      Navigator.pop(context);

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      /// close dialog ///
      Navigator.pop(context);

      if (e.response != null) {
        // Handle DioError with response
        return MessageLogin.fromJson(e.response?.data ?? {});
      } else {
        // load dialog error
        myWidgets.showAlert(context, '$e');
      }
    }
    return MessageLogin();
  }

  Future<MessageLogin> submitRemove({ required BuildContext context, String? id, String type = 'post' }) async {
    dialogBuilder(context);
    final getTokens = await getSecure('user', type: Map);
    final users = DataUser.fromJson(getTokens ?? {});

    final subs = 'me?lang=$lang&id=$id&type=$type';
    try {
      final res = await dio.delete('$likeUrl/$subs', options: Options(headers: {
        'Access-Token': users.tokens?.access_token
      }));

      /// close dialog ///
      Navigator.pop(context);

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      /// close dialog ///
      Navigator.pop(context);

      if (e.response != null) {
        // Handle DioError with response
        return MessageLogin.fromJson(e.response?.data ?? {});
      } else {
        // load dialog error
        myWidgets.showAlert(context, '$e');
      }
    }
    return MessageLogin();
  }
}





// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:k24/widgets/dialog_builder.dart';

class SettingsApiService {
  final Dio dio = Dio();

  Future<MessageLogin?> logoutAccount(BuildContext context, WidgetRef ref, Map<String, dynamic> data) async {
    dialogBuilder(context);
    futureAwait(() {});

    final user = ref.watch(usersProvider);
    final formData = FormData.fromMap(data);
    final subs = 'auth/logout?lang=$lang';
    try {
      final res = await dio.post('$baseUrl/$subs', data: formData, options: Options(headers: {
        'Refresh-Token': user.tokens?.refresh_token ?? '',
      }));

      /// close dialog ///
      Navigator.pop(context);

      final resp = MessageLogin.fromJson(res.data ?? {});
      return resp;
    } on DioException catch (e) {
      final res = e.response;

      /// close dialog ///
      Navigator.pop(context);

      if(res?.statusCode == 401) {
        await checkTokens(ref);
        return logoutAccount(context, ref, data);
      }
      final resp = MessageLogin.fromJson(res?.data ?? {});
      return resp;
    }
  }

  Future<MessageLogin?> dataSubmit(BuildContext context, WidgetRef ref, String keyPress, Map<String, dynamic> data, { String? auth }) async {
    dialogBuilder(context);
    final user = ref.watch(usersProvider);
    final formData = FormData.fromMap(data);
    final subs = '${ (auth != null) ? auth : 'me'}/$keyPress?lang=$lang';
    try {
      final res = await dio.post('$baseUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': user.tokens?.access_token ?? '',
      }));

      /// close dialog ///
      Navigator.pop(context);

      final resp = MessageLogin.fromJson(res.data ?? {});
      return resp;
    } on DioException catch (e) {
      final res = e.response;

      /// close dialog ///
      Navigator.pop(context);

      if(res?.statusCode == 401) {
        await checkTokens(ref);
        return dataSubmit(context, ref, keyPress, data);
      }
      final resp = MessageLogin.fromJson(res?.data ?? {});
      return resp;
    }
  }
}


Future updateUserPro(WidgetRef ref, String keys, dynamic value) async {
  final user = ref.read(usersProvider.notifier);
  user.update((state) {
    final newMap = state;
    switch(keys) {
      case 'auto_update_profile_picture':
        if(value is bool) newMap.user?.auto_update_profile_picture = value;
        break;
      case 'phone':
        if(value is String) newMap.user?.contact?.phone?[0] = value;
        break;
      case 'username':
        if(value is String) newMap.user?.username = value;
        break;
      case 'user':
        if(value is UserProfile) newMap.user = value;
        if(value is Map) {
          Map<String, dynamic> data = {};
          value.forEach((key, value) { data.addAll({ key: value }); },);
          newMap.user = UserProfile.fromJson(data);
        }
        break;
      default:
        break;
    }
    return newMap;
  },);
}


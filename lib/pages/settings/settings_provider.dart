

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
}

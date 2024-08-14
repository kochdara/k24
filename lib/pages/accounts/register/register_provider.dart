
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/accounts/register/register_serial.dart';
import 'package:k24/serialization/users/user_serial.dart';

import '../../../helpers/config.dart';
import '../../../widgets/dialog_builder.dart';
import '../../../widgets/modals.dart';

// part 'register_serial.g.dart';

class RegisterApiService {
  final Dio dio = Dio();

  Future<UserProfile?> checkAccount(BuildContext context, WidgetRef ref, Map<String, dynamic> data,) async {
    dialogBuilder(context);

    final formData = FormData.fromMap(data);
    final subs = 'auth/check_account?lang=$lang';
    try {
      final res = await dio.post('$baseUrl/$subs', data: formData);
      /// close dialog ///
      Navigator.pop(context);

      if(res.statusCode == 200) {
        return UserProfile.fromJson(res.data['data'] ?? {});
      }
    } on DioException catch (e) {
      final res = e.response;
      /// close dialog ///
      Navigator.pop(context);

      if(res?.statusCode == 422) {
        myWidgets.showAlert(context, '${res?.data}', title: 'Alert');
        return UserProfile(id: '000');
      }
    }
    return null;
  }

  Future<RegisterSerial?> submitRegisterAccount(BuildContext context, WidgetRef ref, Map<String, dynamic> data,) async {
    dialogBuilder(context);

    final formData = FormData.fromMap(data);
    final subs = 'auth/register?lang=$lang';
    try {
      final res = await dio.post('$baseUrl/$subs', data: formData);
      /// close dialog ///
      Navigator.pop(context);
      return RegisterSerial.fromJson(res.data ?? {});
    } on DioException catch (e) {
      final res = e.response;
      /// close dialog ///
      Navigator.pop(context);

      if(res?.statusCode == 302) {
        return RegisterSerial.fromJson(res?.data ?? {});
      }
      myWidgets.showAlert(context, '${res?.data}', title: 'Alert');
    }
    return RegisterSerial();
  }

  Future<UserSerial?> submitOPTCode(BuildContext context, WidgetRef ref, Map<String, dynamic> data, {
    String? accessToken,
  }) async {
    dialogBuilder(context);

    final formData = FormData.fromMap(data);
    final subs = 'auth/verify?lang=$lang';
    try {
      final res = await dio.post('$baseUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': accessToken ?? ''
      }));
      /// close dialog ///
      Navigator.pop(context);
      final resp = UserSerial.fromJson(res.data ?? {});

      final list = await getSecure('list_user', type: List);

      // Ensure list is not null and is a List
      List<dynamic> userList = list ?? [];
      userList.add({ ...res.data, ...data });
      // Save the updated list
      await saveSecure('list_user', userList);

      return resp;
    } on DioException catch (e) {
      final res = e.response;
      /// close dialog ///
      Navigator.pop(context);
      myWidgets.showAlert(context, '${res?.data}', title: 'Alert');
    }
    return null;
  }
}

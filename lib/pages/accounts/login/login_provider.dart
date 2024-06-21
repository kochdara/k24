
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/serialization/users/user_serial.dart';

import '../../../widgets/dialog_builder.dart';
import '../../main/home_provider.dart';

class MyApiService {
  final Dio dio = Dio();

  Future<UserSerial> submitData(Map<String, dynamic> data, WidgetRef ref, { required BuildContext context }) async {
    dialogBuilder(context);

    final formData = FormData.fromMap(data);

    final subs = 'auth/login?lang=$lang';
    final res = await dio.post('$baseUrl/$subs', data: formData);
    final resp = UserSerial.fromJson(res.data ?? {});

    await saveSecure('user', resp.data?.toJson() ?? {});

    ref.read(usersProvider.notifier).update((state) => DataUser.fromJson(resp.data?.toJson() ?? {}));

    /// close dialog ///
    Navigator.pop(context);

    return resp;
  }
}


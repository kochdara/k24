
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';

import '../../../helpers/helper.dart';
import '../../../serialization/users/user_serial.dart';
import '../../main/home_provider.dart';

class MyAccountApiService {
  final Dio dio = Dio();

  Future<MessageLogin> submitAdd(Map<String, dynamic> data, {
    required WidgetRef ref,
  }) async {

    final tokens = ref.watch(usersProvider);

    final formData = FormData.fromMap(data);
    final subs = 'me?lang=$lang';

    try {
      final res = await dio.post('$likeUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }, contentType: Headers.formUrlEncodedContentType));

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await submitAdd(data, ref: ref); // Retry the request after refreshing the token
        }
      }
    } catch (e) {
      print(e);
    }
    return MessageLogin();
  }

  Future<MessageLogin> submitRemove({ String? id, String type = 'post', required WidgetRef ref }) async {
    final tokens = ref.watch(usersProvider);

    final subs = 'me?lang=$lang&id=$id&type=$type';
    try {
      final res = await dio.delete('$likeUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }));

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle DioError with response
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await submitRemove(id: id, ref: ref); // Retry the request after refreshing the token
        }
      }
    } catch (e) {
      print(e);
    }
    return MessageLogin();
  }
}




import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../helpers/config.dart';
import '../../../helpers/helper.dart';
import '../../main/home_provider.dart';



class MarkApiService {
  final Dio dio = Dio();

  Future<dynamic> submitMarkRead(Map<String, dynamic> data, String ids, WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);

      final subs = '$ids?lang=$lang';
      final res = await dio.put('$notificationUrl/$subs', data: data, options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}',
      }, contentType: Headers.formUrlEncodedContentType));

      final datum = res.data;
      return datum;
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(ref);
        await submitMarkRead(data, ids, ref); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      _handleError('submitData', e, stacktrace);
    }
    return null;
  }

  void _handleError(String methodName, dynamic error, StackTrace stacktrace) {
    print('Error in $methodName: $error');
    print(stacktrace);
  }
}


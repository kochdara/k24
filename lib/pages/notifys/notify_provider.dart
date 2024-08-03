
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../../serialization/notify/nortify_serial.dart';

part 'notify_provider.g.dart';

@riverpod
class NotifyList extends _$NotifyList {
  final Dio dio = Dio();
  List<NotifyDatum> _list = [];
  int limit = 0;
  int offset = 0;
  int length = 1;

  @override
  FutureOr<List<NotifyDatum>> build(WidgetRef context) async {
    limit = 0;
    offset = 0;
    _list = [];
    length = 1;
    return fetchHome();
  }

  Future<List<NotifyDatum>> fetchHome() async {
    await _fetchData(offset);
    return _list;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    await _fetchData(offset);
    state = AsyncData(_list);
  }

  Future<void> _fetchData(int offset) async {
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'lang=en&offset=$offset';
      // print(subs);
      final res = await dio.get('$notificationUrl?$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = NotifySerial.fromJson(res.data);
        final data = resp.data;
        limit = resp.limit;
        length = data.length;
        if(data.isNotEmpty) {
          this.offset = this.offset + limit;
          for (final val in data) {
            final index = _list.indexWhere((element) => element.notid == val.notid);

            if (index != -1) {
              _list[index] = val;
            } else {
              _list.add(val);
            }
          }
        }
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await _fetchData(offset); // Retry the request after refreshing the token
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
  }
}




@riverpod
class NotifyGetDetailsResume extends _$NotifyGetDetailsResume {
  final fields = 'post[location],application[location]';
  final Dio dio = Dio();
  String? idJobs;

  @override
  FutureOr<NotifyResumeData?> build(WidgetRef context, String idJob) async {
    idJobs = idJob;
    return fetchHome(idJobs);
  }

  FutureOr<NotifyResumeData?> fetchHome(String? idJob) async {
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'me/job_applications/$idJob?lang=$lang&fields=$fields';
      // print(subs);
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = NotifyResume.fromJson(res.data);
        final data = resp.data;
        return data;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await fetchHome(idJob); // Retry the request after refreshing the token
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
    return null;
  }
}



class NotifyApiService {
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
        return await submitMarkRead(data, ids, ref); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      _handleError('submitData', e, stacktrace);
    }
    return null;
  }

  Future<MessageLogin> submitMarkReadAll(WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);
      final subs = 'mark_all_read?lang=$lang';
      final res = await dio.put('$notificationUrl/$subs', options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}',
      }, contentType: Headers.formUrlEncodedContentType));

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(ref);
        return await submitMarkReadAll(ref); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      _handleError('submitData', e, stacktrace);
    }
    return MessageLogin();
  }

  Future<MessageLogin> submitDeleteAll(WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);
      final subs = 'delete_all?lang=$lang';
      final res = await dio.delete('$notificationUrl/$subs', options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}',
      }, contentType: Headers.formUrlEncodedContentType));

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(ref);
        return await submitDeleteAll(ref,); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      _handleError('submitData', e, stacktrace);
    }
    return MessageLogin();
  }

  void _handleError(String methodName, dynamic error, StackTrace stacktrace) {
    print('Error in $methodName: $error');
    print(stacktrace);
  }
}


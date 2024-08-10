
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/jobs/applications/jobapplications_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/config.dart';
import '../../../helpers/helper.dart';
import '../../main/home_provider.dart';

part 'application_provider.g.dart';

@riverpod
class GetJobApplication extends _$GetJobApplication {
  final fields = 'post[location],application';
  final Dio dio = Dio();
  int offset = 0;
  int limit = 0;
  int length = 1;
  Map? newMaps;
  List<JobAppData?> listData = [];

  @override
  FutureOr<List<JobAppData?>?> build(WidgetRef context, Map? newMap) async {
    newMaps = newMap;
    if(listData.isEmpty) await fetchJobApp();
    return listData;
  }

  Future<void> refresh() async {
    offset = 0;
    limit = 0;
    length = 1;
    listData = [];
    state = const AsyncLoading();
    await fetchJobApp();
    state = AsyncData(listData);
  }

  Future<void> fetchJobApp() async {
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'me/job_applications?lang=$lang&fields=$fields&offset=$offset';
      if(newMaps != null) {
        newMaps?.forEach((key, value) {
          subs += '&$key=$value';
        });
      }
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = JobAppSerial.fromJson(res.data ?? {});
        final data = resp.data;
        limit = resp.limit ?? 0;
        length = data!.length;
        if(data.isNotEmpty) {
          offset = offset + limit;

          for(final val in data) {
            final index = listData.indexWhere((element) => element?.id == val.id);
            if (index != -1) {
              listData[index] = val;
            } else {
              listData.add(val);
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
        await fetchJobApp(); // Retry the request after refreshing the token
        return;
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
  }
}

@riverpod
class GetBadgesApp extends _$GetBadgesApp {
  final dio = Dio();

  @override
  FutureOr<GetBadgesSerial?> build(WidgetRef context) async {
    final resData = await fetchBadges();
    return resData;
  }

  Future<GetBadgesSerial?> fetchBadges() async {
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'me/job_applications/badges?lang=$lang';
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200) {
        final data = res.data['data'] ?? {};
        final resp = GetBadgesSerial(data: GetBadgesData.fromJson({
          ...data, ...{ 'newCount': data['new'], },
        }));
        return resp;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await fetchBadges(); // Retry the request after refreshing the token
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
    return null;
  }

}

class MarkApiServiceApp {
  final Dio dio = Dio();

  Future<dynamic> submitMarkRead(Map<String, dynamic> data, String ids, WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);

      final subs = '$ids?lang=$lang';
      final res = await dio.put('$notificationUrl/$subs', data: data, options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}',
      }, contentType: Headers.formUrlEncodedContentType));

      print('object');

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

  void _handleError(String methodName, dynamic error, StackTrace stacktrace) {
    print('Error in $methodName: $error');
    print(stacktrace);
  }
}


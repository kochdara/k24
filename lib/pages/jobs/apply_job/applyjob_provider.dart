
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/jobs/apply_jobs/apply_job_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/helper.dart';

part 'applyjob_provider.g.dart';

@riverpod
class GetApplyJob extends _$GetApplyJob {
  final fields = 'location';
  final Dio dio = Dio();
  int offset = 0;
  int limit = 0;
  int length = 1;
  Map? newMaps;
  List<ApplyJobDatum?> listData = [];

  @override
  FutureOr<List<ApplyJobDatum?>?> build(WidgetRef context, Map? newMap) async {
    newMaps = newMap;
    if(listData.isEmpty) await fetchApplyJob();
    return listData;
  }

  Future<void> refresh() async {
    offset = 0;
    limit = 0;
    length = 1;
    listData = [];
    state = const AsyncLoading();
    await fetchApplyJob();
    state = AsyncData(listData);
  }

  Future<void> fetchApplyJob() async {
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'me/applied_jobs?lang=$lang&fields=$fields&offset=$offset';
      if(newMaps != null) {
        newMaps?.forEach((key, value) {
          subs += '&$key=$value';
        });
      }
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = ApplyJobSerial.fromJson(res.data ?? {});
        final data = resp.data;
        limit = resp.limit ?? 0;
        length = data!.length;
        if(data.isNotEmpty) {
          offset = offset + limit;

          for(final val in data) {
            final index = listData.indexWhere((element) => element?.id == val?.id);
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
        await fetchApplyJob(); // Retry the request after refreshing the token
        return;
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
  }
}




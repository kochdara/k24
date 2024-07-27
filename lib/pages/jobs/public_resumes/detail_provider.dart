
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/jobs/details/details_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/helper.dart';

part 'detail_provider.g.dart';

@riverpod
class GetDetailsResume extends _$GetDetailsResume {
  final fields = 'personal_details,educations,experiences,languages,skills,attachment,references,summary,hobbies,preference';
  final Dio dio = Dio();
  String? idJobs;
  String? keyFields;

  @override
  FutureOr<ResumeData?> build(WidgetRef context, String idJob, {String? keyField}) async {
    idJobs = idJob;
    keyFields = keyField;
    return fetchHome(idJobs, keyFields);
  }

  FutureOr<ResumeData?> fetchHome(String? idJob, String? keyFields) async {
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'resumes/$idJob?lang=$lang&fields=$fields';
      if(keyFields != null) subs += '&key=$keyFields';
      print(subs);
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      print(res.data);

      if (res.statusCode == 200 && res.data != null) {
        final resp = ResumeDetailSerial.fromJson(res.data);
        final data = resp.data;
        return data;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchHome(idJob, keyFields); // Retry the request after refreshing the token
      }

      throw Exception('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
    return null;
  }
}

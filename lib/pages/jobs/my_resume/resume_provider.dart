
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/jobs/my_resume/my_resume_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resume_provider.g.dart';

@riverpod
class GetResumeInfo extends _$GetResumeInfo {
  final Dio dio = Dio();
  final String fields = 'basic_info,personal_details,educations,experiences,languages,skills,attachment,references,summary,hobbies,preference';

  @override
  FutureOr<MyResumeSerial?> build(WidgetRef context,) async {
    return fetchHome();
  }

  FutureOr<MyResumeSerial?> fetchHome() async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'me/resume?lang=$lang&fields=$fields';
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = MyResumeSerial.fromJson(res.data ?? {});
        return data;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await fetchHome(); // Retry the request after refreshing the token
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
    return null;
  }
}


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/jobs/details/details_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'personal_provider.g.dart';

@riverpod
class GetPersonalDetails extends _$GetPersonalDetails {
  final Dio dio = Dio();
  final String fields = 'photo';

  @override
  FutureOr<ResumePersonalDetails?> build(WidgetRef context,) async {
    return fetchHome();
  }

  FutureOr<ResumePersonalDetails?> fetchHome() async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'me/resume/personal_details?lang=$lang&fields=$fields';
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = ResumePersonalDetails.fromJson(res.data['data'] ?? {});
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


// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/check_login.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/jobs/my_resume/my_resume_serial.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../serialization/jobs/details/details_serial.dart';

part 'experiences_provider.g.dart';

@riverpod
class GetExperiences extends _$GetExperiences {
  final Dio dio = Dio();
  List<ResumeExperience?> dataList = [];

  @override
  FutureOr<List<ResumeExperience?>> build(WidgetRef context,) async {
    return fetchHome();
  }

  FutureOr<List<ResumeExperience?>> fetchHome() async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'me/resume/experiences?lang=$lang';
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data['data'] ?? [];
        for(final val in data) {
          final va = ResumeExperience.fromJson(val ?? {});
          dataList.add(va);
        }
        return dataList;
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
    return dataList;
  }
}

@riverpod
class GetExperiencesDetails extends _$GetExperiencesDetails {
  final Dio dio = Dio();
  late String ids;

  @override
  FutureOr<ResumeExperience?> build(WidgetRef context, String id) async {
    ids = id;
    return fetchHome(ids);
  }

  FutureOr<ResumeExperience?> fetchHome(String ids) async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'me/resume/experiences/$ids?lang=$lang';
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        return ResumeExperience.fromJson(res.data['data'] ?? {});
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await fetchHome(ids); // Retry the request after refreshing the token
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
    return ResumeExperience();
  }
}



class ExperienceApiService {
  final dio = Dio();

  Future<PersonalSerial> addExperience(WidgetRef ref , Map<String, dynamic> data, { String? expId }) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final formData = FormData.fromMap(data);
    final subs = 'me/resume/experiences${expId != null ? '/$expId' : ''}?lang=$lang';
    try {
      final res = await dio.post('$jobUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }));
      Navigator.pop(ref.context);
      return PersonalSerial.fromJson(res.data ?? {});
    } on DioException catch (e) {
      Navigator.pop(ref.context);
      if (e.response != null) {
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await addExperience(ref, data, expId: expId); // Retry the request after refreshing the token
        } else {
          myWidgets.showAlert(ref.context, '${e.response ?? 'Sorry you can\'t add this experiences.\nPlease try again.'}', title: 'Alert');
        }
      }
    } catch (e) {
      Navigator.pop(ref.context);
      print(e);
    }
    return PersonalSerial();
  }

  Future<PersonalSerial> deleteExperience(WidgetRef ref, String? expId) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final subs = 'me/resume/experiences/$expId?lang=$lang';
    try {
      final res = await dio.delete('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }));
      Navigator.pop(ref.context);
      return PersonalSerial.fromJson(res.data ?? {});
    } on DioException catch (e) {
      Navigator.pop(ref.context);
      if (e.response != null) {
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await deleteExperience(ref, expId); // Retry the request after refreshing the token
        } else {
          myWidgets.showAlert(ref.context, '${e.response ?? 'Sorry you can\'t delete this experiences.\nPlease try again.'}', title: 'Alert');
        }
      }
    } catch (e) {
      Navigator.pop(ref.context);
      print(e);
    }
    return PersonalSerial();
  }
}


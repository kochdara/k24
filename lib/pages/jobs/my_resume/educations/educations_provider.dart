
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

part 'educations_provider.g.dart';

@riverpod
class GetEducations extends _$GetEducations {
  final Dio dio = Dio();
  List<ResumeEducation?> dataList = [];

  @override
  FutureOr<List<ResumeEducation?>> build(WidgetRef context,) async {
    return fetchHome();
  }

  FutureOr<List<ResumeEducation?>> fetchHome() async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'me/resume/educations?lang=$lang';
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data['data'] ?? [];
        for(final val in data) {
          final va = ResumeEducation.fromJson(val ?? {});
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
class GetEducationsDetails extends _$GetEducationsDetails {
  final Dio dio = Dio();
  late String ids;

  @override
  FutureOr<ResumeEducation?> build(WidgetRef context, String id) async {
    ids = id;
    return fetchHome(ids);
  }

  FutureOr<ResumeEducation?> fetchHome(String ids) async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'me/resume/educations/$ids?lang=$lang';
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        return ResumeEducation.fromJson(res.data['data'] ?? {});
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
    return ResumeEducation();
  }
}



class EducationsApiService {
  final dio = Dio();

  Future<PersonalSerial> addEducations(WidgetRef ref , Map<String, dynamic> data, { String? eduId }) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final formData = FormData.fromMap(data);
    final subs = 'me/resume/educations${eduId != null ? '/$eduId' : ''}?lang=$lang';
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
          return await addEducations(ref, data, eduId: eduId); // Retry the request after refreshing the token
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

  Future<PersonalSerial> deleteEducations(WidgetRef ref, String? eduId) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final subs = 'me/resume/educations/$eduId?lang=$lang';
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
          return await deleteEducations(ref, eduId); // Retry the request after refreshing the token
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


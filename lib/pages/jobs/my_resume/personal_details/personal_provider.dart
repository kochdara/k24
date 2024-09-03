
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/accounts/check_login.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/chats/conversation/conversation_serial.dart';
import 'package:k24/serialization/jobs/details/details_serial.dart';
import 'package:k24/serialization/jobs/my_resume/my_resume_serial.dart';
import 'package:k24/widgets/dialog_builder.dart';
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



class PersonalApiService {
  final dio = Dio();

  Future<PersonalSerial> submitPersonal(WidgetRef ref , Map<String, dynamic> data, ) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final formData = FormData.fromMap(data);
    final subs = 'me/resume/personal_details?lang=$lang';
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
          return await submitPersonal(ref, data); // Retry the request after refreshing the token
        } else {
          myWidgets.showAlert(ref.context, '${e.response ?? 'Sorry you can\'t update this personal data.\nPlease try again.'}', title: 'Alert');
        }
      }
    } catch (e) {
      Navigator.pop(ref.context);
      print(e);
    }
    return PersonalSerial();
  }

  Future<UploadTMPSerial> uploadProfile(Map<String, dynamic> data, WidgetRef context) async {
    try {
      final String? accessTokens = context.watch(usersProvider).tokens?.access_token;
      final formData = FormData.fromMap(data);
      final subs = 'me/upload?lang=$lang';
      final res = await dio.post('$jobUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': accessTokens ?? '',
      }, contentType: Headers.formUrlEncodedContentType));
      final datum = res.data['data'] ?? {};
      final resp = UploadTMPSerial.fromJson(datum);
      return resp;
    } on DioException catch(e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await uploadProfile(data, context); // Retry the request after refreshing the token
      } else {
        myWidgets.showAlert(context.context, '${e.response ?? 'Sorry you can\'t upload this image.\nPlease try again.'}', title: 'Alert');
      }
      print('Dio error: ${e.response}');
    } catch (e) {
      //
    }
    return UploadTMPSerial();
  }
}


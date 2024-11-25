
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/helper.dart';
import '../../../serialization/accounts/edit_profile/edit_profile_serial.dart';
import '../../../serialization/helper.dart';

part 'editpage_provider.g.dart';

final myWidgets = MyWidgets();

@riverpod
class EditProfile extends _$EditProfile {
  final dio = Dio();

  @override
  FutureOr<EditProfileData?> build(WidgetRef context) async {
    final String? accessTokens = context.watch(usersProvider).tokens?.access_token;

    try {
      final String subs = 'me/profile?lang=$lang';
      final res = await dio.get('$baseUrl/$subs', options: Options(headers: {
        'Access-Token': accessTokens,
      }));

      if (res.statusCode == 200) {
        final resp = EditProfileSerial.fromJson(res.data ?? {});
        return resp.data;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return build(context); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error: $e');
      print(stacktrace);
    }
    return EditProfileData();
  }

  Future<void> updateAt(String type, dynamic value) async {
    final newMap = state.valueOrNull;
    if (newMap != null) {
      switch(type) {
        case 'upload_cover':
          if(value is IconSerial || value == null) newMap.cover = value;
          break;
        case 'upload_profile':
          if(value is IconSerial || value == null) newMap.photo = value;
          break;
        default:
          break;
      }
      state = AsyncData(newMap);
    }
  }

}


class RestAPIService {
  final dio = Dio();

  Future<UploadData> uploadProfile(Map<String, dynamic> data, WidgetRef context, String type) async {
    try {
      final String? accessTokens = context.watch(usersProvider).tokens?.access_token;
      final formData = FormData.fromMap(data);
      final subs = 'me/$type?lang=$lang';
      final res = await dio.post('$baseUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': accessTokens ?? '',
      }, contentType: Headers.formUrlEncodedContentType));
      final datum = res.data ?? {};
      final resp = UploadData.fromJson(datum['data']);

      return resp;
    } on DioException catch(e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await uploadProfile(data, context, type); // Retry the request after refreshing the token
      } else {
        myWidgets.showAlert(context.context, '${e.response ?? 'Sorry you can\'t upload this image.\nPlease try again.'}', title: 'Alert');
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      _handleError('uploadData', e, stacktrace);
    }
    return UploadData();
  }

  Future uploadData(Map<String, dynamic> data, WidgetRef context) async {
    dialogBuilder(context.context);
    try {
      final String? accessTokens = context.watch(usersProvider).tokens?.access_token;
      final subs = 'me?lang=$lang';
      final res = await dio.post('$baseUrl/$subs', data: data, options: Options(headers: {
        'Access-Token': accessTokens ?? '',
      }, contentType: Headers.formUrlEncodedContentType));
      Navigator.pop(context.context);
      final datum = res.data ?? {};
      return datum;
    } on DioException catch(e) {
      Navigator.pop(context.context);
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await uploadData(data, context); // Retry the request after refreshing the token
      } else {
        myWidgets.showAlert(context.context, '${e.response ?? 'Sorry you can\'t update this profile.\nPlease try again.'}', title: 'Alert');
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      Navigator.pop(context.context);
      _handleError('uploadData', e, stacktrace);
    }
    return null;
  }

  void _handleError(String methodName, dynamic error, StackTrace stacktrace) {
    print('Error in $methodName: $error');
    print(stacktrace);
  }
}

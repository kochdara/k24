
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/config.dart';
import '../../../helpers/helper.dart';
import '../../../serialization/settings/privacys/privacy_serial.dart';

part 'privacy_provider.g.dart';

@riverpod
class GetPrivacy extends _$GetPrivacy {
  final Dio dio = Dio();

  @override
  FutureOr<PrivacySerial?> build(WidgetRef context,) async {
    final res = await fetchData();
    return res;
  }

  Future<PrivacySerial> fetchData() async {
    try {
      final tokens = context.watch(usersProvider);
      String url = 'me/privacy?lang=$lang';
      final res = await dio.get('$baseUrl/$url', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        final resp = PrivacySerial.fromJson(data);
        return resp;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await fetchData(); // Retry the request after refreshing the token
      }
      print('throw exception: $response');
    } catch (e) {
      // Handle other exceptions
      print('Error fetching banner ads: $e');
    }
    return PrivacySerial();
  }

  Future<void> updateAt(String type, dynamic value) async {
    final newMap = state.valueOrNull;
    if(newMap != null) {
      switch(type) {
        case 'gender':
          if(value is String) newMap.data?.gender = value;
          break;
        case 'phone':
          if(value is String) newMap.data?.phone = value;
          break;
        case 'email':
          if(value is String) newMap.data?.email = value;
          break;
        case 'location':
          if(value is String) newMap.data?.location = value;
          break;
        case 'dob':
          if(value is String) newMap.data?.dob = value;
          break;
        default:
          break;
      }
      state = AsyncData(newMap);
    }
  }
}


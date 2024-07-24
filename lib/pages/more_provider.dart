
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/banners/banner_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helpers/config.dart';
import '../helpers/helper.dart';
import '../serialization/chats/conversation/conversation_serial.dart';
import 'main/home_provider.dart';

part 'more_provider.g.dart';

final config = Config();

@riverpod
class GetBannerAds extends _$GetBannerAds {
  final Dio dio = Dio();

  @override
  Future<BannerSerial> build(String dType, String type, {String? page}) async {
    final res = await fetchData(dType, type, page);
    return BannerSerial.fromJson((res ?? {}) as Map<String, dynamic>);
  }

  FutureOr<Map?> fetchData(String dType, String type, String? page) async {
    try {
      String url = 'banners?lang=$lang&display-type=$dType&type=$type';
      if(page != null) url += '&page=$page';
      final res = await dio.get('$baseUrl/$url');

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        final resp = BannerSerial.fromJson(data);
        return resp.toJson();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      print('Dio error: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      print('Error fetching banner ads: $e');
    }
    return null;
  }
}

class UploadApiService {
  final Dio dio = Dio();

  Future<UploadTMPSerial> uploadData(Map<String, dynamic> data, WidgetRef ref) async {
    try {
      final formData = FormData.fromMap(data);
      final subs = 'upload?lang=$lang';
      final res = await dio.post('$baseUrl/$subs', data: formData);
      final datum = res.data ?? {};
      final resp = UploadTMPSerial.fromJson(datum['data'] ?? {});

      return resp;
    } catch (e, stacktrace) {
      _handleError('uploadData', e, stacktrace);
      return UploadTMPSerial();
    }
  }

  void _handleError(String methodName, dynamic error, StackTrace stacktrace) {
    print('Error in $methodName: $error');
    print(stacktrace);
  }
}



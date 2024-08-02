
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/banners/banner_serial.dart';
import 'package:k24/serialization/notify/nortify_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helpers/config.dart';
import '../helpers/helper.dart';
import '../serialization/chats/conversation/conversation_serial.dart';

part 'more_provider.g.dart';

final config = Config();

StateProvider<NotifyBadges> dataBadgeProvider = StateProvider((ref) => NotifyBadges());

@riverpod
class GetBannerAds extends _$GetBannerAds {
  final Dio dio = Dio();

  String? dTypes;
  String? types;
  String? pages;

  @override
  Future<BannerSerial> build(String dType, String type, {String? page}) async {
    dTypes = dType;
    types = type;
    pages = page;
    final res = await fetchData(dTypes!, types!, pages);
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

@riverpod
class GetBadges extends _$GetBadges {
  final Dio dio = Dio();

  String? fields = 'chat,comment';

  @override
  FutureOr<NotifyBadges?> build(WidgetRef context) async {
    final res = await fetchData();
    return res;
  }

  Future<NotifyBadges> fetchData() async {
    try {
      final badges = ref.read(dataBadgeProvider.notifier);
      final tokens = context.watch(usersProvider);
      String url = 'badges?fields=$fields&lang=$lang';
      final res = await dio.get('$notificationUrl/$url', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        final resp = NotifyBadges.fromJson(data);
        badges.state = resp;
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
    return NotifyBadges();
  }
}

class MoreTypeInfo {
  final String name;
  final String description;
  final IconData? icon;
  final IconData? iconSave;
  final void Function()? onTap;

  MoreTypeInfo(this.name, this.description, this.icon, this.iconSave, this.onTap);
}

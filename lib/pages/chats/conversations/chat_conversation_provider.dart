
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/config.dart';
import '../../../helpers/helper.dart';
import '../../../serialization/chats/chat_serial.dart';
import '../../../serialization/chats/conversation/conversation_serial.dart';
import '../../main/home_provider.dart';

part 'chat_conversation_provider.g.dart';

@riverpod
class GetTopByUid extends _$GetTopByUid {
  String fields = 'user,post,blocked';

  Dio dio = Dio();

  @override
  FutureOr<ChatData?> build(WidgetRef context, { String topic_id = '0', String? to_id, String? adid, }) async {
    final accessToken = await checkTokens(context);
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'topics/$topic_id?lang=en&fields=$fields';
      if(to_id != null) {subs += '&to_id=$to_id';}
      else if(adid != null) {subs += '&adid=$adid';}
      final res = await dio.get('$chatUrl/$subs', options: Options(headers: {
        'Access-Token': '${accessToken ?? tokens.tokens?.access_token}',
      }));

      final resp = ChatData.fromJson(res.data['data'] ?? {});

      if (res.statusCode == 200) return resp;
    } on DioException catch (e) {
      print(e.response?.data);
    }
    return null;
  }
}

class MarkApiService {
  final Dio dio = Dio();

  Future<dynamic> submitMarkRead(Map<String, dynamic> data, WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);

      final formData = FormData.fromMap(data);
      final subs = 'mark_read_message?lang=$lang';
      final res = await dio.post('$chatUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}',
      }, contentType: Headers.formUrlEncodedContentType));

      final datum = res.data;
      return datum;
    } catch (e, stacktrace) {
      _handleError('submitData', e, stacktrace);
    }
    return null;
  }

  Future<ConData> submitData(Map<String, dynamic> data, WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);

      final formData = FormData.fromMap(data);
      final subs = 'messages?lang=$lang';
      final res = await dio.post('$chatUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}',
      }, contentType: Headers.formUrlEncodedContentType));
      final resp = ConData.fromJson(res.data ?? {});

      return resp;
    } catch (e, stacktrace) {
      _handleError('submitData', e, stacktrace);
      return ConData();
    }
  }

  Future<UploadTMPSerial> uploadData(Map<String, dynamic> data, WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);

      final formData = FormData.fromMap(data);
      final subs = 'upload?lang=$lang';
      final res = await dio.post('$chatUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}'
      }));
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

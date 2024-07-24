
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/posts/post_serials.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../main/home_provider.dart';

part 'post_provider.g.dart';

final config = Config();
final myWidgets = MyWidgets();

@riverpod
class GetPostFilter extends _$GetPostFilter {
  final Dio dio = Dio();

  @override
  FutureOr<PostSerial?> build(WidgetRef context, String slug, String? storeid) async {
    final res = await fetchData(slug, storeid);
    return res;
  }

  Future<PostSerial?> fetchData(String slug, String? storeid) async {
    try {
      final accessToken = await checkTokens(context);
      final tokens = context.watch(usersProvider);

      Uri uri = Uri.parse('$baseUrl/me/posts/filter/$slug').replace(queryParameters: {
        'lang': lang,
        'group': 'true',
        'return_key': 'false',
        'filter_version': '4',
        if (storeid != null) 'storeid': storeid,
      });

      final res = await dio.get(uri.toString(), options: Options(headers: {
        'Access-Token': accessToken ?? tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        return PostSerial.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      throw Exception('Error fetching data: $e');
    }
  }
}

class MyPostApi {
  final dio = Dio();

  Future createPosts(BuildContext context, Map<String, dynamic> data, WidgetRef ref) async {
    try {
      final accessToken = await checkTokens(ref);
      final tokens = ref.watch(usersProvider);

      final formData = FormData.fromMap(data);
      final subs = 'me/posts?lang=$lang';
      final res = await dio.post(
        '$baseUrl/$subs',
        data: formData,
        options: Options(headers: {
          'Access-Token': accessToken ?? tokens.tokens?.access_token,
        }, contentType: Headers.formUrlEncodedContentType),
      );
      final datum = res.data ?? {};

      print(datum);

      // return datum;
    } on DioException catch (e) {
      print(e.response);
      myWidgets.showAlert(context, '${e.response}', title: 'Alert');
      _handleError('DioException: ', e, '');
    } catch (e, stacktrace) {
      _handleError('uploadData', e, stacktrace);
    }
  }

  void _handleError(String methodName, dynamic error, dynamic stacktrace) {
    print('Error in $methodName: $error');
    print(stacktrace);
  }
}

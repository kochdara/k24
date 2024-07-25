
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/posts/post_serials.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../../widgets/dialog_builder.dart';
import '../main/home_provider.dart';

part 'post_provider.g.dart';

final config = Config();
final myWidgets = MyWidgets();

@riverpod
class GetPostFilter extends _$GetPostFilter {

  final Dio dio = Dio();
  String? slugs;
  String? storeids;

  @override
  FutureOr<PostSerial?> build(WidgetRef context, String slug, String? storeid) async {
    slugs = slug;
    storeids = storeid;
    final res = await fetchData(slugs!, storeids);
    return res;
  }

  Future<PostSerial?> fetchData(String slug, String? storeid) async {
    try {
      final tokens = context.watch(usersProvider);

      Uri uri = Uri.parse('$baseUrl/me/posts/filter/$slug').replace(queryParameters: {
        'lang': lang,
        'group': 'true',
        'return_key': 'false',
        'filter_version': '4',
        if (storeid != null) 'storeid': storeid,
      });

      final res = await dio.get(uri.toString(), options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        return PostSerial.fromJson(data);
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchData(slug, storeid); // Retry the request after refreshing the token
      }
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      throw Exception('Error fetching data: $e');
    }
    return null;
  }
}

class MyPostApi {
  final dio = Dio();

  Future createPosts(BuildContext context, Map<String, dynamic> data, WidgetRef ref) async {
    dialogBuilder(context);

    try {
      final tokens = ref.watch(usersProvider);
      final formData = FormData.fromMap(data);
      final subs = 'me/posts?lang=$lang';
      final res = await dio.post(
        '$baseUrl/$subs',
        data: formData,
        options: Options(headers: {
          'Access-Token': tokens.tokens?.access_token,
        }, contentType: Headers.formUrlEncodedContentType),
      );
      final datum = res.data ?? {};
      /// close dialog ///
      Navigator.pop(context);

      return datum;
    } on DioException catch (e) {
      /// close dialog ///
      Navigator.pop(context);

      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(ref);
        await createPosts(context, data, ref); // Retry the request after refreshing the token
      } else {
        myWidgets.showAlert(context, '$response', title: 'Alert');
      }
      _handleError('DioException: ', response, '');
    } catch (e, stacktrace) {
      /// close dialog ///
      Navigator.pop(context);

      _handleError('uploadData', e, stacktrace);
    }
    return null;
  }

  void _handleError(String methodName, dynamic error, dynamic stacktrace) {
    print('Error in $methodName: $error');
    print(stacktrace);
  }
}

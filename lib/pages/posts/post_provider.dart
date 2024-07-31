
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/posts/post_serials.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../../serialization/posts/edit_post/edit_post.dart';
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
        return await fetchData(slug, storeid); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.message}');
    } catch (e) {
      // Handle other exceptions
      print('Error fetching data: $e');
    }
    return null;
  }
}

class MyPostApi {
  final dio = Dio();

  Future createPostsOrUpdate(BuildContext context, Map<String, dynamic> data, WidgetRef ref, {
    String? productID,
  }) async {
    dialogBuilder(context);

    try {
      final tokens = ref.watch(usersProvider);
      final formData = FormData.fromMap(data);
      String subs = 'me/posts?lang=$lang';
      if(productID != null) subs = 'me/posts/$productID?lang=$lang';
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
        return await createPostsOrUpdate(context, data, ref, productID: productID); // Retry the request after refreshing the token
      } else {
        myWidgets.showAlert(context, '$response', title: 'Alert');
      }
      _handleError('DioException: ', e, '');
      print(e);
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

Future<EditPostSerial> getEditPostInfoProvider(WidgetRef context, String proId) async {
  try {
    dialogBuilder(context.context);

    final tokens = context.read(usersProvider).tokens;

    Uri uri = Uri.parse('$baseUrl/me/posts/$proId').replace(queryParameters: {
      'lang': lang,
      'group': 'false',
      'type': 'active',
      'filter_version': '4',
    });

    final res = await Dio().get(uri.toString(), options: Options(headers: {
      'Access-Token': tokens?.access_token,
    }));

    /// close dialog ///
    Navigator.pop(context.context);

    if (res.statusCode == 200 && res.data != null) {
      // print(res.data);
      return EditPostSerial.fromJson(res.data);
    }
  } on DioException catch(e) {
    /// close dialog ///
    Navigator.pop(context.context);

    final response = e.response;
    // Handle Dio-specific errors
    if (response?.statusCode == 401) {
      // Token might have expired, try to refresh the token
      await checkTokens(context);
      return await getEditPostInfoProvider(context, proId); // Retry the request after refreshing the token
    }
    print('Failed to fetch data2');
  } catch(e) {
    /// close dialog ///
    Navigator.pop(context.context);

    print('Failed catch: $e');
  }
  return EditPostSerial();
}


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/posts/post_serials.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../main/home_provider.dart';

part 'post_provider.g.dart';

final config = Config();

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
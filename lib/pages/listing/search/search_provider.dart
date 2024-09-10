
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class GetSearchPost extends _$GetSearchPost {
  final fields = 'thumbnail,location,photos,user,store,renew_date,is_like,category';
  final Dio dio = Dio();
  String? keywords;
  int offset = 0;
  int limit = 0;
  int length = 1;
  List<GridCard?> listData = [];

  @override
  FutureOr<List<GridCard?>?> build(WidgetRef context, String keyword) async {
    keywords = keyword;
    if(listData.isEmpty) await fetchSearchData(keywords);
    return listData;
  }

  Future<void> refresh() async {
    offset = 0;
    limit = 0;
    length = 1;
    listData = [];
    state = const AsyncLoading();
    await fetchSearchData(keywords);
    state = AsyncData(listData);
  }

  Future<void> fetchSearchData(String? keyword) async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'feed?lang=$lang&offset=$offset&keyword=$keyword&fields=$fields';
      final res = await dio.get('$postUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = HomeSerial.fromJson(res.data ?? {});
        final data = resp.data ?? [];
        limit = resp.limit ?? 0;
        length = data.length;
        if(data.isNotEmpty) {
          offset = offset + limit;

          for(final val in data) {
            final index = listData.indexWhere((element) => element?.data?.id == val?.data?.id);
            if (index != -1) {
              listData[index] = val;
            } else {
              listData.add(val);
            }
          }
        }
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchSearchData(keyword); // Retry the request after refreshing the token
        return;
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
  }

}

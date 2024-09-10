
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../serialization/helper.dart';

part 'searchuser_provider.g.dart';

@riverpod
class GetSearchUser extends _$GetSearchUser {
  final fields = 'photo,photos,thumbnails,thumbnail,renew_date,posted_date,link,contact,userid';
  final Dio dio = Dio();
  String? keywords;
  String? types;
  int offset = 0;
  int limit = 0;
  int length = 1;
  List<Store_?> listData = [];

  @override
  FutureOr<List<Store_?>?> build(WidgetRef context, String type, String keyword) async {
    types = type;
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
      final tokens = ref.watch(usersProvider);
      String subs = 'profiles/$types?lang=$lang&offset=$offset&keyword=$keyword';
      final res = await dio.get('$baseUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = MoreSerial.fromJson(res.data ?? {});
        final data = resp.data ?? [];
        limit = resp.limit ?? 0;
        length = data!.length;
        if(data is List) {
          offset = offset + limit;

          for(final val in data) {
            final value = Store_.fromJson(val ?? {});
            final index = listData.indexWhere((element) => element?.id == value.id);
            if (index != -1) {
              listData[index] = value;
            } else {
              listData.add(value);
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


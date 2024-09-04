
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/helper.dart';
import '../../serialization/follows/follows_serial.dart';

part 'follows_provider.g.dart';

@riverpod
class GetFollows extends _$GetFollows {
  final Dio dio = Dio();
  int limit = 0;
  int offset = 0;
  int length = 1;
  String? types;
  String? storeIds;
  String? usernames;
  List<FollowsDatum?> listData = [];

  @override
  FutureOr<List<FollowsDatum?>?> build(WidgetRef context, String? type, { String? storeId, String? username }) async {
    types = type;
    storeIds = storeId;
    usernames = username;
    return await fetchHome();
  }

  Future<void> refresh() async {
    offset = 0;
    limit = 0;
    length = 1;
    listData = [];
    state = const AsyncLoading();
    await fetchHome();
    state = AsyncData(listData);
  }

  FutureOr<List<FollowsDatum?>?> fetchHome() async {
    try { /// usernames is check for public profile ///
      final tokens = context.watch(usersProvider);
      String subs = '${usernames != null ? 'profiles/$usernames' : 'me'}/$type?lang=$lang&offset=$offset';
      if(storeIds != null) subs += '&storeid=$storeIds';

      final res = await dio.get('$baseUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = FollowsSerial.fromJson(res.data ?? {});
        final data = resp.data ?? [];
        limit = resp.limit ?? 0;
        length = data.length;
        if(data.isNotEmpty) {
          offset += limit;
          for(final val in data) {
            final index = listData.indexWhere((element) => element?.id == val?.id);
            if (index != -1) {
              listData[index] = val;
            } else {
              listData.add(val);
            }
          }
        }
        return listData;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await fetchHome(); // Retry the request after refreshing the token
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
    return listData;
  }
}
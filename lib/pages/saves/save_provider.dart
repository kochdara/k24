

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/helper.dart';
import '../../serialization/likes/likes_serial.dart';

part 'save_provider.g.dart';

@riverpod
class GetTotalSave extends _$GetTotalSave {
  final fields = 'photo,photos,thumbnails,thumbnail,renew_date,posted_date,link,contact,userid';
  final Dio dio = Dio();
  String? sorts;
  String? types;
  int offset = 0;
  int limit = 0;
  int length = 1;
  List<LikesDatum?> listData = [];

  @override
  FutureOr<List<LikesDatum?>?> build(WidgetRef context, String sort, { String? type = 'post' }) async {
    sorts = sort;
    types = type;
    if(listData.isEmpty) await fetchSaves();
    return listData;
  }

  Future<void> refresh() async {
    offset = 0;
    limit = 0;
    length = 1;
    listData = [];
    state = const AsyncLoading();
    await fetchSaves();
    state = AsyncData(listData);
  }

  Future<void> fetchSaves() async {
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'me/saved?lang=$lang&fields=$fields&offset=$offset&type=$types&sort=$sorts';
      final res = await dio.get('$baseUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = LikeSerial.fromJson(res.data ?? {});
        final data = resp.data;
        limit = resp.limit ?? 0;
        length = data!.length;
        if(data.isNotEmpty) {
          offset = offset + limit;

          for(final val in data) {
            final index = listData.indexWhere((element) => element?.id == val?.id);
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
        await fetchSaves(); // Retry the request after refreshing the token
        return;
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
  }

  Future<void> removeAt(String ids) async {
    final newList = state.valueOrNull;
    if (newList != null) {
      final index = newList.indexWhere((element) => element?.id == ids);
      if (index != -1) {
        newList.removeAt(index);
        state = AsyncData(newList);
      }
    }
  }
}

class SaveApiService {
  final dio = Dio();

  Future<MessageLogin> submitRemoveSave(WidgetRef ref , String? idSaves,) async {
    final tokens = ref.watch(usersProvider);

    final subs = 'me/saved/$idSaves?lang=$lang';
    try {
      final res = await dio.delete('$baseUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }));

      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle DioError with response
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await submitRemoveSave(ref, idSaves); // Retry the request after refreshing the token
        }
      }
    } catch (e) {
      print(e);
    }
    return MessageLogin();
  }
}


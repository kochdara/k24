
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/accounts/profiles_public/profile_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/config.dart';
import '../../../helpers/helper.dart';
import '../../../serialization/grid_card/grid_card.dart';
import '../../../serialization/users/user_serial.dart';
import '../../main/home_provider.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfilePublic extends _$ProfilePublic {
  // final String fields = 'all';
  final String fields = 'following,followers,is_follow,id,is_verify,type,username,about,link,contact,cover,logo,online_status,photo,registered_date,verified,description,categories,business_hours,branches,keywords,menu,member_type,is_saved';
  final String meta = 'true';
  final String functions = 'chat,save,follow';

  final Dio dio = Dio();
  String? usernames;
  String? userids;

  @override
  Future<ProfileSerial?> build(WidgetRef context, { String? username, String? userid }) async {
    usernames = username;
    userids = userid;
    try {
      final String? accessToken = context.watch(usersProvider).tokens?.access_token;
      String subs = 'profiles/';
      if(usernames != null) { subs += '$usernames'; }
      else if(userids != null) { subs += 'user/$userids'; }
      subs += '?lang=$lang&fields=$fields&meta=$meta&functions=$functions';
      final Response res = await dio.get('$baseUrl/$subs', options: Options(headers: (accessToken != null) ? {
        'Access-Token': accessToken,
      } : null));

      if (res.statusCode == 200) {
        return ProfileSerial.fromJson(res.data ?? {});
      } else {
        print('Error: Received non-200 status code: ${res.statusCode}');
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await build(context, username: usernames, userid: userids); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');
    }
    return ProfileSerial(data: DataProfile());
  }

  Future<void> updateLikes(String ids, { bool? isFollow, bool? isSaved }) async {
    final newMap = state.valueOrNull;
    if(newMap != null) {
      if(isFollow != null) newMap.data.is_follow = isFollow;
      if(isSaved != null) newMap.data.is_saved = isSaved;
      state = AsyncData(newMap);
    }
  }
}

@riverpod
class ProfileList extends _$ProfileList {
  List<GridCard> list = [];
  final String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,condition,highlight_specs';
  final String fun = 'save,chat,like,comment,apply_job,shipping';

  final Dio dio = Dio();
  String? usernames;

  int limit = 0;
  int offset = 0;
  int length = 1;

  @override
  Future<List<GridCard>> build(WidgetRef context, String username) {
    usernames = username;
    return fetchHome();
  }

  Future<List<GridCard>> fetchHome() async {
    await fetchProfiles(usernames!);
    return list;
  }

  Future<void> refresh(String username) async {
    limit = 0;
    offset = 0;
    length = 1;
    list.clear();
    state = const AsyncLoading();

    await fetchProfiles(username);
    state = AsyncData(list);
  }

  Future<void> fetchProfiles(String username) async {
    try {
      final String? accessToken = ref.watch(usersProvider).tokens?.access_token;

      final String subs = '$usernames/feed?lang=en&offset=${offset + limit}&fields=$fields&functions=$fun';
      final Response res = await dio.get('$postUrl/$subs', options: Options(headers: (accessToken != null) ? {
        'Access-Token': accessToken,
      } : null));

      print('object: ${offset + limit}');

      if (res.statusCode == 200) {
        final HomeSerial resp = HomeSerial.fromJson(res.data ?? {});
        limit = resp.limit ?? 0;
        final newProfiles = resp.data ?? [];
        length = newProfiles.length;

        if(newProfiles.isNotEmpty) {
          offset = resp.offset ?? 0;

          for (final val in newProfiles) {
            final index = list.indexWhere((element) => element.data?.id == val?.data?.id);

            if (index != -1) {
              list[index] = val!;
            } else {
              list.add(val!);
            }
          }
        }
      } else {
        print('Error: Received non-200 status code: ${res.statusCode}');
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchHome(); // Retry the request after refreshing the token
        return;
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');
    }
  }

  Future<void> updateLikes(String ids, { bool? isLikes, bool? isSaved }) async {
    final newList = state.valueOrNull;
    if (newList != null) {
      final index = newList.indexWhere((element) => element.data?.id == ids);
      if (index != -1) {
        if(isLikes != null) newList[index].data?.is_like = isLikes;
        if(isSaved != null) newList[index].data?.is_saved = isSaved;
        state = AsyncData(newList);
      }
    }
  }
}


class ProfileSendApiService {
  final dio = Dio();

  Future<MessageLogin> submitFollow(String key, Map<String, dynamic> data, {
    required WidgetRef ref,
  }) async {
      final tokens = ref.watch(usersProvider);

      final formData = FormData.fromMap(data);
      final subs = 'me/$key?lang=$lang';

      try {
        final res = await dio.post('$baseUrl/$subs', data: formData, options: Options(headers: {
          'Access-Token': tokens.tokens?.access_token
        }, contentType: Headers.formUrlEncodedContentType));

        print(res.data);

        return MessageLogin.fromJson(res.data ?? {});
      } on DioException catch (e) {
        print(e.response);
        if (e.response != null) {
          // Handle DioError with response
          final response = e.response;
          // Handle Dio-specific errors
          if (response?.statusCode == 401) {
            // Token might have expired, try to refresh the token
            await checkTokens(ref);
            return await submitFollow(key, data, ref: ref); // Retry the request after refreshing the token
          }
        }
      } catch (e) {
        print(e);
      }
      return MessageLogin();
    }
}


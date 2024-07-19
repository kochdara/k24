
import 'package:dio/dio.dart';
import 'package:k24/serialization/accounts/profiles_public/profile_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/config.dart';
import '../../../serialization/grid_card/grid_card.dart';
import '../../main/home_provider.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfilePublic extends _$ProfilePublic {
  final String fields = 'cover,photo,logo,link,username,online_status,type,is_verify,about,registered_date,created_date,owner_id,category,contact[name,location,phone,address,map],business_hours,branches,keywords,verified,is_saved,following,followers,is_follow';
  final String meta = 'true';
  final String functions = 'chat,save,follow';

  final Dio dio = Dio();

  @override
  Future<ProfileSerial?> build(String username) async {
    try {
      final String? accessToken = ref.watch(usersProvider).tokens?.access_token;

      final String subs = 'profiles/$username?lang=$lang&fields=$fields&meta=$meta&functions=$functions';
      final Response res = await dio.get('$baseUrl/$subs', options: Options(headers: (accessToken != null) ? {
        'Access-Token': accessToken,
      } : null));

      if (res.statusCode == 200) {
        return ProfileSerial.fromJson(res.data ?? {});
      } else {
        print('Error: Received non-200 status code: ${res.statusCode}');
      }
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');
      return ProfileSerial(data: DataProfile());
    }

    return null;
  }
}

@riverpod
class ProfileList extends _$ProfileList {
  List<GridCard> list = [];
  final String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,condition,highlight_specs';
  final String fun = 'save,chat,like,comment,apply_job,shipping';

  final Dio dio = Dio();

  int limit = 0;
  int current_result = 0;
  int offset = 0;

  @override
  Future<List<GridCard>> build(String username) async => fetchHome();

  Future<List<GridCard>> fetchHome() async {
    if (current_result >= limit) {
      await fetchProfiles(username);
    }
    return list;
  }

  Future<void> refresh(String username) async {
    limit = 0;
    current_result = 0;
    offset = 0;
    list.clear();
    state = const AsyncLoading();

    await fetchProfiles(username);
    state = AsyncData(list);
  }

  Future<void> fetchProfiles(String username) async {
    try {
      final String? accessToken = ref.watch(usersProvider).tokens?.access_token;

      final String subs = '$username/feed?lang=en&offset=${offset + limit}&fields=$fields&functions=$fun';
      final Response res = await dio.get('$postUrl/$subs', options: Options(headers: (accessToken != null) ? {
        'Access-Token': accessToken,
      } : null));

      if (res.statusCode == 200) {
        final HomeSerial resp = HomeSerial.fromJson(res.data ?? {});
        limit = resp.limit ?? 0;
        offset = resp.offset ?? 0;
        current_result = resp.current_result ?? 0;

        final newProfiles = resp.data ?? [];
        for (final val in newProfiles) {
          final index = list.indexWhere((element) => element.data?.id == val?.data?.id);

          if (index != -1) {
            list[index] = val!;
          } else {
            list.add(val!);
          }
        }
      } else {
        print('Error: Received non-200 status code: ${res.statusCode}');
      }
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');
    }
  }
}


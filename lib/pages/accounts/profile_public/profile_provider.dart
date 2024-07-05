
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/profiles/profile_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/config.dart';
import '../../../helpers/helper.dart';
import '../../../serialization/grid_card/grid_card.dart';
import '../../main/home_provider.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfilePublic extends _$ProfilePublic {
  String fields = 'cover,photo,logo,link,username,online_status,type,is_verify,about,registered_date,created_date,owner_id,category,contact[name,location,phone,address,map],business_hours,branches,keywords,verified,is_saved,following,followers,is_follow';
  String meta = 'true';
  String functions = 'chat,save,follow';

  Dio dio = Dio();

  @override
  FutureOr<ProfileSerial?> build(WidgetRef context, String username) async {
    final accessToken = await checkTokens(context);
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'profiles/$username?lang=$lang&fields=$fields&meta=$meta&functions=$functions';
      final res = await dio.get('$baseUrl/$subs', options: Options(headers: {
        'Access-Token': '${accessToken ?? tokens.tokens?.access_token}'}
      ));

      final resp = ProfileSerial.fromJson(res.data ?? {});

      if (res.statusCode == 200) return resp;
    } catch (e, stacktrace) {
      print('Error in : $e');
      print(stacktrace);
      return ProfileSerial(data: DataProfile());
    }
    return null;
  }
}

@riverpod
class ProfileList extends _$ProfileList {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,condition,highlight_specs';
  String fun = 'save,chat,like,comment,apply_job,shipping';

  final Dio dio = Dio();

  int limit = 0;
  int current_result = 0;
  int offset = 0;

  @override
  Future<List<GridCard>> build(WidgetRef context, String username) async => fetchHome();

  Future<List<GridCard>> fetchHome() async {
    if(current_result < limit) return [];
    await urlAPI();
    return list;
  }

  Future<void> refresh() async {
    limit = 0;
    current_result = 0;
    offset = 0;
    list = [];
    state = const AsyncLoading();

    await urlAPI();
    state = AsyncData(list);
  }

  Future<void> urlAPI() async {
    final accessToken = await checkTokens(context);

    try {
      final tokens = ref.watch(usersProvider);
      final subs = '$username/feed?lang=en&offset=${offset + limit}&fields=$fields&functions=$fun';
      final res = await dio.get('$postUrl/$subs', options: Options(headers: {
        'Access-Token': '${accessToken ?? tokens.tokens?.access_token}'}
      ));

      final resp = HomeSerial.fromJson(res.data ?? {});

      if(res.statusCode == 200) {
        final data = resp.data;
        limit = resp.limit ?? 0;
        offset = resp.offset ?? 0;
        current_result = resp.current_result ?? 0;

        for (final val in data!) {
          final index = list.indexWhere((element) => element.data?.id == val?.data?.id);

          if (index != -1) {
            list[index] = val!;
          } else {
            list.add(val!);
          }
        }

      }
    } catch (e, stacktrace) {
      print('Error in : $e');
      print(stacktrace);
    }
  }
}


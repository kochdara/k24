
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../../serialization/grid_card/grid_card.dart';
import '../main/home_provider.dart';

part 'details_provider.g.dart';

@riverpod
class GetDetailPost extends _$GetDetailPost {
  String fields = 'photo,photos,thumbnails,thumbnail,renew_date,posted_date,link,highlight_specs,specs,description,category,views,total_like,total_comment,location,user,store,phone';
  String fun = 'save,chat,like,comment,apply_job,shipping';

  final Dio dio = Dio();

  @override
  Future<GridCard> build(String id) async => fetch();

  Future<GridCard> fetch() async {
    state = const AsyncLoading();
    final subs = 'feed/$id?lang=$lang&fields=$fields&functions=$fun&filter_version=$filterVersion';
    final res = await dio.get('$postUrl/$subs');

    final resp = GridCard.fromJson(res.data ?? {});

    if(res.statusCode == 200) return resp;

    return GridCard();
  }
}

@riverpod
class RelateDetailPost extends _$RelateDetailPost {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment';
  String fun = 'save,chat,like,comment,apply_job,shipping';

  final Dio dio = Dio();

  int limit = 0;
  int offset = 0;

  @override
  Future<List<GridCard>> build(WidgetRef context, String id) async => fetch();

  Future<List<GridCard>> fetch() async {
    await urlAPI();
    return list;
  }

  Future<void> refresh() async {
    limit = 0;
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
      final subs = 'feed/$id/relates?lang=$lang&offset=${offset + limit}&fields=$fields&functions=$fun';
      final res = await dio.get('$postUrl/$subs', options: Options(headers: {
        'Access-Token': '${accessToken ?? tokens.tokens?.access_token}'}
      ));

      final resp = HomeSerial.fromJson(res.data ?? {});

      if(res.statusCode == 200) {
        final data = resp.data;
        limit = resp.limit ?? 0;
        offset = resp.offset ?? 0;

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

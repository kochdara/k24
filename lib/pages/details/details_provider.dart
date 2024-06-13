
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../serialization/grid_card/grid_card.dart';

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
  int current_result = 0;
  int current_page = 0;

  @override
  Future<List<GridCard>> build(String id) async => fetch();

  Future<List<GridCard>> fetch() async {
    await urlAPI();
    return list;
  }

  Future<void> refresh() async {
    limit = 0;
    current_result = 0;
    current_page = 0;
    list = [];
    state = const AsyncLoading();

    await urlAPI();
    state = AsyncData(list);
  }

  Future<void> urlAPI() async {
    final subs = 'feed/$id/relates?lang=$lang&offset=${current_page * limit}&fields=$fields&functions=$fun';
    final res = await dio.get('$postUrl/$subs');
    current_page++;

    final resp = HomeSerial.fromJson(res.data ?? {});

    if(res.statusCode == 200) {
      final data = resp.data;
      limit = resp.limit ?? 0;
      current_result = resp.current_result ?? 0;

      for (var val in data!) {
        list.add(val!);
      }
    }
  }
}


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../serialization/category/main_category.dart';
import '../../serialization/grid_card/grid_card.dart';

part 'home_provider.g.dart';

Config config = Config();

StateProvider<ViewPage> viewPage = StateProvider<ViewPage>((ref) { return ViewPage.grid;});
StateProvider<int> selectedIndex = StateProvider<int>((ref) => 0);

@riverpod
class GetMainCategory extends _$GetMainCategory {
  final Dio dio = Dio();

  @override
  Future<List<MainCategory>> build(String parent) async => fetchData();

  Future<List<MainCategory>> fetchData() async {
    String url = 'categories?parent=$parent&lang=$lang&v=1';
    final res = await dio.get('$baseUrl/$url');

    final resp = res.data;
    List<MainCategory> list = [];

    if(res.statusCode == 200 && resp != null) {
      final data = resp['data'];
      for (final val in data) {
        list.add(MainCategory.fromJson(val));
      }
    }

    return list;
  }
}

@riverpod
class HomeLists extends _$HomeLists {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,condition,highlight_specs';
  String fun = 'banner';

  final Dio dio = Dio();

  int limit = 0;
  int current_result = 0;
  int offset = 0;

  @override
  Future<List<GridCard>> build() async => fetchHome();

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
    final dio = await ref.getDebouncedHttpClient();

    final subs = 'feed?lang=en&offset=${offset + limit}&fields=$fields&functions=$fun';
    final res = await dio.get('$postUrl/$subs');

    final resp = HomeSerial.fromJson(res.data ?? {});

    if(res.statusCode == 200) {
      final data = resp.data;
      limit = resp.limit ?? 0;
      offset = resp.offset ?? 0;
      current_result = resp.current_result ?? 0;

      for (final val in data!) {
        list.add(val!);
      }
    }
  }
}

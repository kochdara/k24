
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../serialization/category/main_category.dart';
import '../../serialization/grid_card/grid_card.dart';

part 'home_provider.g.dart';

Config config = Config();

StateProvider<bool> fetchingProvider = StateProvider<bool>((ref) => false);
StateProvider<bool> loadingProvider = StateProvider<bool>((ref) => false);
StateProvider<ViewPage> viewPage = StateProvider<ViewPage>((ref) { return ViewPage.grid;});

@Riverpod(keepAlive: true)
class GetMainCategory extends _$GetMainCategory {
  @override
  Future<List<MainCategory>> build({ String parent = '0' }) async => fetchData(parent: parent);

  Future<List<MainCategory>> fetchData({ String parent = '0' }) async {
    var url = 'categories?parent=$parent&lang=${config.lang}&v=1';
    var result = await config.getUrls(subs: url, url: Urls.baseUrl);

    List<MainCategory> list = [];
    final resp = ConfigState.fromJson(result);

    if(resp.status == 0 && resp.data != null) {
      var res = resp.data;

      if (res != null) {
        for (var val in res) {
          list.add(MainCategory.fromJson(val));
        }
      }
    }

    return list;
  }
}

@Riverpod(keepAlive: true)
class HomeLists extends _$HomeLists {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,condition,highlight_specs';
  String fun = 'banner';

  int total = 0;
  int limit = 0;
  int offset_ = 0;
  int current_result = 0;
  int current_page = 0;

  @override
  Future<List<GridCard>> build() async => fetchHome();

  Future<List<GridCard>> fetchHome() async {
    if(current_result < limit) return [];
    final subs = 'feed?lang=en&offset=${current_page * limit}&fields=$fields&functions=$fun';
    final res = await config.getUrls(subs: subs, url: Urls.postUrl);
    current_page++;

    final status = ConfigState.fromJson(res);
    final resp = HomeSerial.fromJson(status.result);

    if(status.status == 0) {
      final data = resp.data;
      total = resp.total ?? 0;
      limit = resp.limit ?? 0;
      offset_ = resp.offset ?? 0;
      current_result = resp.current_result ?? 0;

      for (var val in data!) {
        list.add(val!);
      }
    }

    return list;
  }

  Future<void> refresh() async {
    total = 0;
    limit = 0;
    offset_ = 0;
    current_result = 0;
    current_page = 0;
    list = [];

    final subs = 'feed?lang=en&offset=0&fields=$fields&functions=$fun';
    final res = await config.getUrls(subs: subs, url: Urls.postUrl);
    current_page++;

    final status = ConfigState.fromJson(res);
    final resp = HomeSerial.fromJson(status.result);

    if(status.status == 0) {
      final data = resp.data;
      total = resp.total ?? 0;
      limit = resp.limit ?? 0;
      offset_ = resp.offset ?? 0;
      current_result = resp.current_result ?? 0;

      for (var val in data!) {
        list.add(val!);
      }
    }

    state = AsyncData(list);
  }
}


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../serialization/grid_card/grid_card.dart';

part 'sub_provider.g.dart';

Config config = Config();

StateProvider<Map> newData = StateProvider((ref) => {});
StateProvider<int> indX = StateProvider((ref) => 0);

@Riverpod(keepAlive: true)
class SubLists extends _$SubLists {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,highlight_specs,condition,object_highlight_specs';
  String fun = 'save,chat,like,comment,apply_job,shipping,banner[image,code,google_ads,iframe,innity],highlight_ads[highlight_specs],highlight_ads[object_highlight_specs]';

  int total = 0;
  int limit = 0;
  int offset_ = 0;
  int current_result = 0;
  int current_page = 0;

  @override
  Future<List<GridCard>> build({ String category = '' }) async => subFetch(category);

  Future<List<GridCard>> subFetch(String category) async {
    if(current_result < limit) return [];
    var subs = 'feed?lang=en&offset=${current_page * limit}&fields=$fields&functions=$fun';
    subs += '&category=$category';
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

  Future<void> refresh({ String category = '' }) async {
    total = 0;
    limit = 0;
    offset_ = 0;
    current_result = 0;
    current_page = 0;
    list = [];

    var subs = 'feed?lang=en&offset=0&fields=$fields&functions=$fun';
    subs += '&category=$category';
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

@Riverpod(keepAlive: true)
class GetFilters extends _$GetFilters {

  List filters = [];

  @override
  Future<List> build(String slug) async => fetchData(slug);

  Future<List> fetchData(String slug) async {
    filters = [];

    var url = 'filters/$slug?lang=${config.lang}&group=true&return_key=true&filter_version=${config.filterVersion}&has_post=true';
    var result = await config.getUrls(subs: url, url: Urls.baseUrl);

    final resp = ConfigState.fromJson(result);

    if(resp.status == 0 && resp.data != null) {
      var data = resp.data;

      if (data != null) {
        if(data['locations'] != null) if(data['locations']['locations'] != null) filters.add(data['locations']['locations']);

        if(data['sort'] != null) filters.add(data['sort']);
        if(data['date'] != null) filters.add(data['date']);

        if(data['prices'] != null) if(data['prices']['ad_price'] != null) filters.add(data['prices']['ad_price']);

        if(data['fields'] != null) if(data['fields']['ad_condition'] != null) filters.add(data['fields']['ad_condition']);

        // more button //
        filters.add({'fieldid': '0', 'title': 'More', 'type': 'more', 'slug': 'more'});
      }
    }

    return filters;
  }
}


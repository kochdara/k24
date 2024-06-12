
import 'package:k24/helpers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../serialization/grid_card/grid_card.dart';

part 'sub_provider.g.dart';

@riverpod
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
  Future<List<GridCard>> build(String category, {Map? newFilter}) async => subFetch(category: category, newFilter: newFilter);

  Future<List<GridCard>> subFetch({ String category = '', Map? newFilter }) async {
    bool dispose = false;
    ref.onDispose(() { dispose = true; });
    if(current_result < limit || dispose) return [];

    var subs = 'feed?lang=en&offset=${current_page * limit}&fields=$fields&functions=$fun';
    subs += '&category=$category';

    /// check loop filter ///
    if(newFilter != null && newFilter.isNotEmpty) {
      newFilter.forEach((key, value) {
        if(value is Map) {
          if(value['fieldvalue'] != null) subs += '&$key=${value['fieldvalue']}';
          if(value['slug'] != null) subs += '&$key=${value['slug']}';

        } else {subs += '&$key=${value ?? ''}';}
      });
    }

    final res = await getUrls(subs: subs, url: Urls.postUrl);
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

  Future<void> refresh({ String category = '', Map? newFilter }) async {
    total = 0;
    limit = 0;
    offset_ = 0;
    current_result = 0;
    current_page = 0;
    list = [];
    state = const AsyncLoading();

    var subs = 'feed?lang=en&offset=0&fields=$fields&functions=$fun';
    subs += '&category=$category';

    /// check loop filter ///
    if(newFilter != null && newFilter.isNotEmpty) {
      newFilter.forEach((key, value) {
        if(value is Map) {
          if(value['fieldvalue'] != null) subs += '&$key=${value['fieldvalue']}';
          if(value['slug'] != null) subs += '&$key=${value['slug']}';

        } else {subs += '&$key=${value ?? ''}';}
      });
    }

    final res = await getUrls(subs: subs, url: Urls.postUrl);
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

@riverpod
class GetFilters extends _$GetFilters {

  List filters = [];

  @override
  Future<List> build(String slug) async => fetchData(slug);

  Future<List> fetchData(String slug) async {
    filters = [];

    var url = 'filters/$slug?lang=$lang&group=true&return_key=true&filter_version=$filterVersion&has_post=true';
    var result = await getUrls(subs: url, url: Urls.baseUrl);

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

@riverpod
class GetLocation extends _$GetLocation {

  @override
  Future<List> build(String type, String parent) async => fetchData(type, parent);

  Future<List> fetchData(String type, String parent) async {
    var url = 'locations?lang=$lang';
    if(type.isNotEmpty) url += '&type=$type';
    if(parent.isNotEmpty) url += '&parent=$parent';
    var result = await getUrls(subs: url, url: Urls.baseUrl);
    final resp = ConfigState.fromJson(result);
    return resp.data;
  }
}


import 'package:dio/dio.dart';
import 'package:k24/helpers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../serialization/grid_card/grid_card.dart';

part 'sub_provider.g.dart';

@riverpod
class SubLists extends _$SubLists {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,highlight_specs,condition,object_highlight_specs';
  String fun = 'save,chat,like,comment,apply_job,shipping,banner[image,code,google_ads,iframe,innity],highlight_ads[highlight_specs],highlight_ads[object_highlight_specs]';

  int limit = 0;
  int current_result = 0;
  int current_page = 0;

  final Dio dio = Dio();

  @override
  Future<List<GridCard>> build(String category, {Map? newFilter}) async => subFetch();

  Future<List<GridCard>> subFetch() async {
    if(current_result < limit) return [];
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
    String subs = 'feed?lang=en&offset=${current_page * limit}&fields=$fields&functions=$fun';
    subs += '&category=$category';

    /// check loop filter ///
    if(newFilter != null && newFilter!.isNotEmpty) {
      newFilter!.forEach((key, value) {
        if(value is Map) {
          if(value['fieldvalue'] != null) subs += '&$key=${value['fieldvalue']}';
          if(value['slug'] != null) subs += '&$key=${value['slug']}';

        } else {subs += '&$key=${value ?? ''}';}
      });
    }

    final res = await dio.get('$postUrl/$subs');
    current_page++;

    final resp = HomeSerial.fromJson(res.data ?? {});

    if(res.statusCode == 200) {
      final data = resp.data;
      limit = resp.limit ?? 0;
      current_result = resp.current_result ?? 0;

      for (final val in data!) {
        list.add(val!);
      }
    }
  }
}

@riverpod
class GetFilters extends _$GetFilters {

  List filters = [];

  final Dio dio = Dio();

  @override
  Future<List> build(String slug) async => fetchData();

  Future<List> fetchData() async {
    filters = [];

    String url = 'filters/$slug?lang=$lang&group=true&return_key=true&filter_version=$filterVersion&has_post=true';
    final res = await dio.get('$baseUrl/$url');
    final resp = res.data;

    if(res.statusCode == 200 && resp != null) {
      final data = resp['data'];

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

  final Dio dio = Dio();

  @override
  Future<List> build(String type, String parent) async => fetchData();

  Future<List> fetchData() async {
    String url = 'locations?lang=$lang';
    if(type.isNotEmpty) url += '&type=$type';
    if(parent.isNotEmpty) url += '&parent=$parent';
    final res = await dio.get('$baseUrl/$url');
    final resp = res.data;
    return resp['data'];
  }
}


// ignore_for_file: unused_result

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../serialization/grid_card/grid_card.dart';
import '../main/home_provider.dart';

part 'sub_provider.g.dart';

@riverpod
class SubLists extends _$SubLists {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,highlight_specs,condition,object_highlight_specs';
  String fun = 'save,chat,like,comment,apply_job,shipping,banner[image,code,google_ads,iframe,innity],highlight_ads[highlight_specs],highlight_ads[object_highlight_specs]';

  int limit = 0;
  int current_result = 0;
  int offset = 0;

  final Dio dio = Dio();

  @override
  Future<List<GridCard>> build(String category, String accessTokens, {Map? newFilter}) async => subFetch();

  Future<List<GridCard>> subFetch() async {
    if(current_result < limit) return [];
    await urlAPI();
    return list;
  }

  Future<void> refresh() async {
    limit = 0;
    offset = 0;
    current_result = 0;
    list = [];
    state = const AsyncLoading();

    await urlAPI();
    state = AsyncData(list);
  }

  Future<void> urlAPI() async {
    try {
      String subs = 'feed?lang=en&offset=${offset + limit}&fields=$fields&functions=$fun';
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

      final res = await dio.get('$postUrl/$subs', options: Options(headers: {
        'Access-Token': accessTokens
      }));

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
        // filters.add({'fieldid': '0', 'title': 'More', 'type': 'more', 'slug': 'more'});
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

void subLoadMore(WidgetRef ref, Map data,
    StateProvider<bool> fetchingProvider,
    ScrollController scrollController,
    StateProvider<Map> newData,
    downProvider
  ) async {
  final dataCate = data;
  final cate = dataCate['slug'];
  final subListsNotifier = ref.watch(subListsProvider(cate, '${ref.watch(usersProvider).tokens?.access_token}' , newFilter: ref.watch(newData) as Map?).notifier);
  final limit = subListsNotifier.limit;
  final current = subListsNotifier.current_result;
  final fetchingNotifier = ref.read(fetchingProvider.notifier);
  final scroll = scrollController.position;

  if (scroll.pixels > 1500 && scroll.pixels >= (scroll.maxScrollExtent - 750) && current >= limit && !fetchingNotifier.state) {
    fetchingNotifier.state = true;
    await subListsNotifier.subFetch();
    fetchingNotifier.state = false;
  }

  final scrollDirectionNotifier = ref.read(downProvider.notifier);
  final isScrollingDown = ref.watch(downProvider);
  if (scroll.userScrollDirection == ScrollDirection.reverse && !isScrollingDown) {
    scrollDirectionNotifier.state = true;
  } else if (scroll.userScrollDirection == ScrollDirection.forward && isScrollingDown) {
    scrollDirectionNotifier.state = false;
  }
}

Future<void> subHandleRefresh(WidgetRef ref, Map data, StateProvider<Map> newData,
  StateProvider<int> indProvider,
) async {
  final dataCate = data;
  final cate = dataCate['slug'];
  final filter = ref.watch(newData) as Map?;

  ref.read(indProvider.notifier).state = 0;
  filter?.forEach((key, value) {
    if (value != null) ref.read(indProvider.notifier).state++;
  });

  ref.refresh(getMainCategoryProvider(cate).future);
  await ref.read(subListsProvider(cate, '${ref.watch(usersProvider).tokens?.access_token}', newFilter: filter).notifier).refresh();
}


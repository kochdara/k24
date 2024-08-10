
// ignore_for_file: unused_result

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/helper.dart';
import '../../serialization/grid_card/grid_card.dart';
import '../main/home_provider.dart';

part 'sub_provider.g.dart';

@riverpod
class SubLists extends _$SubLists {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,highlight_specs,condition,object_highlight_specs';
  String fun = 'save,chat,like,comment,apply_job,shipping';

  int limit = 0;
  int current_result = 0;
  int offset = 0;

  final Dio dio = Dio();
  String? categories;
  Map? newFilters;

  @override
  Future<List<GridCard>> build(WidgetRef context, String category, {Map? newFilter}) async {
    categories = category;
    newFilters = newFilter;
    return subFetch();
  }

  Future<List<GridCard>> subFetch() async {
    // Return existing data if the current result is less than the limit
    if (current_result < limit && list.isNotEmpty) return list;
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
      final tokens = ref.watch(usersProvider);
      String subs = 'feed?lang=en&offset=${offset + limit}&fields=$fields&functions=$fun';
      subs += '&category=$categories';

      /// Check loop filter ///
      if (newFilters != null && newFilters!.isNotEmpty) {
        newFilters!.forEach((key, value) {
          if (value is Map) {
            if (value['fieldvalue'] != null) subs += '&$key=${value['fieldvalue']}';
            if (value['slug'] != null) subs += '&$key=${value['slug']}';
          } else {
            subs += '&$key=${value ?? ''}';
          }
        });
      }

      final res = await dio.get('$postUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200) {
        final resp = HomeSerial.fromJson(res.data ?? {});
        if (resp.data != null && resp.data!.isNotEmpty) {
          final data = resp.data!;
          limit = resp.limit ?? 0;
          offset = resp.offset ?? 0;
          current_result = resp.current_result ?? 0;

          for (final val in data) {
            final index = list.indexWhere((element) => element.data?.id == val?.data?.id);
            if (index != -1) {
              list[index] = val!;
            } else {
              list.add(val!);
            }
          }
        }
      } else {
        print('Response status code: ${res.statusCode}');
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await subFetch(); // Retry the request after refreshing the token
      } else {
        print('Dio error: ${e.response}');
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error: $e');
      print(stacktrace);
    }
  }

  Future<void> updateLikes(String ids, bool? isLikes) async {
    final newList = state.valueOrNull;
    if (newList != null) {
      final index = newList.indexWhere((element) => element.data?.id == ids);
      if (index != -1) {
        newList[index].data?.is_like = isLikes;
        state = AsyncData(newList);
      }
    }
  }
}

@riverpod
class GetFilters extends _$GetFilters {

  List filters = [];

  final Dio dio = Dio();
  String? slugs;

  @override
  Future<List> build(String slug) async => fetchData();

  Future<List> fetchData() async {
    filters = [];
    slugs = slug;

    String url = 'filters/$slugs?lang=$lang&group=true&return_key=true&filter_version=$filterVersion&has_post=true';
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
  String? types;
  String? parents;

  @override
  Future<List> build(String type, String parent) {
    types = type;
    parents = parent;
    return fetchData();
  }

  Future<List> fetchData() async {
    String url = 'locations?lang=$lang';
    if(types!.isNotEmpty) url += '&type=$types';
    if(parents!.isNotEmpty) url += '&parent=$parents';
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
  final subListsNotifier = ref.watch(subListsProvider(ref, cate, newFilter: ref.watch(newData) as Map?).notifier);
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
  await ref.read(subListsProvider(ref, cate, newFilter: filter).notifier).refresh();
}


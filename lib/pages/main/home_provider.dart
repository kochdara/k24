// ignore_for_file: unused_result

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/serialization/users/user_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../../helpers/storage.dart';
import '../../serialization/category/main_category.dart';
import '../../serialization/grid_card/grid_card.dart';

part 'home_provider.g.dart';

final config = Config();

final viewPageProvider = StateProvider<ViewPage>((ref) => ViewPage.grid);
final usersProvider = StateProvider<DataUser>((ref) => DataUser());

@riverpod
class GetMainCategory extends _$GetMainCategory {
  final Dio dio = Dio();

  String? parents;

  @override
  Future<List<MainCategory>> build(String parent) async {
    parents = parent;
    return fetchData(parent);
  }

  Future<List<MainCategory>> fetchData(String parent) async {
    try {
      final getUsers = await getSecure('user', type: Map);
      ref.read(usersProvider.notifier).update((state) => DataUser.fromJson(getUsers ?? {}));

      final url = 'categories?parent=$parent&lang=$lang&v=1';
      final res = await dio.get('$baseUrl/$url');

      if (res.statusCode == 200 && res.data != null) {
        final List data = res.data['data'];
        return data.map((val) => MainCategory.fromJson(val)).toList();
      }

      return [];
    } catch (e) {
      print('Error fetching main categories: $e');
      return [];
    }
  }
}

@riverpod
class HomeLists extends _$HomeLists {
  final Dio dio = Dio();
  final String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,highlight_specs,condition,object_highlight_specs';
  final String fun = 'banner,save,chat,like,comment,apply_job,shipping';

  List<GridCard> _list = [];
  int limit = 0;
  int currentResult = 0;
  int offset = 0;
  Map? newDatum;

  @override
  Future<List<GridCard>> build(WidgetRef context, Map? newData) async {
    newDatum = newData;
    return fetchHome();
  }

  Future<List<GridCard>> fetchHome() async {
    if (currentResult < limit) return _list;
    await _fetchData();
    return _list;
  }

  Future<void> refresh() async {
    limit = 0;
    currentResult = 0;
    offset = 0;
    _list = [];
    state = const AsyncLoading();

    await _fetchData();
    state = AsyncData(_list);
  }

  Future<void> _fetchData() async {
    try {
      final tokens = ref.watch(usersProvider);
      String subs = 'feed?lang=en&offset=${offset + limit}&fields=$fields&functions=$fun';
      final newDatum = this.newDatum;
      if(newDatum != null) {
        newDatum.forEach((key, value) { subs += '&$key=$value'; });
      }
      // print(subs);
      final res = await dio.get('$postUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final resp = HomeSerial.fromJson(res.data);
        limit = resp.limit ?? 0;
        offset = resp.offset ?? 0;
        currentResult = resp.current_result ?? 0;

        final data = resp.data;
        for (final val in data!) {
          final index = _list.indexWhere((element) => element.data?.id == val?.data?.id);
          if (index != -1) {
            _list[index] = val!;
          } else {
            _list.add(val!);
          }
        }
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchHome(); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
  }
}

void loadMore(WidgetRef ref,
    StateProvider<bool> fetchingProvider,
    StateProvider<bool> downProvider,
    ScrollController scrollController,
    Map newData
  ) async {
  final homeListsNotifier = ref.watch(homeListsProvider(ref, newData).notifier);
  final limit = homeListsNotifier.limit;
  final current = homeListsNotifier.currentResult;
  final fetchingNotifier = ref.read(fetchingProvider.notifier);
  final scroll = scrollController.position;

  if (scroll.pixels > 1500 && scroll.pixels >= (scroll.maxScrollExtent - 750) && (current >= limit) && !fetchingNotifier.state) {
    fetchingNotifier.state = true;
    await homeListsNotifier.fetchHome();
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

Future<void> handleRefresh(WidgetRef ref, StateProvider<Map> newData) async {
  ref.read(newData.notifier).update((state) => {});
  ref.refresh(getMainCategoryProvider('0').future);
  await ref.read(homeListsProvider(ref, ref.watch(newData)).notifier).refresh();
}

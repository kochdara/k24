
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../serialization/grid_card/grid_card.dart';

part 'details_provider.g.dart';

@riverpod
class GetDetailPost extends _$GetDetailPost {
  String fields = 'photo,photos,thumbnails,thumbnail,renew_date,posted_date,link,highlight_specs,specs,description,category,views,total_like,total_comment,location,user,store,phone';
  String fun = 'save,chat,like,comment,apply_job,shipping';

  @override
  Future<GridCard> build(String id) async => fetch(id);

  Future<GridCard> fetch(String id) async {
    state = const AsyncLoading();
    final subs = 'feed/$id?lang=$lang&fields=$fields&functions=$fun&filter_version=$filterVersion';
    final res = await getUrls(subs: subs, url: Urls.postUrl);

    final status = ConfigState.fromJson(res);
    final resp = GridCard.fromJson(status.result);

    if(status.status == 0) return resp;

    return GridCard();
  }
}

@riverpod
class RelateDetailPost extends _$RelateDetailPost {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment';
  String fun = 'save,chat,like,comment,apply_job,shipping';

  int total = 0;
  int limit = 0;
  int offset_ = 0;
  int current_result = 0;
  int current_page = 0;

  @override
  Future<List<GridCard>> build(String id) async => fetch(id);

  Future<List<GridCard>> fetch(String id) async {
    bool dispose = false;
    ref.onDispose(() { dispose = true; });
    if(current_result < limit || dispose) return [];

    final subs = 'feed/$id/relates?lang=$lang&offset=${current_page * limit}&fields=$fields&functions=$fun';
    final res = await getUrls(subs: subs, url: Urls.postUrl);
    current_page++;

    final status = ConfigState.fromJson(res);
    final resp = HomeSerial.fromJson(status.result ?? {});

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

  Future<void> refresh(String id) async {
    total = 0;
    limit = 0;
    offset_ = 0;
    current_result = 0;
    current_page = 0;
    list = [];
    state = const AsyncLoading();

    final subs = 'feed/$id/relates?lang=$lang&offset=0&fields=$fields&functions=$fun';
    final res = await getUrls(subs: subs, url: Urls.postUrl);
    current_page++;

    final status = ConfigState.fromJson(res);
    final resp = HomeSerial.fromJson(status.result ?? {});

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

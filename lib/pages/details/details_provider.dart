
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/widgets/dialog_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../helpers/config.dart';
import '../../helpers/helper.dart';
import '../../serialization/grid_card/grid_card.dart';
import '../../serialization/users/user_serial.dart';
import '../accounts/profile_public/profile_provider.dart';
import '../more_provider.dart';

part 'details_provider.g.dart';

@riverpod
class GetDetailPost extends _$GetDetailPost {
  String fields = 'photo,photos,thumbnails,thumbnail,renew_date,posted_date,link,highlight_specs,specs,description,category,views,total_like,is_like,total_comment,is_saved,location,user,store,email,phone,status,is_job_applied';
  String fun = 'save,chat,like,comment,apply_job,shipping';

  final Dio dio = Dio();
  final apiService = ViewApiService();
  String? ids;

  @override
  Future<GridCard> build(WidgetRef context, String id) {
    ids = id;
    return fetch();
  }

  Future<GridCard> fetch() async {
    try {
      state = const AsyncLoading();
      final tokens = ref.watch(usersProvider);
      final subs = 'feed/$ids?lang=$lang&fields=$fields&functions=$fun&filter_version=$filterVersion';
      final res = await dio.get('$postUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if(res.statusCode == 200) {
        final resp = GridCard.fromJson(res.data ?? {});
        await apiService.submitIncreaseViews({'id': ids});
        return resp;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await fetch(); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in : $e');
      print(stacktrace);
    }
    return GridCard();
  }

  Future<void> updateLikes(String ids, { bool? isLikes, bool? isSaved, bool? isFollow, }) async {
    final newMap = state.valueOrNull;
    if (newMap != null) {
      if(isLikes != null) {
        int total = newMap.data?.total_like ?? 0;
        newMap.data?.total_like = (isLikes == true) ? total + 1 : total - 1;
        newMap.data?.is_like = isLikes;
      }
      if(isSaved != null) newMap.data?.is_saved = isSaved;
      if(isFollow != null) newMap.data?.is_follow = isFollow;
      state = AsyncData(newMap);
    }
  }
}

@riverpod
class RelateDetailPost extends _$RelateDetailPost {
  late List<GridCard> list = [];
  String fields = 'thumbnail,photos,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,location';
  String fun = 'save,chat,like,comment,apply_job,shipping';

  final Dio dio = Dio();

  int limit = 0;
  int offset = 0;
  String? ids;

  @override
  Future<List<GridCard>> build(WidgetRef context, String id) {
    ids = id;
    return fetch();
  }

  Future<List<GridCard>> fetch() async {
    await urlAPI();
    return list;
  }

  Future<void> refresh() async {
    limit = 0;
    offset = 0;
    list = [];
    state = const AsyncLoading();

    await urlAPI();
    state = AsyncData(list);
  }

  Future<void> urlAPI() async {
    try {
      final accessTokens = ref.watch(usersProvider).tokens?.access_token;
      final subs = 'feed/$ids/relates?lang=$lang&offset=${offset + limit}&fields=$fields&functions=$fun';
      final res = await dio.get('$postUrl/$subs', options: Options(headers: (accessTokens != null) ? {
        'Access-Token': accessTokens
      } : null));

      final resp = HomeSerial.fromJson(res.data ?? {});

      if(res.statusCode == 200) {
        final data = resp.data;
        limit = resp.limit ?? 0;
        offset = resp.offset ?? 0;

        for (final val in data!) {
          final index = list.indexWhere((element) => element.data?.id == val?.data?.id);

          if (index != -1) {
            list[index] = val!;
          } else {
            list.add(val!);
          }
        }
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetch(); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in : $e');
      print(stacktrace);
    }
  }

  Future<void> updateLikes(String ids, { bool? isLikes, bool? isSaved }) async {
    final newList = state.valueOrNull;
    if (newList != null) {
      final index = newList.indexWhere((element) => element.data?.id == ids);
      if (index != -1) {
        if(isLikes != null) newList[index].data?.is_like = isLikes;
        if(isSaved != null) newList[index].data?.is_saved = isSaved;
        state = AsyncData(newList);
      }
    }
  }
}

class ViewApiService {
  final Dio dio = Dio();

  Future<MessageLogin> submitIncreaseViews(Map<String, dynamic> data) async {
    const subs = 'views';
    try {
      final res = await dio.post(
        '$postUrl/$subs', data: data,
        options: Options(contentType: Headers.jsonContentType),
      );
      print('object: IncreaseViews');
      return MessageLogin.fromJson(res.data ?? {});
    } on DioException catch (e) {
      return MessageLogin.fromJson(e.response?.data ?? {});
    }
  }
}


Future<void> submitFollow(
    WidgetRef ref,
    Data_? datum,
    GetDetailPostProvider providerDe,
    ) async {
  if(checkLogs(ref)) {
    final sendApi = ProfileSendApiService();
    if(datum?.is_follow == true) {
      showActionSheet(ref.context, [
        MoreTypeInfo('unfollow', 'Unfollow', null, null, () async {
          final res = await sendApi.submitFollow('unfollow', {
            'id': '${datum?.user?.id}',
            'type': 'user',
          }, ref: ref);
          if(res.message != null) {
            ref.read(providerDe.notifier).updateLikes('0', isFollow: false);
            alertSnack(ref.context, res.message ?? 'N/A');
          }
        }),
      ]);

    } else {
      final res = await sendApi.submitFollow('follow', {
        'id': '${datum?.user?.id}',
        'type': 'user',
      }, ref: ref);
      if(res.message != null) {
        ref.read(providerDe.notifier).updateLikes('0', isFollow: true);
        alertSnack(ref.context, res.message ?? 'N/A');
      }

    }
  }
}


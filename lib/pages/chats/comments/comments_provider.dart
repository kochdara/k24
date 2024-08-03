
// ignore_for_file: use_build_context_synchronously, avoid_renaming_method_parameters

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/accounts/edit_profile/edit_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/helper.dart';
import '../../../serialization/chats/comments/comments_serial.dart';
import '../../main/home_provider.dart';

part 'comments_provider.g.dart';

@riverpod
class CommentsPages extends _$CommentsPages {
  late List<CommentDatum> list = [];

  final Dio dio = Dio();
  int limit = 0;
  int offset = 0;
  int length = 1;

  @override
  Future<List<CommentDatum>> build(WidgetRef context) async {
    await fetchComments(context);
    return list;
  }

  Future<void> refresh({bool load = true}) async {
    list = [];
    limit = 0;
    offset = 0;
    length = 0;
    if (load) state = const AsyncLoading();
    await fetchComments(context);
    state = AsyncData(list);
  }

  Future<void> fetchComments(WidgetRef context) async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'me?lang=en&offset=$offset';
      final response = await dio.get(
        '$commentUrl/$subs',
        options: Options(headers: {
          'Access-Token': tokens.tokens?.access_token,
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final commentData = CommentSerial.fromJson(response.data);

        limit = commentData.limit ?? 0;
        length = commentData.data?.length ?? 0;
        if (commentData.data != null && commentData.data!.isNotEmpty) {
          offset += limit;
          for(final val in commentData.data ?? []) {
            // Find the index of the element with the same id as val
            final index = list.indexWhere((element) => element.id == val?.id);

            if (index != -1) {
              list[index] = val!;
            } else {
              list.add(val!);
            }
          }
        }
      }
      list.sort((a, b) => a.id!.compareTo(b.id.toString()));

      print(length);
      print(limit);
      print(offset);
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchComments(context); // Retry the request after refreshing the token
        return;
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error fetching comments: $e');
      print(stacktrace);
    }
  }
}

@riverpod
class ConversationComments extends _$ConversationComments {
  late List<CommentDatum> list = [];

  final Dio dio = Dio();
  String? postIDs;
  String? offset_comment_ids;
  String? sorts;
  String? reply_ids;
  int length = 1;

  @override
  Future<List<CommentDatum>> build(WidgetRef context, String postID, String? sort) async {
    postIDs = postID;
    sorts = sort;
    offset_comment_ids = '0';
    await fetchComments();
    return list;
  }

  Future<void> refresh({bool load = true}) async {
    list = [];
    if (load) state = const AsyncLoading();
    await fetchComments();
    state = AsyncData(list);
  }

  Future<void> fetchComments() async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = '$postIDs?lang=en';
      if(offset_comment_ids != null) subs += '&offset_comment_id=$offset_comment_ids';
      if(sorts != null) subs += '&sort=$sorts';
      final response = await dio.get(
        '$commentUrl/$subs',
        options: Options(headers: {
          'Access-Token': tokens.tokens?.access_token,
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final commentData = CommentSerial.fromJson(response.data);
        length = commentData.data?.length ?? 0;
        if (commentData.data != null && commentData.data!.isNotEmpty) {
          for(final val in commentData.data ?? []) {
            // Find the index of the element with the same id as val
            final index = list.indexWhere((element) => element.id == val?.id);

            if (index != -1) {
              list[index] = val!;
            } else {
              list.add(val!);
            }
          }
          if(list.lastOrNull?.id != null) offset_comment_ids = list.lastOrNull?.id.toString();
        }
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchComments(); // Retry the request after refreshing the token
        return;
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error fetching comments: $e');
      print(stacktrace);
    }
  }
}

@riverpod
class ReplyComments extends _$ReplyComments {
  late CommentDatum? mapData;

  final Dio dio = Dio();
  String? postIDs;
  String? sorts;
  String? reply_ids;

  @override
  FutureOr<CommentDatum?> build(WidgetRef context, String postID, String? sort, String? reply_id) async {
    postIDs = postID;
    sorts = sort;
    reply_ids = reply_id;
    await fetchComments();
    return mapData;
  }

  Future<void> fetchComments() async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = '$postIDs?lang=en';
      if(sorts != null) subs += '&sort=$sorts';
      if(reply_ids != null) subs += '&reply_id=$reply_ids';
      final response = await dio.get(
        '$commentUrl/$subs',
        options: Options(headers: {
          'Access-Token': tokens.tokens?.access_token,
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final commentData = CommentDatum.fromJson(response.data['data'] ?? {});
        mapData = commentData as CommentDatum?;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchComments(); // Retry the request after refreshing the token
        return;
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error fetching comments: $e');
      print(stacktrace);
    }
  }
}

Future<dynamic> submitMarkReadComment(String id, WidgetRef ref) async {
  final Dio dio = Dio();
  try {
    final tokens = ref.watch(usersProvider);
    final formData = { 'action': 'mark_as_read' };
    final subs = 'me/$id?lang=$lang';
    final res = await dio.put('$commentUrl/$subs', data: formData, options: Options(headers: {
      'Access-Token': '${tokens.tokens?.access_token}',
    }));
    return res.data;
  } on DioException catch (e) {
    final response = e.response;
    // Handle Dio-specific errors
    if (response?.statusCode == 401) {
      // Token might have expired, try to refresh the token
      await checkTokens(ref);
     return await submitMarkReadComment(id, ref); // Retry the request after refreshing the token
    }
    print('Dio error: ${e.message}');
  } catch (e, stacktrace) {
    _handleError('submitData', e, stacktrace);
  }
  return null;
}

class CommentApiService {
  final Dio dio = Dio();

  Future<CommentDatum> submitAddComment(Map<String, dynamic> data, WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);
      final formData = FormData.fromMap(data);
      final subs = 'me?lang=$lang';
      final res = await dio.post(
        '$commentUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}',
      }, contentType: Headers.formUrlEncodedContentType));
      final resp = CommentDatum.fromJson(res.data['data'] ?? {});

      return resp;
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(ref);
        return await submitAddComment(data, ref); // Retry the request after refreshing the token
      } else {
        myWidgets.showAlert(ref.context, '${e.response}', title: 'Alert');
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      _handleError('submitData', e, stacktrace);
    }
    return CommentDatum();
  }
}

void _handleError(String methodName, dynamic error, StackTrace stacktrace) {
  print('Error in $methodName: $error');
  print(stacktrace);
}

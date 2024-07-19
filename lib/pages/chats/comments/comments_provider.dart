
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/helper.dart';
import '../../../serialization/chats/comments/comments_serial.dart';
import '../../main/home_provider.dart';

part 'comments_provider.g.dart';

@riverpod
class CommentsPages extends _$CommentsPages {
  late List<CommentDatum> list = [];

  final Dio dio = Dio();

  @override
  Future<List<CommentDatum>> build(WidgetRef context) async {
    await fetchComments(context);
    return list;
  }

  Future<void> refresh({bool load = true}) async {
    list = [];
    if (load) state = const AsyncLoading();
    await fetchComments(context);
    state = AsyncData(list);
  }

  Future<void> fetchComments(WidgetRef context) async {
    final accessToken = await checkTokens(context);
    try {
      final tokens = context.watch(usersProvider);
      const subs = 'me?lang=en';
      final response = await dio.get(
        '$commentUrl/$subs',
        options: Options(headers: {
          'Access-Token': accessToken ?? tokens.tokens?.access_token,
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final commentData = CommentSerial.fromJson(response.data);

        if (commentData.data != null && commentData.data!.isNotEmpty) {
          final newData = commentData.data!.where((val) => val != null).cast<CommentDatum>().toList();
          list = mergeComments(list, newData);
        }
      }
    } catch (e, stacktrace) {
      print('Error fetching comments: $e');
      print(stacktrace);
    }
  }

  List<CommentDatum> mergeComments(List<CommentDatum> currentList, List<CommentDatum> newList) {
    final Map<String?, CommentDatum> mergedMap = {for (final item in currentList) item.id: item};
    for (final item in newList) {
      mergedMap[item.id] = item;
    }
    return mergedMap.values.toList();
  }
}

@riverpod
class ConversationComments extends _$ConversationComments {
  late List<CommentDatum> list = [];

  final Dio dio = Dio();

  @override
  Future<List<CommentDatum>> build(String postID, String? offset_comment_id, String? sort, String? reply_id) async {
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
      String subs = '$postID?lang=en';
      if(offset_comment_id != null) subs += '&offset_comment_id=$offset_comment_id';
      if(sort != null) subs += '&sort=$sort';
      if(reply_id != null) subs += '&reply_id=$reply_id';
      final response = await dio.get('$commentUrl/$subs');

      if (response.statusCode == 200 && response.data != null) {
        final commentData = CommentSerial.fromJson(response.data);

        if (commentData.data != null && commentData.data!.isNotEmpty) {
          final newData = commentData.data!.where((val) => val != null).cast<CommentDatum>().toList();
          list = mergeComments(list, newData);
        }
      }
    } catch (e, stacktrace) {
      print('Error fetching comments: $e');
      print(stacktrace);
    }
  }

  List<CommentDatum> mergeComments(List<CommentDatum> currentList, List<CommentDatum> newList) {
    final Map<String?, CommentDatum> mergedMap = {for (final item in currentList) item.id: item};
    for (final item in newList) {
      mergedMap[item.id] = item;
    }
    return mergedMap.values.toList();
  }
}

@riverpod
class ReplyComments extends _$ReplyComments {
  late CommentDatum? mapData;

  final Dio dio = Dio();

  @override
  FutureOr<CommentDatum?> build(String postID, String? offset_comment_id, String? sort, String? reply_id) async {
    await fetchComments();
    return mapData;
  }

  Future<void> fetchComments() async {
    try {
      String subs = '$postID?lang=en';
      if(offset_comment_id != null) subs += '&offset_comment_id=$offset_comment_id';
      if(sort != null) subs += '&sort=$sort';
      if(reply_id != null) subs += '&reply_id=$reply_id';
      final response = await dio.get('$commentUrl/$subs');

      if (response.statusCode == 200 && response.data != null) {
        final commentData = CommentDatum.fromJson(response.data['data'] ?? {});
        mapData = commentData as CommentDatum?;
      }
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
  } catch (e, stacktrace) {
    _handleError('submitData', e, stacktrace);
  }
  return null;
}

void _handleError(String methodName, dynamic error, StackTrace stacktrace) {
  print('Error in $methodName: $error');
  print(stacktrace);
}


// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/chats/chat_serial.dart';
import 'package:k24/serialization/chats/conversation/conversation_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

final Provider<int> delayed = Provider<int>((ref) => 5);

@riverpod
class ChatPage extends _$ChatPage {
  late List<ChatData> list = [];
  String fields = 'user,post,blocked';

  Dio dio = Dio();

  int limit = 20; // Default limit for pagination
  int currentPage = 0;
  late String type;

  @override
  FutureOr<List<ChatData>> build(WidgetRef context, String type) async {
    this.type = type;
    await fetchData();
    return list;
  }

  Future<void> refresh({bool load = true}) async {
    currentPage = 0;
    list = [];
    if (load) state = const AsyncLoading();
    await fetchData();
    state = AsyncData(list);
    print('Data length after refresh: ${list.length}');
  }

  Future<void> fetchData() async {
    try {
      final tokens = ref.read(usersProvider);
      final subs =
          'topics?type=$type&lang=en&offset=${currentPage * limit}&fields=$fields';
      final response = await dio.get('$chatUrl/$subs',
          options: Options(headers: {
            'Access-Token': tokens.tokens?.access_token,
          }));

      if (response.statusCode == 200) {
        final resp = ChatSerial.fromJson(response.data ?? {});
        if (resp.data != null && resp.data!.isNotEmpty) {
          final data = resp.data!;
          limit = resp.limit;
          currentPage++;

          for (final val in data) {
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
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchData(); // Retry the request after refreshing the token
      } else {
        print('Dio error: ${e.response}');
      }
    } catch (e, stacktrace) {
      print('Error: $e');
      print(stacktrace);
    }
  }
}

@riverpod
class ConversationPage extends _$ConversationPage {
  late List<ConData> list = [];
  String message_id = '';
  int length = 0;

  Dio dio = Dio();
  String? topic_ids;
  String? first_messages;
  String? to_ids;

  @override
  Stream<List<ConData>> build(WidgetRef context, String? topic_id, String first_message, String? to_id) async* {
    topic_ids = topic_id;
    first_messages = first_message;
    to_ids = to_id;

    final decode = ConData.fromJson(jsonDecode(first_messages!));
    if(decode.id != null) list.insert(0, decode);
    await urlAPI(first_message_id: '${decode.id}');
    yield list;
  }

  Future<void> getNew() async {
    await urlAPI(addNew: true);
    state = AsyncData(list);
  }

  Future<int> getOld() async {
    final length = await urlAPI();
    state = AsyncData(list);
    return length;
  }

  Future<void> refresh({ bool load = true }) async {
    list = [];
    if(load) state = const AsyncLoading();
    await urlAPI();
    state = AsyncData(list);
  }

  Future<int> urlAPI({
    bool addNew = false,
    int limited = 10,
    String first_message_id = '',
  }) async {
    length = 0;
    try {
      if(first_message_id.isNotEmpty) message_id = first_message_id;
      final tokens = context.watch(usersProvider);
      String subs = 'messages?lang=$lang&'
          'first_message_id=${(addNew)?'':message_id}&limit=$limited';
      if(topic_ids != null && topic_ids!.isNotEmpty && topic_ids != '0') {
        subs += '&topic_id=$topic_ids';
      } else {
        subs += '&to_id=$to_ids';
      }
      final res = await dio.get('$chatUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      final resp = ConSerial.fromJson(res.data ?? {});

      if (res.statusCode == 200 && resp.data!.isNotEmpty) {
        final data = resp.data;

        if(!addNew) message_id = '${data?.last?.id}';
        print(message_id);

        for (final val in data!) {
          // Find the index of the element with the same id as val
          final index = list.indexWhere((element) => element.id == val?.id);

          if (index != -1) {
            list[index] = val!;
          } else {
            if(addNew) { list.add(val!); }
            else { length = 2; list.insert(0, val!); }
          }
        }
      }
      list.sort((a, b) => a.id!.compareTo(b.id.toString()));
      return length;
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await getNew(); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in : $e');
      print(stacktrace);
    }
    return 0;
  }
}

void onScroll(WidgetRef ref, ScrollController scrollController,
    StateProvider<int> lengthProvider,
    ChatData chatData,
    StateProvider<double> pixelsPro,
  ) async {
  final maxScroll = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.position.pixels;
  ref.read(pixelsPro.notifier).state = currentScroll;
  if (currentScroll == maxScroll) {
    final len = ref.read(lengthProvider);
    if (len > 0) {
      final conversationPageNotifier = ref.read(conversationPageProvider(
        ref,
        '${chatData.id}',
        jsonEncode(chatData.last_message?.toJson() ?? {}),
        chatData.to_id
      ).notifier);

      final oldLength = await conversationPageNotifier.getOld();
      ref.read(lengthProvider.notifier).state = oldLength;
    }
  }
}


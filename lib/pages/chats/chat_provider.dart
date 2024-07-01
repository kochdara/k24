
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
StateProvider<bool> activePage = StateProvider<bool>((ref) => true);
StateProvider<bool> activePage2 = StateProvider<bool>((ref) => true);

@riverpod
class ChatPage extends _$ChatPage {
  late List<ChatData> list = [];
  String fields = 'user,post,blocked';

  Dio dio = Dio();

  int limit = 0;
  int currentPage = 0;

  @override
  FutureOr<List<ChatData>> build(WidgetRef context) async {
    await urlAPI();
    return list;
  }

  Future<void> refresh({ bool load = true }) async {
    limit = 0;
    currentPage = 0;
    list = [];
    if(load) state = const AsyncLoading();
    await urlAPI();
    state = AsyncData(list);
    print(list.length);
  }

  Future<void> urlAPI() async {
    activePage = StateProvider<bool>((ref) => true);
    final accessToken = await checkTokens(context);
    try {
      final tokens = ref.watch(usersProvider);
      final subs = 'topics?lang=en&offset=${currentPage * limit}&fields=$fields';
      final res = await dio.get('$chatUrl/$subs', options: Options(headers: {
        'Access-Token': '${accessToken ?? tokens.tokens?.access_token}',
      }));

      final resp = ChatSerial.fromJson(res.data ?? {});

      if (res.statusCode == 200 && resp.data!.isNotEmpty) {
        final data = resp.data;
        limit = resp.limit;
        currentPage++;

        for (final val in data!) {
          final contain = list.any((element) => element.id == val?.id);
          if(!contain) list.add(val!);
        }
      }
    } catch (e, stacktrace) {
      print('Error in : $e');
      print(stacktrace);
      activePage = StateProvider<bool>((ref) => false);
      return;
    }
  }
}

@riverpod
class ConversationPage extends _$ConversationPage {
  late List<ConData> list = [];
  String message_id = '';
  int length = 0;

  Dio dio = Dio();

  @override
  Stream<List<ConData>> build(WidgetRef context, String topic_id, String first_message) async* {
    final decode = ConData.fromJson(jsonDecode(first_message));
    list.insert(0, decode);
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
    activePage2 = StateProvider<bool>((ref) => true);
    final accessToken = await checkTokens(context);
    try {
      if(first_message_id.isNotEmpty) message_id = first_message_id;
      final tokens = ref.watch(usersProvider);
      final subs = 'messages?topic_id=$topic_id&lang=$lang&'
          'first_message_id=${(addNew)?'':message_id}&limit=$limited';
      final res = await dio.get('$chatUrl/$subs', options: Options(headers: {
        'Access-Token': '${accessToken ?? tokens.tokens?.access_token}'}
      ));

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

      return length;
    } catch (e, stacktrace) {
      print('Error in : $e');
      print(stacktrace);
      activePage2 = StateProvider<bool>((ref) => false);
      return 0;
    }
  }
}

class ChatApiService {
  final Dio dio = Dio();

  Future<ConData> submitData(Map<String, dynamic> data, WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);

      final formData = FormData.fromMap(data);
      final subs = 'messages?lang=$lang';
      final res = await dio.post('$chatUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}',
      }, contentType: Headers.formUrlEncodedContentType));
      final resp = ConData.fromJson(res.data ?? {});

      return resp;
    } catch (e, stacktrace) {
      _handleError('submitData', e, stacktrace);
      return ConData();
    }
  }

  Future<UploadTMPSerial> uploadData(Map<String, dynamic> data, WidgetRef ref) async {
    try {
      final tokens = ref.watch(usersProvider);

      final formData = FormData.fromMap(data);
      final subs = 'upload?lang=$lang';
      final res = await dio.post('$chatUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': '${tokens.tokens?.access_token}'
      }));
      final datum = res.data ?? {};
      final resp = UploadTMPSerial.fromJson(datum['data'] ?? {});

      return resp;
    } catch (e, stacktrace) {
      _handleError('uploadData', e, stacktrace);
      return UploadTMPSerial();
    }
  }

  void _handleError(String methodName, dynamic error, StackTrace stacktrace) {
    print('Error in $methodName: $error');
    print(stacktrace);
  }
}

void onScroll(WidgetRef ref, ScrollController scrollController,
    StateProvider<int> lengthProvider,
    ChatData chatData) async {
  final maxScroll = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.position.pixels;

  if (currentScroll == maxScroll) {
    final len = ref.read(lengthProvider);
    if (len > 0) {
      final conversationPageNotifier = ref.read(conversationPageProvider(
        ref,
        '${chatData.id}',
        jsonEncode(chatData.last_message?.toJson() ?? {}),
      ).notifier);

      final oldLength = await conversationPageNotifier.getOld();
      ref.read(lengthProvider.notifier).state = oldLength;
    }
  }
}


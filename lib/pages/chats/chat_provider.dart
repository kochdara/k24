
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/chats/chat_serial.dart';
import 'package:k24/serialization/chats/conversation/conversation_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

final Provider<int> delayed = Provider<int>((ref) => 2);

@riverpod
class ChatPage extends _$ChatPage {
  late List<ChatData> list = [];
  String fields = 'user,post,blocked';

  final Dio dio = Dio();

  int limit = 0;
  int currentPage = 0;

  @override
  FutureOr<List<ChatData>> build() async {
    await urlAPI();
    return list;
  }

  Future<void> refresh({bool loading = true}) async {
    limit = 0;
    currentPage = 0;
    list = [];
    if(loading) state = const AsyncLoading();
    await urlAPI();
    state = AsyncData(list);
  }

  Future<void> urlAPI() async {
    final tokens = ref.watch(usersProvider);
    final subs = 'topics?lang=en&offset=${currentPage * limit}&fields=$fields';
    final res = await dio.get('$chatUrl/$subs', options: Options(headers: {
      'Access-Token': '${tokens.tokens?.access_token}'
    }));
    currentPage++;

    final resp = ChatSerial.fromJson(res.data ?? {});

    if(res.statusCode == 200) {
      final data = resp.data;
      limit = resp.limit ?? 0;

      for (final val in data!) {
        list.add(val!);
      }
    }
  }
}

@riverpod
class ConversationPage extends _$ConversationPage {
  late List<ConData> list = [];
  final Dio dio = Dio();

  @override
  Stream<List<ConData>> build(String topic_id, { String first_message_id = '' }) async* {
    await urlAPI();
    yield list;
  }

  Stream<void> refresh({bool load = true}) async* {
    list = [];
    if(load) state = const AsyncLoading();
    await urlAPI();
    state = AsyncData(list);
  }

  Future<void> urlAPI() async {
    final tokens = ref.watch(usersProvider);
    final subs = 'messages?topic_id=$topic_id&lang=$lang&first_message_id=$first_message_id';
    final res = await dio.get('$chatUrl/$subs', options: Options(headers: {
      'Access-Token': '${tokens.tokens?.access_token}'
    }));

    final resp = ConSerial.fromJson(res.data ?? {});

    if(res.statusCode == 200) {
      final data = resp.data;

      for (final val in data!) {
        list.add(val!);
      }
    }
  }
}

class ChatApiService {
  final Dio dio = Dio();

  Future<ConData> submitData(Map<String, dynamic> data, WidgetRef ref, { required BuildContext context }) async {
    final tokens = ref.watch(usersProvider);

    final formData = FormData.fromMap(data);
    final subs = 'messages?lang=$lang';
    final res = await dio.post('$chatUrl/$subs', data: formData, options: Options(headers: {
      'Access-Token': '${tokens.tokens?.access_token}'
    }));
    final resp = ConData.fromJson(res.data ?? {});

    return resp;
  }
}

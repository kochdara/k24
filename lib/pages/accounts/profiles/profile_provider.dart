
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/serialization/accounts/profiles/profiles_own.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/helper.dart';

part 'profile_provider.g.dart';

@riverpod
class OwnProfileList extends _$OwnProfileList {
  late List<DatumProfile> list = [];
  String fields = 'id,title,price,photo,thumbnail,views,renew_date,posted_date,last_update,link,auto_renew,is_premium,status,total_like,total_comment,total_job_application,insights,category_type,availability';
  String fun = 'insights';

  final Dio dio = Dio();

  int limit = 0;

  @override
  Future<List<DatumProfile>> build(WidgetRef context, String accessTokens) async => fetchHome();

  Future<List<DatumProfile>> fetchHome() async {
    await urlAPI();
    return list;
  }

  Future<void> refresh() async {
    limit = 0;
    list = [];
    state = const AsyncLoading();

    await urlAPI();
    state = AsyncData(list);
  }

  Future<void> urlAPI() async {
    try {
      final accessToken = await checkTokens(context);
      final subs = 'me/posts?lang=en&fields=$fields&functions=$fun';
      final res = await dio.get('$baseUrl/$subs', options: Options(headers: {
        'Access-Token': accessToken ?? accessTokens
      }));

      final resp = OwnProfileSerial.fromJson(res.data ?? {});

      if(res.statusCode == 200) {
        final data = resp.data;
        limit = resp.limit ?? 0;

        for (final val in data!) {
          final index = list.indexWhere((element) => element.id == val?.id);

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

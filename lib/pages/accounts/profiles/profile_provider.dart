
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/accounts/profiles/profiles_own.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/helper.dart';
import '../../../serialization/users/user_serial.dart';
import '../../../widgets/dialog_builder.dart';

part 'profile_provider.g.dart';

final MyWidgets myWidgets = MyWidgets();

@riverpod
class OwnProfileList extends _$OwnProfileList {
  late List<DatumProfile> list = [];
  final String fields = 'id,title,price,photo,thumbnail,views,renew_date,posted_date,last_update,link,auto_renew,is_premium,status,total_like,total_comment,total_job_application,insights,category_type,availability';
  final String fun = 'insights';
  final Dio dio = Dio();
  int limit = 0;

  @override
  Future<List<DatumProfile>> build(WidgetRef context) async => fetchHome();

  // Fetch the initial list of profiles
  Future<List<DatumProfile>> fetchHome() async {
    await urlAPI();
    return list;
  }

  // Refresh the profile list by resetting the state and re-fetching the data
  Future<void> refresh() async {
    limit = 0;
    list = [];
    state = const AsyncLoading();
    await fetchHome();
    state = AsyncData(list);
  }

  // Makes an API call to fetch profiles
  Future<void> urlAPI() async {
    try {
      final accessToken = await checkTokens(context);
      final accessTokens = context.watch(usersProvider).tokens?.access_token;
      final subs = 'me/posts?lang=en&fields=$fields&functions=$fun';
      final res = await dio.get(
        '$baseUrl/$subs',
        options: Options(headers: {'Access-Token': accessToken ?? accessTokens}),
      );

      if (res.statusCode == 200) {
        final resp = OwnProfileSerial.fromJson(res.data ?? {});
        final data = resp.data ?? [];
        limit = resp.limit ?? 0;

        final updatedList = <DatumProfile>[];
        final existingIds = list.map((e) => e.id).toSet();

        for (final val in data) {
          if (existingIds.contains(val?.id)) {
            final index = list.indexWhere((element) => element.id == val?.id);
            if (index != -1) list[index] = val!;
          } else {
            updatedList.add(val!);
          }
        }

        list.addAll(updatedList);
      }
    } catch (e, stacktrace) {
      // Handle exceptions and log the error
      print('Error: $e');
      print(stacktrace);
    }
  }
}

@riverpod
class GetTotalPost extends _$GetTotalPost {
  final Dio dio = Dio();

  @override
  Future<OwnDataTotalPost?> build() async {
    final String? accessTokens = ref.watch(usersProvider).tokens?.access_token;

    try {
      final String subs = 'me/posts/total?lang=$lang';
      final res = await dio.get('$baseUrl/$subs', options: Options(headers: (accessTokens != null) ? {
        'Access-Token': accessTokens
      } : null));

      if (res.statusCode == 200) {
        final resp = OwnTotalPost.fromJson(res.data ?? {});
        return resp.data;
      } else {
        print('Failed to fetch data: ${res.statusCode}');
      }
    } catch (e, stacktrace) {
      print('Error: $e');
      print(stacktrace);
    }

    return null;
  }
}


class MyAccountApiService {
  final Dio dio = Dio();

  Future<void> submitRenew(
      String id, {
        required BuildContext context,
        required WidgetRef ref,
      }) async {
    dialogBuilder(context);

    try {
      final accessToken = ref.watch(usersProvider).tokens?.access_token;
      final checkTok = await checkTokens(ref);
      final String subs = '/me/posts/$id/renew?lang=$lang';

      // Close dialog
      await futureAwait(duration: 500, () {
        Navigator.pop(context);
      });

      final res = await dio.post(
        '$baseUrl/$subs',
        options: Options(headers: {
          'Access-Token': checkTok ?? accessToken
        }),
      );

      if (res.statusCode == 200) {
        final resp = MessageLogin.fromJson(res.data ?? {});
        alertSnack(context, resp.message ?? 'Operation successful');
      } else {
        alertSnack(context, 'Failed to renew post');
      }
    } on DioException catch (e) {

      if (e.response != null) {
        // Handle DioError with response
        final resp = MessageLogin.fromJson(e.response?.data ?? {});
        alertSnack(context, resp.message ?? 'Error occurred');
      } else {
        // Handle DioError without response
        myWidgets.showAlert(context, 'Error: $e');
      }
    } catch (e) {
      myWidgets.showAlert(context, 'Unexpected error: $e');
    }
  }

  void alertSnack(BuildContext context, String title) {
    final snackBar = SnackBar(
      content: Text(title),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

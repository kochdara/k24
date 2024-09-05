
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/settings/settings_provider.dart';
import 'package:k24/serialization/accounts/profiles/profiles_own.dart';
import 'package:k24/serialization/posts/post_serials.dart';
import 'package:k24/widgets/buttons.dart';
import 'package:k24/widgets/forms.dart';
import 'package:k24/widgets/labels.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../helpers/helper.dart';
import '../../../serialization/category/main_category.dart';
import '../../../serialization/grid_card/grid_card.dart';
import '../../../serialization/users/user_serial.dart';
import '../../../widgets/dialog_builder.dart';
import '../../details/details_post.dart';
import '../../posts/post_page.dart';
import '../../posts/post_provider.dart';

part 'profile_provider.g.dart';

final MyWidgets myWidgets = MyWidgets();
final labels = Labels();
final forms = Forms();
final config = Config();
final buttons = Buttons();

@riverpod
class LoginInformation extends _$LoginInformation {
  final Dio dio = Dio();

  @override
  Future<UserProfile?> build(WidgetRef context,) async {
    try {
      final String? accessToken = context.watch(usersProvider).tokens?.access_token;

      final String subs = 'me?lang=$lang';
      final Response res = await dio.get('$baseUrl/$subs', options: Options(headers: (accessToken != null) ? {
        'Access-Token': accessToken,
      } : null));

      if (res.statusCode == 200) {
        final dataUser = UserProfile.fromJson(res.data['data'] ?? {});
        updateUserPro(context, 'user', dataUser);
        return dataUser;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await build(context,); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error: $e');
      print('Stacktrace: $stacktrace');
    }
    return UserProfile();
  }

  Future<void> updateAt(String type, dynamic value) async {
    final newMap = state.valueOrNull;
    if(newMap != null) {
      switch(type) {
        default:
          break;
      }
      state = AsyncData(newMap);
    }
  }
}

@riverpod
class OwnProfileList extends _$OwnProfileList {
  late List<DatumProfile> list = [];
  final String fields = 'id,title,price,photo,thumbnail,views,renew_date,posted_date,last_update,link,auto_renew,is_premium,status,total_like,total_comment,total_job_application,insights,category_type,availability';
  final String fun = 'like,comment,apply_job,shipping,insights';
  final Dio dio = Dio();
  int limit = 0;
  int offset = 0;
  int length = 1;
  late Map<String, dynamic>? newMaps;

  @override
  Future<List<DatumProfile>> build(WidgetRef context, Map<String, dynamic>? newMap) async => fetchHome(newMap);

  // Fetch the initial list of profiles
  Future<List<DatumProfile>> fetchHome(Map<String, dynamic>? newMap) async {
    newMaps = newMap;
    await urlAPI();
    return list;
  }

  // Refresh the profile list by resetting the state and re-fetching the data
  Future<void> refresh() async {
    limit = 0;
    offset = 0;
    length = 1;
    list = [];
    // state = const AsyncLoading();
    await fetchHome(newMaps);
    state = AsyncData(list);
  }

  // Makes an API call to fetch profiles
  Future<void> urlAPI() async {
    try {
      final accessTokens = context.watch(usersProvider).tokens?.access_token;
      String subs = 'me/posts?lang=en&fields=$fields&functions=$fun&offset=$offset';
      if(newMaps != null) {
        newMaps?.forEach((key, value) {
          subs += '&$key=$value';
        });
      }
      final res = await dio.get(
        '$baseUrl/$subs',
        options: Options(headers: {'Access-Token':  accessTokens}),
      );

      print(subs);

      if (res.statusCode == 200) {
        final resp = OwnProfileSerial.fromJson(res.data ?? {});
        final data = resp.data ?? [];
        limit = resp.limit ?? 0;
        length = data.length;
        if(data.isNotEmpty) offset = offset + limit;

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
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        await fetchHome(newMaps); // Retry the request after refreshing the token
        return;
      }
    } catch (e, stacktrace) {
      // Handle exceptions and log the error
      print('Error: $e');
      print(stacktrace);
    }
  }

  Future<void> updatedAt(String? ids, { DateTime? renewDate,
    bool? isDelete,
  }) async {
    final newList = state.valueOrNull;
    if (newList != null) {
      final index = newList.indexWhere((element) => element.id == ids);
      if (index != -1) {
        if(renewDate != null) newList[index].renew_date = renewDate;
        if(isDelete == true) newList.removeAt(index);
        state = AsyncData(newList);
      }
    }
  }
}

@riverpod
class GetTotalPost extends _$GetTotalPost {
  final Dio dio = Dio();

  @override
  Future<OwnDataTotalPost?> build(WidgetRef context) async {
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
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await build(context); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error: $e');
      print(stacktrace);
    }

    return null;
  }
}


@riverpod
class GetDeleteReason extends _$GetDeleteReason {
  final Dio dio = Dio();

  @override
  Future<DeleteReasonSerial?> build(WidgetRef context) async {
    final String? accessTokens = ref.watch(usersProvider).tokens?.access_token;

    try {
      final String subs = 'me/posts/delete_reasons?lang=$lang';
      final res = await dio.get('$baseUrl/$subs', options: Options(headers: (accessTokens != null) ? {
        'Access-Token': accessTokens
      } : null));

      if (res.statusCode == 200) {
        final resp = DeleteReasonSerial.fromJson(res.data ?? {});
        return resp;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await build(context); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.message}');
    } catch (e, stacktrace) {
      print('Error: $e');
      print(stacktrace);
    }

    return null;
  }
}


@riverpod
class GetPostFilter extends _$GetPostFilter {
  final Dio dio = Dio();

  @override
  Future<CategoryPostSerial?> build(WidgetRef context) async {
    final String? accessTokens = ref.watch(usersProvider).tokens?.access_token;

    try {
      final String subs = 'me/posts/posted_categories?lang=$lang&v=1';
      final res = await dio.get('$baseUrl/$subs', options: Options(headers: (accessTokens != null) ? {
        'Access-Token': accessTokens
      } : null));

      if (res.statusCode == 200) {
        final resp = CategoryPostSerial.fromJson(res.data ?? {});
        return resp;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await build(context); // Retry the request after refreshing the token
      }
      print('Dio error: ${e.message}');
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
      String id, OwnProfileListProvider provider, {
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
        ref.read(provider.notifier).updatedAt(id, renewDate: DateTime.now());
        alertSnack(context, resp.message ?? 'Operation successful');
      } else {
        alertSnack(context, 'Failed to renew post');
      }

    } on DioException catch (e) {
      if (e.response != null) {
        final response = e.response;
        // Handle DioError with response
        final resp = MessageLogin.fromJson(response?.data ?? {});
        alertSnack(context, resp.message ?? 'Error occurred');
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          await submitRenew(id, provider, context: context, ref: ref); // Retry the request after refreshing the token
          return;
        }
        print('Dio error: ${e.message}');
      } else {
        // Handle DioError without response
        myWidgets.showAlert(context, 'Error: $e');
      }
    } catch (e) {
      myWidgets.showAlert(context, 'Unexpected error: $e');
    }
  }

  Future<void> submitDelete(
      String id, Map data, OwnProfileListProvider provider, {
        required BuildContext context,
        required WidgetRef ref,
      }) async {
    dialogBuilder(context);

    try {
      final accessToken = ref.watch(usersProvider).tokens?.access_token;
      final checkTok = await checkTokens(ref);
      final String subs = '/me/posts/$id?lang=$lang';

      // Close dialog
      await futureAwait(duration: 500, () {
        Navigator.pop(context);
      });

      final res = await dio.delete(
        '$baseUrl/$subs',
        data: data,
        options: Options(headers: {
          'Access-Token': checkTok ?? accessToken
        }),
      );

      if (res.statusCode == 200) {
        final resp = MessageLogin.fromJson(res.data ?? {});
        ref.read(provider.notifier).updatedAt(id, isDelete: true);
        alertSnack(context, resp.message ?? 'Operation successful');
      } else {
        alertSnack(context, 'Failed to renew post');
      }

    } on DioException catch (e) {
      if (e.response != null) {
        final response = e.response;
        // Handle DioError with response
        final resp = MessageLogin.fromJson(response?.data ?? {});
        alertSnack(context, resp.message ?? 'Error occurred');
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          await submitRenew(id, provider, context: context, ref: ref); // Retry the request after refreshing the token
          return;
        }
        print('Dio error: ${e.message}');
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

class DeleteReasonDialog extends StatefulWidget {
  final DeleteReasonSerial? deleteData;
  final StateController<Map> notifier;

  const DeleteReasonDialog({
    super.key,
    required this.deleteData,
    required this.notifier,
  });

  @override
  State<DeleteReasonDialog> createState() => _DeleteReasonDialogState();
}

class _DeleteReasonDialogState extends State<DeleteReasonDialog> {
  final formKey = GlobalKey<FormState>();
  late Map currentState;

  @override
  void initState() {
    super.initState();
    currentState = widget.notifier.state;
  }

  void _updateState(Map<String, dynamic> newState) {
    setState(() {
      currentState = {...currentState, ...newState};
    });
    widget.notifier.state = currentState;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.deleteData?.data;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          shape: const Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                          title: labels.label(
                            'Delete Reason',
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Divider(height: 0, color: Colors.black12,),

                        for (final datum in data ?? [])
                          ListTile(
                            onTap: () {
                              _updateState({'reason': datum?.value.toString()});
                            },
                            shape: const Border(bottom: BorderSide(color: Colors.black12)),
                            title: labels.label(
                              datum?.en ?? 'N/A',
                              fontSize: 15,
                              color: Colors.black87,
                              maxLines: 1,
                            ),
                            trailing: (currentState['reason'] == datum?.value.toString()) ? Icon(
                              Icons.check_circle_outline_outlined,
                              size: 22,
                              color: config.warningColor.shade600,
                            ) : null,
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (currentState['reason'] == data?.last?.value.toString()) ...[
                                labels.label(
                                  'Reason:',
                                  fontSize: 15,
                                  color: Colors.black87,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 5),
                                forms.labelFormFields(
                                  validator: ValidationBuilder().required().build(),
                                  onChanged: (val) {
                                    _updateState({'description': val.toString()});
                                  },
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 16),
                              ],
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: buttons.textButtons(
                                      title: 'Cancel',
                                      textSize: 15,
                                      padding: const EdgeInsets.all(12),
                                      onPressed: () => Navigator.of(context).pop(),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 4,
                                    child: buttons.textButtons(
                                      title: 'Submit',
                                      textSize: 15,
                                      padding: const EdgeInsets.all(12),
                                      textColor: Colors.white,
                                      bgColor: config.warningColor.shade600,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          Navigator.of(context).pop('success');
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 250),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future showDeleteReasonDialog(BuildContext context, WidgetRef ref, DeleteReasonSerial? deleteData, StateProvider<Map> newVal) async {
  final notifier = ref.read(newVal.notifier);
  return await showDialog<void>(
    context: context,
    builder: (context) {
      return DeleteReasonDialog(deleteData: deleteData, notifier: notifier);
    },
  );
}


void handleView(BuildContext context, DatumProfile datum) {
  final result = GridCard(type: 'post', data: Data_.fromJson(datum.toJson()), actions: datum.actions ?? []);
  routeAnimation(
    context,
    pageBuilder: DetailsPost(title: datum.title ?? 'N/A', data: result),
  );
}

Future<void> handleEdit(BuildContext context, WidgetRef ref, DatumProfile datum) async {
  final res = await getEditPostInfoProvider(ref, datum.id ?? '');
  final mainCat = res.data?.post?.category;
  routeAnimation(
    context,
    pageBuilder: NewAdPage(
      mainPro: MainCategory(id: mainCat?.parent ?? '', en_name: '', slug: '', parent: ''),
      subPro: MainCategory(id: mainCat?.id ?? '', en_name: mainCat?.en_name ?? '', parent: mainCat?.parent ?? '',),
      type: 'edit',
      editData: res,
      datum: datum,
    ),
  );
}

bool checkDate(String date) {
  DateTime? dateTime = DateTime.tryParse(date);
  final now = DateTime.now();
  final difference = now.difference(dateTime!);
  return difference.inHours < 12;
}

class ButtonsUI extends StatelessWidget {
  const ButtonsUI({super.key, required this.title, required this.onPressed,
    required this.prefixIcon, required this.width,
    required this.badge,
  });

  final String title;
  final IconData? prefixIcon;
  final VoidCallback? onPressed;
  final double width;
  final String badge;

  @override
  Widget build(BuildContext context) {
    final badges = int.tryParse(badge) ?? 0;

    return SizedBox(
      width: width / 2,
      child: Stack(
        children: [
          buttons.textButtons(
            title: title,
            onPressed: onPressed,
            padSize: 8,
            textSize: 14,
            textColor: config.secondaryColor.shade300,
            prefixIcon: prefixIcon,
            prefColor: config.secondaryColor.shade300,
            prefixSize: 18,
            mainAxisAlignment: MainAxisAlignment.start,
          ),

          if(badges > 0) Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: config.warningColor.shade600,
                borderRadius: BorderRadius.circular(6.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              child: labels.label('${badges < 100 ? badges : '99+'}', fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}

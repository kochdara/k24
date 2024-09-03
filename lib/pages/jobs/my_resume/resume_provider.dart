
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/serialization/jobs/my_resume/my_resume_serial.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'resume_provider.g.dart';

@riverpod
class GetResumeInfo extends _$GetResumeInfo {
  final Dio dio = Dio();
  final String fields = 'basic_info,personal_details,educations,experiences,languages,skills,attachment,references,summary,hobbies,preference';

  @override
  FutureOr<MyResumeSerial?> build(WidgetRef context,) async {
    return fetchHome();
  }

  FutureOr<MyResumeSerial?> fetchHome() async {
    try {
      final tokens = context.watch(usersProvider);
      String subs = 'me/resume?lang=$lang&fields=$fields';
      final res = await dio.get('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));

      if (res.statusCode == 200 && res.data != null) {
        final data = MyResumeSerial.fromJson(res.data ?? {});
        return data;
      }
    } on DioException catch (e) {
      final response = e.response;
      // Handle Dio-specific errors
      if (response?.statusCode == 401) {
        // Token might have expired, try to refresh the token
        await checkTokens(context);
        return await fetchHome(); // Retry the request after refreshing the token
      }

      print('Dio error: ${e.response}');
    } catch (e, stacktrace) {
      print('Error in _fetchData: $e');
      print(stacktrace);
    }
    return null;
  }

  Future<void> removeAt(String ids, String type) async {
    final newList = state.valueOrNull;
    if (newList != null) {
      switch(type) {
        case 'ref_move_to_top':
        case 'ref_move_up':
        case 'ref_move_to_bottom':
        case 'ref_move_down':
          final datum = newList.data?.references ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            // Get the educations to move
            final languageToMove = datum[index];
            if (languageToMove != null) {
              // Remove the educations from its current position
              datum.removeAt(index);
              // Insert the educations at the first index
              if(type == 'ref_move_to_top') {
                datum.insert(0, languageToMove);
              } else if(type == 'ref_move_to_bottom') {
                datum.add(languageToMove);
              } else if(type == 'ref_move_up') {
                datum.insert(index - 1, languageToMove);
              } else if(type == 'ref_move_down') {
                datum.insert(index + 1, languageToMove);
              }
            }
          }
          break;
        case 'lang_move_to_top':
        case 'lang_move_up':
        case 'lang_move_to_bottom':
        case 'lang_move_down':
          final datum = newList.data?.languages ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            // Get the educations to move
            final languageToMove = datum[index];
            if (languageToMove != null) {
              // Remove the educations from its current position
              datum.removeAt(index);
              // Insert the educations at the first index
              if(type == 'lang_move_to_top') {
                datum.insert(0, languageToMove);
              } else if(type == 'lang_move_to_bottom') {
                datum.add(languageToMove);
              } else if(type == 'lang_move_up') {
                datum.insert(index - 1, languageToMove);
              } else if(type == 'lang_move_down') {
                datum.insert(index + 1, languageToMove);
              }
            }
          }
          break;
        case 'skill_move_to_top':
        case 'skill_move_up':
        case 'skill_move_to_bottom':
        case 'skill_move_down':
          final datum = newList.data?.skills ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            // Get the educations to move
            final skillToMove = datum[index];
            if (skillToMove != null) {
              // Remove the educations from its current position
              datum.removeAt(index);
              // Insert the educations at the first index
              if(type == 'skill_move_to_top') {
                datum.insert(0, skillToMove);
              } else if(type == 'skill_move_to_bottom') {
                datum.add(skillToMove);
              } else if(type == 'skill_move_up') {
                datum.insert(index - 1, skillToMove);
              } else if(type == 'skill_move_down') {
                datum.insert(index + 1, skillToMove);
              }
            }
          }
          break;
        case 'edu_move_to_top':
        case 'edu_move_up':
        case 'edu_move_to_bottom':
        case 'edu_move_down':
          final datum = newList.data?.educations ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            // Get the educations to move
            final educationsToMove = datum[index];
            if (educationsToMove != null) {
              // Remove the educations from its current position
              datum.removeAt(index);
              // Insert the educations at the first index
              if(type == 'edu_move_to_top') {
                datum.insert(0, educationsToMove);
              } else if(type == 'edu_move_to_bottom') {
                datum.add(educationsToMove);
              } else if(type == 'edu_move_up') {
                datum.insert(index - 1, educationsToMove);
              } else if(type == 'edu_move_down') {
                datum.insert(index + 1, educationsToMove);
              }
            }
          }
          break;
        case 'move_to_top':
        case 'move_up':
        case 'move_to_bottom':
        case 'move_down':
          final datum = newList.data?.experiences ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            // Get the experience to move
            final experienceToMove = datum[index];
            if (experienceToMove != null) {
              // Remove the experience from its current position
              datum.removeAt(index);
              // Insert the experience at the first index
              if(type == 'move_to_top') {
                datum.insert(0, experienceToMove);
              } else if(type == 'move_to_bottom') {
                datum.add(experienceToMove);
              } else if(type == 'move_up') {
                datum.insert(index - 1, experienceToMove);
              } else if(type == 'move_down') {
                datum.insert(index + 1, experienceToMove);
              }
            }
          }
          break;

        case 'references':
          final datum = newList.data?.references ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            datum.removeAt(index);
          }
          break;
        case 'languages':
          final datum = newList.data?.languages ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            datum.removeAt(index);
          }
          break;
        case 'skills':
          final datum = newList.data?.skills ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            datum.removeAt(index);
          }
          break;
        case 'educations':
          final datum = newList.data?.educations ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            datum.removeAt(index);
          }
          break;
        case 'experiences':
          final datum = newList.data?.experiences ?? [];
          final index = datum.indexWhere((element) => element?.id == ids);
          if (index != -1) {
            datum.removeAt(index);
          }
          break;
        default:
          break;
      }
    }
    state = AsyncData(newList);
  }
}

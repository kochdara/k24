
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/helper.dart';
import 'package:k24/pages/main/home_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/serialization/jobs/my_resume/my_resume_serial.dart';
import 'package:k24/widgets/my_widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../widgets/dialog_builder.dart';

part 'resume_provider.g.dart';

final myWidgets = MyWidgets();

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

        case 'attachment':
          final datum = newList.data;
          if (datum?.attachment?.id == ids) {
            datum?.attachment = null;
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

  Future<void> updateAt(String type, dynamic value) async {
    final newList = state.valueOrNull;
    if (newList != null) {
      switch(type) {
        case 'attachment':
          final newAttach = MyResumeAttachment.fromJson(value ?? {});
          newList.data?.attachment = newAttach;
          break;

        default:
          break;
      }
      state = AsyncData(newList);
    }
  }
}


class MoreApiService {
  final dio = Dio();

  Future<PersonalSerial?> downloadAttachment(WidgetRef ref, Map<String, dynamic> data, ) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final formData = FormData.fromMap(data);
    final subs = 'me/resume/download?lang=$lang';
    try {
      final res = await dio.post('$jobUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token,
      }));
      Navigator.pop(ref.context);
      return PersonalSerial.fromJson(res.data ?? {});
    } on DioException catch (e) {
      Navigator.pop(ref.context);
      if (e.response != null) {
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await downloadAttachment(ref, data); // Retry the request after refreshing the token
        } else {
          myWidgets.showAlert(ref.context, '${e.response ?? 'Sorry you can\'t download this attachment.\nPlease try again.'}', title: 'Alert');
        }
      }
    } catch (e) {
      print(e);
    }
    return PersonalSerial();
  }

  Future<PersonalSerial?> submitAttachment(WidgetRef ref , Map<String, dynamic> data, ) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final formData = FormData.fromMap(data);
    final subs = 'me/resume/attachment?lang=$lang';
    try {
      final res = await dio.post('$jobUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }));
      Navigator.pop(ref.context);
      return PersonalSerial.fromJson(res.data ?? {});
    } on DioException catch (e) {
      Navigator.pop(ref.context);
      if (e.response != null) {
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await submitAttachment(ref, data); // Retry the request after refreshing the token
        } else {
          myWidgets.showAlert(ref.context, '${e.response ?? 'Sorry you can\'t update this attachment.\nPlease try again.'}', title: 'Alert');
        }
      }
    } catch (e) {
      print(e);
    }
    return PersonalSerial();
  }

  Future<PersonalSerial?> deleteAttachment(WidgetRef ref,) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final subs = 'me/resume/attachment?lang=$lang';
    try {
      final res = await dio.delete('$jobUrl/$subs', options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }));
      Navigator.pop(ref.context);
      return PersonalSerial.fromJson(res.data ?? {});
    } on DioException catch (e) {
      Navigator.pop(ref.context);
      if (e.response != null) {
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await deleteAttachment(ref); // Retry the request after refreshing the token
        } else {
          myWidgets.showAlert(ref.context, '${e.response ?? 'Sorry you can\'t delete this attachment.\nPlease try again.'}', title: 'Alert');
        }
      }
    } catch (e) {
      print(e);
    }
    return PersonalSerial();
  }

  Future<PersonalSerial?> submitApplyJobs(WidgetRef ref, Map<String, dynamic> data) async {
    dialogBuilder(ref.context);
    final tokens = ref.watch(usersProvider);
    final formData = FormData.fromMap(data);
    final subs = 'me/apply_job/easy_apply?lang=$lang';
    try {
      final res = await dio.post('$jobUrl/$subs', data: formData, options: Options(headers: {
        'Access-Token': tokens.tokens?.access_token
      }));
      Navigator.pop(ref.context);
      return PersonalSerial.fromJson(res.data ?? {});
    } on DioException catch (e) {
      Navigator.pop(ref.context);
      if (e.response != null) {
        // Handle DioError with response
        final response = e.response;
        // Handle Dio-specific errors
        if (response?.statusCode == 401) {
          // Token might have expired, try to refresh the token
          await checkTokens(ref);
          return await submitApplyJobs(ref, data); // Retry the request after refreshing the token
        } else {
          myWidgets.showAlert(ref.context, '${e.response ?? 'Sorry you can\'t submit this resume.\nPlease try again.'}', title: 'Alert');
        }
      }
    } catch (e) {
      print(e);
    }
    return PersonalSerial();
  }
}

Future<void> filePickerAttach(WidgetRef ref, GetResumeInfoProvider provider) async {
  final sendApi = MoreApiService();
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ['doc', 'DOCX', 'pdf', 'txt'],
  );

  if (result != null) {
    final xFiles = result.files.first.xFile;
    final multipartImage = MultipartFile.fromFileSync(xFiles.path, filename: xFiles.name);
    final res = await sendApi.submitAttachment(ref, {
      "file": multipartImage,
      "name": xFiles.name,
    });
    if(res?.status == 'success') {
      alertSnack(ref.context, '${res?.message}');
      ref.read(provider.notifier).updateAt('attachment', res?.data);
    }
    print(res?.toJson());
  }
}

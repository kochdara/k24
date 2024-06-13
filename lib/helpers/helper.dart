//
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> futureAwait(void Function() T, { int duration = 1000 }) async {
  await Future.delayed(Duration(milliseconds: duration), T);
}

extension DebounceAndCancelExtension on Ref {
  Future<Dio> getDebouncedHttpClient([Duration? duration]) async {

    bool didDispose = false;
    onDispose(() => didDispose = true);
    await Future<void>.delayed(duration ?? const Duration(milliseconds: 100));

    if (didDispose) {
      throw Exception('Cancelled');
    }

    final dio = Dio();
    onDispose(dio.close);

    return dio;
  }
}

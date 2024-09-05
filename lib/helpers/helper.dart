//
// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:k24/pages/accounts/login/login_provider.dart';
import 'package:k24/pages/main/home_provider.dart';

final myService = MyApiService();

FutureOr<String?> checkTokens(WidgetRef ref) async {
  DateTime expDate = DateTime.now();
  final tokens = ref.watch(usersProvider);
  try {
    expDate = JwtDecoder.getExpirationDate('${tokens.tokens?.access_token}');
    /// exchange token ///
    if(expDate.isBefore(DateTime.now())) {
    // if(expDate.compareTo(DateTime.now().subtract(const Duration(seconds: 2))) <= 0) {
      final tokens = await myService.getNewToken(ref);
      print('@# exchange');
      await futureAwait(duration: 1500, () {},);
      return tokens.access_token;
    }

  } catch(e) {print('@# $e');}
  return null;
}

Future routeNoAnimation(BuildContext context, { required Widget pageBuilder }) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => pageBuilder,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

Future routeAnimation(BuildContext context, { required Widget pageBuilder }) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => pageBuilder),
  );
}

Future routePopAndPush(BuildContext context, { required Widget pageBuilder }) {
  if(Navigator.canPop(context)) Navigator.pop(context);
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => pageBuilder),
  );
}

Future<void> futureAwait(void Function() T, { int duration = 1000 }) async {
   await Future.delayed(Duration(milliseconds: duration), T);
}

extension DebounceAndCancelExtension on Ref {
  Future<Dio> getDebouncedHttpClient(WidgetRef ref2, [Duration? duration]) async {

    bool didDispose = false;
    onDispose(() => didDispose = true);
    await Future<void>.delayed(duration ?? const Duration(milliseconds: 500));

    if (didDispose) {
      throw Exception('Cancelled');
    }

    final dio = Dio();
    onDispose(dio.close);

    DateTime expDate = DateTime.now();
    final tokens = ref2.watch(usersProvider);
    try {
      expDate = JwtDecoder.getExpirationDate('${tokens.tokens?.access_token}');
      /// exchange token ///
      if(expDate.compareTo(DateTime.now()) <= 0) await myService.getNewToken(ref2);

    } catch(e) {
      print('@# $e');
    }

    return dio;
  }
}

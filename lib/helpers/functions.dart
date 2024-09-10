
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/accounts/likes/my_like_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/pages/saves/save_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> sharedLinks(BuildContext rootContext, String? links) async {
  final result = await Share.share(
    links ?? mainUrl,
    subject: 'Share',
  );
  if (result.status == ShareResultStatus.success) {
    alertSnack(rootContext, 'Shared successfully!.');
  }
}

Future<void> openLinkFunction(String links) async {
  if(links.isEmpty) return;
  // Replace "https://" and split by "/"
  final String modifiedUrl = links.replaceFirst('https://', '');
  final List<String> urlParts = modifiedUrl.split('/');

  // You can reassemble or manipulate the parts if needed
  const String scheme = 'https';
  final String host = urlParts[0];
  final String path = urlParts.sublist(1).join('/');

  final Uri smsLaunchUri = Uri(
    scheme: scheme,
    host: host,
    path: path,
  );

  await launchUrl(smsLaunchUri);
}

Future<void> savedFunctions(WidgetRef ref, String? id, dynamic provider, {
  bool? isSaved, String? type = 'user', String? typeRemove = 'post',
}) async {
  if(checkLogs(ref)) {
    final send = SaveApiService();
    if(isSaved == true) {
      final result = await send.submitRemoveSave(ref, id, type: typeRemove);
      print(result.toJson());
      if(result.message != null) {
        ref.read(provider.notifier).updateLikes(id, isSaved: false);
      }
    } else {
      final result = await send.submitSaved(ref, id: id, type: type);
      print(result.toJson());
      if(result.message != null) {
        ref.read(provider.notifier).updateLikes(id, isSaved: true);
      }
    }
  }
}

Future<void> likedFunction(WidgetRef ref, String ids, bool isLiked, dynamic provider) async {
  if(checkLogs(ref)) {
    final submit = MyAccountApiService();
    if (isLiked) {
      final result = await submit.submitRemove(id: ids, ref: ref);
      if(result.message != null) {
        ref.read((provider).notifier).updateLikes(ids, isLikes: false);
        print(result.toJson());
      }
    } else {
      final dataSend = {'id': ids, 'type': 'post'};
      final result = await submit.submitAdd(dataSend, ref: ref);
      if(result.message != null) {
        ref.read((provider).notifier).updateLikes(ids, isLikes: true);
        print(result.toJson());
      }

    }
  }
}

void copyFunction(BuildContext context, String? text, {
  String message = 'Copied!',
}) {
  Clipboard.setData(ClipboardData(text: text ?? '')).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  });
}

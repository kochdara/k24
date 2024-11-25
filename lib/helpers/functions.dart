
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/pages/accounts/likes/my_like_provider.dart';
import 'package:k24/pages/more_provider.dart';
import 'package:k24/pages/saves/save_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

Future<void> openMap(String? latitude, String? longitude) async {
  final googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}

Future<bool> launchUrlPhone({
  String? scheme,
  String? userInfo,
  String? host,
  int? port,
  String? path,
  Iterable<String>? pathSegments,
  String? query,
  Map<String, dynamic>? queryParameters,
  String? fragment,
}) async {
  final Uri smsLaunchUri = Uri(
    scheme: scheme,
    userInfo: userInfo,
    host: host,
    port: port,
    path: path,
    pathSegments: pathSegments,
    query: query,
    queryParameters: queryParameters,
    fragment: fragment,
  );
  return await launchUrl(smsLaunchUri);
}

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
  final String host = (urlParts.isNotEmpty) ? urlParts[0] : '';
  final String path = (urlParts.length > 1) ? urlParts.sublist(1).join('/') : '';

  final Uri smsLaunchUri = Uri(
    scheme: scheme,
    host: host,
    path: path,
  );

  await launchUrl(Uri.tryParse(links) ?? smsLaunchUri);
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

Future<String?> getIpAddress() async {
  try {
    // Get a list of all network interfaces
    final interfaces = await NetworkInterface.list();

    // Loop through the interfaces to find the one with an IPv4 address
    for (var interface in interfaces) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4) {
          return addr.address; // Return the first found IPv4 address
        }
      }
    }
  } catch (e) {
    print('Failed to get IP address: $e');
  }
  return null;
}

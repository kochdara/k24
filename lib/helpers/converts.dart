// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

String? stringToString({ String date = '2024-01-01', String format = 'dd-MM-yyyy', }) {
  try {
    DateTime dateTime = DateTime.parse(date);
    var outputDate = DateFormat(format).format(dateTime);
    return outputDate;
  } catch (e) {
    return null;
  }
}

String? stringToTimeAgoDay({ String date = '2024-01-01', String format = 'dd, MMM yyyy', }) {
  try {
    DateTime dateTime = DateTime.parse(date);
    final outputDate = formatDateTimeDay(dateTime, format: format);
    return outputDate;
  } catch (e) {
    return null;
  }
}

String formatDateTimeDay(DateTime dateTime, {String format = 'dd, MMM yyyy'}) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.isNegative) {
    return DateFormat(format).format(dateTime);
  } else if (difference.inMinutes < 1) {
    return 'just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min';
  } else if (difference.inDays < 1) {
    final hours = difference.inHours;
    return '$hours ${hours == 1 ? 'hour' : 'hours'}';
  } else if (difference.inDays < 365) {
    return DateFormat('dd, MMM').format(dateTime);
  } else {
    return DateFormat(format).format(dateTime);
  }
}


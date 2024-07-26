// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

String formatNumber(String num) {
  int number = int.tryParse(num) ?? 0;
  if (number >= 1000000) {
    // Format the number to "1M" if it's a million or more
    return '${(number / 1000000).toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    // Format the number to "1K" if it's a thousand or more
    return '${(number / 1000).toStringAsFixed(1)}K';
  } else {
    // Return the number as is if it's less than 1000
    return number.toString();
  }
}

String discountString(String? type, String? amountSaved, String? originalPrice) {
  if (type == 'amount') {
    return '${amountSaved ?? '0'}\$';
  } else {
    final double amount = double.tryParse(amountSaved ?? '') ?? 0;
    final double original = double.tryParse(originalPrice ?? '') ?? 0;

    if (original == 0) {
      return '0%';
    }

    final double percentage = (amount * 100) / original;
    return '${percentage.toStringAsFixed(1)}%';
  }
}

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


// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

stringToString({ String date = '2024-01-01', String format = 'dd-MM-yyyy', }) {
  try {
    DateTime dateTime = DateTime.parse(date);
    var outputDate = DateFormat(format).format(dateTime);
    return outputDate;
  } catch (e) {
    return null;
  }
}

stringWithNow({ String date = '2024-01-01', String format = 'dd-MM-yyyy HH:mm', }) {
  try {
    DateTime dateTime = DateTime.parse(date);
    var outputDate = DateFormat(format).format(dateTime);
    DateTime dateNow = DateTime.now().subtract(const Duration(days: 1));
    if(dateNow.compareTo(dateTime) <= 0) return DateFormat('HH:mm a').format(dateTime);
    return outputDate;
  } catch (e) {
    return null;
  }
}
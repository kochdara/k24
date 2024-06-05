import 'package:intl/intl.dart';

class Converts {

  stringToString({ String date = '2024-01-01', String format = 'dd-MM-yyyy', }) {
    try {
      DateTime dateTime = DateTime.parse(date);
      var outputDate = DateFormat(format).format(dateTime);
      return outputDate;
    } catch (e) {
      return null;
    }
  }

}
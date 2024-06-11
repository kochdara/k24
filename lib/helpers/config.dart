import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:k24/serialization/category/main_category.dart';
import 'package:k24/serialization/grid_card/grid_card.dart';
import 'package:k24/serialization/try_convert.dart';

part 'config.g.dart';

const String baseUrl = "https://test-api.khmer24.mobi";
const String postUrl = "https://test-posts.khmer24.mobi";
const String notificationUrl = "https://test-notifications.khmer24.mobi";
const String chatUrl = "https://test-chats.khmer24.mobi";
const String commentUrl = "https://test-comments.khmer24.mobi";
const String likeUrl = "https://test-likes.khmer24.mobi";
const String insightUrl = "https://test-insights.khmer24.mobi";
const String trackingUrl = "https://test-tracking.khmer24.mobi";
const String paymentUrl = "https://test-payments.khmer24.mobi";
const String jobUrl = "https://test-jobs.khmer24.mobi";

const double radius = 6;
const double maxWidth = 1080;

class Config {
  final List<String> imageExtensions = ['jpg', 'jpeg', 'png'];

  static const int _primaryAppColorValue = 0xff03A9F4;
  static const int _primaryVOASubtleColorValue = 0xffFDF1E6;
  MaterialColor primaryAppColor =
  const MaterialColor(_primaryAppColorValue, <int, Color>{
    50: Color(0xFFE1F5FE),
    100: Color(0xFFB3E5FC),
    200: Color(0xFF81D4FA),
    300: Color(0xFF4FC3F7),
    400: Color(0xFF29B6F6),
    500: Color(_primaryAppColorValue),
    600: Color(0xFF039BE5),
    700: Color(0xFF0288D1),
    800: Color(0xFF0277BD),
    900: Color(0xFF01579B),
  });

  static const int _primaryColorValue = 0xff3874ff;
  static const int _primarySubtleColorValue = 0xffE5EDFF;
  MaterialColor primaryColor =
  const MaterialColor(_primaryColorValue, <int, Color>{
    50: Color(0xFFE7EEFF),
    100: Color(0xFFC3D5FF),
    200: Color(0xFF9CBAFF),
    300: Color(0xFF749EFF),
    400: Color(0xFF5689FF),
    500: Color(_primaryColorValue),
    600: Color(0xFF326CFF),
    700: Color(0xFF2B61FF),
    800: Color(0xFF2457FF),
    900: Color(0xFF1744FF),
  });

  static const int _secondaryColorValue = 0xff31374a;
  static const int _secondarySubtleColorValue = 0xffeff2f6;
  MaterialColor secondaryColor =
  const MaterialColor(_secondaryColorValue, <int, Color>{
    50: Color(0xFFE6E7E9),
    100: Color(0xFFC1C3C9),
    200: Color(0xFF989BA5),
    300: Color(0xFF6F7380),
    400: Color(0xFF505565),
    500: Color(_secondaryColorValue),
    600: Color(0xFF2C3143),
    700: Color(0xFF252A3A),
    800: Color(0xFF1F2332),
    900: Color(0xFF131622),
  });

  static const int _successColorValue = 0xff25b003;
  static const int _successSubtleColorValue = 0xffD9FBD0;
  MaterialColor successColor =
  const MaterialColor(_successColorValue, <int, Color>{
    50: Color(0xFFE5F6E1),
    100: Color(0xFFBEE7B3),
    200: Color(0xFF92D881),
    300: Color(0xFF66C84F),
    400: Color(0xFF46BC29),
    500: Color(_successColorValue),
    600: Color(0xFF21A903),
    700: Color(0xFF1BA002),
    800: Color(0xFF169702),
    900: Color(0xFF0D8701),
  });

  static const int _dangerColorValue = 0xffEC1F00;
  static const int _dangerSubtleColorValue = 0xffFFE0DB;
  MaterialColor dangerColor =
  const MaterialColor(_dangerColorValue, <int, Color>{
    50: Color(0xFFFDE4E0),
    100: Color(0xFFF9BCB3),
    200: Color(0xFFF68F80),
    300: Color(0xFFF2624D),
    400: Color(0xFFEF4126),
    500: Color(_dangerColorValue),
    600: Color(0xFFEA1B00),
    700: Color(0xFFE71700),
    800: Color(0xFFE41200),
    900: Color(0xFFDF0A00),
  });

  static const int _warningColorValue = 0xffE5780B;
  static const int _warningSubtleColorValue = 0xffFFEFCA;
  MaterialColor warningColor =
  const MaterialColor(_warningColorValue, <int, Color>{
    50: Color(0xFFFCEFE2),
    100: Color(0xFFF7D7B6),
    200: Color(0xFFF2BC85),
    300: Color(0xFFEDA154),
    400: Color(0xFFE98C30),
    500: Color(_warningColorValue),
    600: Color(0xFFE2700A),
    700: Color(0xFFDE6508),
    800: Color(0xFFDA5B06),
    900: Color(0xFFD34803),
  });

  static const int _infoColorValue = 0xff0097eb;
  static const int _infoSubtleColorValue = 0xffC7EBFF;
  MaterialColor infoColor = const MaterialColor(_infoColorValue, <int, Color>{
    50: Color(0xFFE0F3FD),
    100: Color(0xFFB3E0F9),
    200: Color(0xFF80CBF5),
    300: Color(0xFF4DB6F1),
    400: Color(0xFF26A7EE),
    500: Color(_infoColorValue),
    600: Color(0xFF008FE9),
    700: Color(0xFF0084E5),
    800: Color(0xFF007AE2),
    900: Color(0xFF0069DD),
  });

  Color textSecondaryColor = const Color(_secondaryColorValue);

  final Color backgroundColor = const Color(0xfff5f7fa);
  final Color borderColor = const Color(0xFFC1C3C9);

  // Label
  double labelSize = 16;
  FontWeight labelWeight = FontWeight.normal;
  Color labelColor = const Color(0xff212529);
  double labelPadding = 6;

  // Buttons
  FontWeight buttonFontWeight = FontWeight.normal;

  Map<String, double> buttonFontSizes = {
    "small": 14,
    "normal": 17,
    "large": 22,
  };

  Map<String, double> buttonRadius = {
    "small": 4,
    "normal": 6,
    "large": 8,
  };

  Map<String, EdgeInsets> buttonPadding = {
    "small": const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    "normal": const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    "large": const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
  };

  Map<String, Map<String, Color>> buttonVariants = {
    "solid": {
      "voa": const Color(_primaryAppColorValue),
      "primary": const Color(_primaryColorValue),
      "secondary": const Color(_secondaryColorValue),
      "success": const Color(_successColorValue),
      "danger": const Color(_dangerColorValue),
      "warning": const Color(_warningColorValue),
      "info": const Color(_infoColorValue),
      "link": Colors.transparent,
    },
    "subtle": {
      "voa": const Color(_primaryVOASubtleColorValue),
      "primary": const Color(_primarySubtleColorValue),
      "secondary": const Color(_secondarySubtleColorValue),
      "success": const Color(_successSubtleColorValue),
      "danger": const Color(_dangerSubtleColorValue),
      "warning": const Color(_warningSubtleColorValue),
      "info": const Color(_infoSubtleColorValue),
      "link": Colors.transparent,
    },
  };

  Map<String, Color> buttonTextColors = {
    "voa": Colors.white,
    "primary": Colors.white,
    "secondary": Colors.white,
    "success": Colors.white,
    "danger": Colors.white,
    "warning": Colors.white,
    "info": Colors.white,
    "link": const Color(_primaryColorValue),
  };
}

// ########### //
// more config //
// ########### //
double bottomSheet = 18;
double lineHeight = 1.4;
double spaceGrid = 12;
double spaceMenu = 14;
String lang = 'en';
String fields = 'thumbnail,photos,location,user,store,renew_date,link,category,is_saved,is_like,total_like,total_comment,highlight_specs,condition,object_highlight_specs';
String fieldsDetails = 'all_photos,photo,photos,thumbnails,thumbnail,renew_date,posted_date,link,highlight_specs,object_highlight_specs,specs,object_specs,description,category,views,total_like,is_like,total_comment,is_saved,location,user,store,email,phone,status,is_job_applied';
String filterVersion = '4';

String mainFunctions = 'save,chat,like,comment,apply_job,shipping,banner[image,code,google_ads,iframe,innity],highlight_ads[highlight_specs],highlight_ads[object_highlight_specs]';
String detailsFunctions = 'save,chat,like,comment,apply_job,shipping,loan_calculator';

double responsive(double width) {
  double resWidth;
  switch (width) {
    case >=992: { // computer
      resWidth = (width / 5) - 10;
    }
    break;

    case >=768: { // tablet
      resWidth = (width / 4) - 10;
    }
    break;

    case >=576: { // large phone
      resWidth = (width / 3) - 9;
    }
    break;

    case >=400: { // normal phone
      resWidth = (width / 2) - 7;
    }
    break;

    default: { // default
      resWidth = (width / 2) - 7;
    }
    break;
  }
  return resWidth;
}

Map responsiveSub(double width) {
  double resWidth;
  int length = 0;
  switch (width) {
    case >=992: { // computer
      resWidth = (width / 8) - 14;
      length = 8;
    }
    break;

    case >=768: { // tablet
      resWidth = (width / 7) - 14;
      length = 6;
    }
    break;

    case >=576: { // large phone
      resWidth = (width / 6) - 14;
      length = 5;
    }
    break;

    case >=400: { // normal phone
      resWidth = (width / 5) - 14;
      length = 4;
    }
    break;

    default: { // default
      resWidth = (width / 4) - 14;
      length = 4;
    }
    break;
  }
  return { 'width': resWidth, 'length': length };
}

Map responsiveImage(double width) {
  double resWidth;
  int length;
  switch (width) {
    case >=992: { // computer
      resWidth = (width / 6) - 7;
      length = 6;
    }
    break;

    case >=768: { // tablet
      resWidth = (width / 5) - 6;
      length = 5;
    }
    break;

    case >=576: { // large phone
      resWidth = (width / 4) - 5;
      length = 4;
    }
    break;

    case >=400: { // normal phone
      resWidth = (width / 3) - 3;
      length = 3;
    }
    break;

    default: { // default
      resWidth = (width / 3) - 3;
      length = 3;
    }
    break;
  }
  return { "width": resWidth, "length": length};
}

Future<Map<String, dynamic>> getUrls({ required String subs, Map<String, String>? headers, Urls url = Urls.postUrl }) async {
  var base = '';
  switch(url) {
    case Urls.baseUrl:
      base = baseUrl; break;
    case Urls.chatUrl:
      base = chatUrl; break;
    case Urls.notificationUrl:
      base = notificationUrl; break;
    case Urls.commentUrl:
      base = commentUrl; break;
    case Urls.likeUrl:
      base = likeUrl; break;
    case Urls.insightUrl:
      base = insightUrl; break;
    case Urls.trackingUrl:
      base = trackingUrl; break;
    case Urls.paymentUrl:
      base = paymentUrl; break;
    case Urls.jobUrl:
      base = jobUrl; break;
    default:
      base = postUrl;break;
  }

  try {
    var url = Uri.parse('$base/$subs');
    headers?.addAll({
      'Display-Type': 'app',
    });
    var response = await http.get(url, headers: headers);

    var decRes = jsonDecode(response.body);
    // print(decRes);

    if (response.statusCode == 200) {
      var result = decRes;
      var data = decRes['data'];
      return {'status': 0, 'message': 'success', 'result': result, 'data': data, 'code': response.statusCode};
    } else {
      return {'status': 1, 'message': decRes, 'result': null, 'data': null, 'code': response.statusCode};
    }
  } catch(e) {
    return {'status': 2, 'message': 'catch: $e', 'result': null, 'data': null, 'code': ''};
  }
}

final List<GridCard> listViewSkeleton = [
  GridCard.fromJson({"type": "post","data": {"id": "#","title": "Test post sell table.","price": "210.00","type": "normal", "thumbnail": "###", "location": {"en_name": "Siem Reap Siem Reap Siem Reap Siem"}, "condition": {"title": "Siem Reap Siem Reap Siem Reap Siem"}}, "setting": {}}),
  GridCard.fromJson({"type": "post","data": {"id": "#","title": "Test post sell table.","price": "210.00","type": "normal", "thumbnail": "###", "location": {"en_name": "Siem Reap Siem Reap Siem Reap Siem"}, "condition": {"title": "Siem Reap Siem Reap Siem Reap Siem"}}, "setting": {}}),
  GridCard.fromJson({"type": "post","data": {"id": "#","title": "Test post sell table.","price": "210.00","type": "normal", "thumbnail": "###", "location": {"en_name": "Siem Reap Siem Reap Siem Reap Siem"}, "condition": {"title": "Siem Reap Siem Reap Siem Reap Siem"}}, "setting": {}}),
  GridCard.fromJson({"type": "post","data": {"id": "#","title": "Test post sell table.","price": "210.00","type": "normal", "thumbnail": "###", "location": {"en_name": "Siem Reap Siem Reap Siem Reap Siem"}, "condition": {"title": "Siem Reap Siem Reap Siem Reap Siem"}}, "setting": {}}),
];

final List<MainCategory> mainCatSkeleton = [
  MainCategory.fromJson({ "id": "#","en_name": "Vehicles &\n Vehicles","km_name": "រថយន្ត និង យានយន្ត", "icon": {"url": "#"}}),
  MainCategory.fromJson({ "id": "#","en_name": "Vehicles &\n Vehicles","km_name": "រថយន្ត និង យានយន្ត", "icon": {"url": "#"}}),
  MainCategory.fromJson({ "id": "#","en_name": "Vehicles &\n Vehicles","km_name": "រថយន្ត និង យានយន្ត", "icon": {"url": "#"}}),
  MainCategory.fromJson({ "id": "#","en_name": "Vehicles &\n Vehicles","km_name": "រថយន្ត និង យានយន្ត", "icon": {"url": "#"}}),
  MainCategory.fromJson({ "id": "#","en_name": "Vehicles &\n Vehicles","km_name": "រថយន្ត និង យានយន្ត", "icon": {"url": "#"}}),
  MainCategory.fromJson({ "id": "#","en_name": "Vehicles &\n Vehicles","km_name": "រថយន្ត និង យានយន្ត", "icon": {"url": "#"}}),
  MainCategory.fromJson({ "id": "#","en_name": "Vehicles &\n Vehicles","km_name": "រថយន្ត និង យានយន្ត", "icon": {"url": "#"}}),
  MainCategory.fromJson({ "id": "#","en_name": "Vehicles &\n Vehicles","km_name": "រថយន្ត និង យានយន្ត", "icon": {"url": "#"}}),
];

@JsonSerializable(anyMap: true, explicitToJson: true, converters: [ ToString(), ToLists(), ToInt() ])
class ConfigState {
  int? status;
  String? message;
  dynamic result;
  dynamic data;
  int? code;

  ConfigState({this.status, this.message, required this.result, this.data, this.code});

  factory ConfigState.fromJson(Map<String, dynamic> json) => _$ConfigStateFromJson(json);
  Map toJson() => _$ConfigStateToJson(this);
}



enum Urls {
  baseUrl,
  postUrl,
  notificationUrl,
  chatUrl,
  commentUrl,
  likeUrl,
  insightUrl,
  trackingUrl,
  paymentUrl,
  jobUrl,
}

enum ViewPage {
  grid,
  list,
  view,
}




enum StatusCode {
  success,
  warning,
}

extension StatusCodeExtension on StatusCode {
  int get val {
    switch (this) {
      case StatusCode.success:
        return 200;
      case StatusCode.warning:
        return 404;
      default:
        return 200;
    }
  }

}
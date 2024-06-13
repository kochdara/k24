
import 'package:dio/dio.dart';
import 'package:k24/helpers/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filters_provider.g.dart';

@riverpod
class GetFilterPro extends _$GetFilterPro {

  List filters = [];

  final Dio dio = Dio();

  @override
  FutureOr<List> build(String slug) async {
    filters = [];

    String url = 'filters/$slug?lang=$lang&group=true&return_key=true&filter_version=$filterVersion&has_post=true';
    final res = await dio.get('$baseUrl/$url');
    final resp = res.data;

    if(res.statusCode == 200 && resp != null) {
      final data = resp['data'];

      if (data != null) {
        if(data['sort'] != null) filters.add(data['sort']);
        if(data['date'] != null) filters.add(data['date']);

        if(data['locations'] != null){
          if(data['locations']['locations'] != null) filters.add(data['locations']['locations']);
        }

        if(data['prices'] != null){
          if(data['prices']['ad_price'] != null) filters.add(data['prices']['ad_price']);
          if(data['prices']['discount'] != null) filters.add(data['prices']['discount']);
        }

        if(data['deliveries'] != null) {
          if(data['deliveries']['shipping'] != null) filters.add(data['deliveries']['shipping']);
        }

        if(data['fields'] != null) {
          if(data['fields']['make-model-and-year'] != null) filters.add(data['fields']['make-model-and-year']);

          if(data['fields']['ad_auto_condition'] != null) filters.add(data['fields']['ad_auto_condition']);

          if(data['fields']['ad_condition'] != null) filters.add(data['fields']['ad_condition']);

          if(data['fields']['ad_transmission'] != null) filters.add(data['fields']['ad_transmission']);

          if(data['fields']['ad_fuel'] != null) filters.add(data['fields']['ad_fuel']);

          if(data['fields']['ad_type'] != null) filters.add(data['fields']['ad_type']);
        }

      }

    }

    return filters;
  }
}


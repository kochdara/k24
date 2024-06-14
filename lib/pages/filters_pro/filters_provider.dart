
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
          (data['locations'] as Map).forEach((key, value) {
            filters.add(data['locations'][key] ?? {});
          });
        }

        if(data['prices'] != null){
          (data['prices'] as Map).forEach((key, value) {
            filters.add(data['prices'][key] ?? {});
          });
        }

        if(data['deliveries'] != null) {
          (data['deliveries'] as Map).forEach((key, value) {
            filters.add(data['deliveries'][key] ?? {});
          });
        }

        if(data['fields'] != null) {
          (data['fields'] as Map).forEach((key, value) {
            filters.add(data['fields'][key] ?? {});
          });
        }

      }

    }

    return filters;
  }
}


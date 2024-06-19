
import 'package:dio/dio.dart';
import 'package:k24/helpers/config.dart';
import 'package:k24/helpers/storage.dart';
import 'package:k24/serialization/users/user_serial.dart';

class MyApiService {
  final Dio dio = Dio();

  Future<UserSerial> submitData(Map<String, dynamic>  data) async {
    final formData = FormData.fromMap(data);

    final subs = 'auth/login?lang=$lang';
    final res = await dio.post('$baseUrl/$subs', data: formData);
    final resp = UserSerial.fromJson(res.data ?? {});

    await saveSecure('user', resp.data?.user?.toJson() ?? {});
    await saveSecure('tokens', resp.data?.tokens?.toJson() ?? {});

    return resp;
  }
}


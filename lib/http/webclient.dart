// ignore_for_file: avoid_print

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // ignore: avoid_print
    print('url: ${data.url.toString()}');
    print('headers ${data.headers.toString()}');
    print('body ${data.body.toString()}');
    return data;
  }
}

void findAll() async {
  final Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client.get(
    Uri.parse('http://192.168.1.40:8080/transactions'),
  );
}

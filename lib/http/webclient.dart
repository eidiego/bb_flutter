// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../models/contact.dart';
import '../models/transaction.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    print('url: ${data.url.toString()}');
    print('headers ${data.headers.toString()}');
    print('body ${data.body.toString()}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // ignore: avoid_print
    print('status code: ${data.statusCode.toString()}');
    print('headers ${data.headers.toString()}');
    print('body ${data.body.toString()}');
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  final Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client
      .get(
        Uri.parse('http://192.168.1.40:8080/transactions'),
      )
      .timeout(const Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> ContactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        ContactJson['name'],
        ContactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

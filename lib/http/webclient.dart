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

final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);

const String baseUrl = 'http://192.168.1.40:8080/transactions';

Future<List<Transaction>> findAll() async {
  final Response response = await client
      .get(
        Uri.parse(baseUrl),
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

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber,
    }
  };
  final transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(
    Uri.parse(baseUrl),
    headers: {
      'Content-type': 'application/json',
      'password': '1000',
    },
    body: transactionJson,
  );

  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> ContactJson = json['contact'];
  return Transaction(
    json['value'],
    Contact(
      0,
      ContactJson['name'],
      ContactJson['accountNumber'],
    ),
  );
}

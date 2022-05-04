// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../models/contact.dart';
import '../models/transaction.dart';
import 'interceptors/logging_interceptor.dart';

final Client client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);

const String baseUrl = 'http://192.168.1.40:8080/transactions';

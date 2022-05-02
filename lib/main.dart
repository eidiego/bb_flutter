import 'package:flutter/material.dart';

import 'http/webclient.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const ByteBankApp());
  findAll();
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.blueAccent[700]),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromARGB(255, 2, 78, 31),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const Dashboard(),
    );
  }
}

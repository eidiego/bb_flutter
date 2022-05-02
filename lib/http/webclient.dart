import 'package:http/http.dart';

void findAll() async {
  final Response response = await get(
    Uri.parse('http://localhost:8080/transactions'),
  );
  print(response.body);
}

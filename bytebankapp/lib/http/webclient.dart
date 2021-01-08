import 'dart:convert';

import 'package:bytebankapp/models/contact.dart';
import 'package:bytebankapp/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = 'http://192.168.0.95:8080/transactions';

Future<List<Transaction>> findAll() async {
  final Response response =
  await client.get(baseUrl).timeout(Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();

  for (Map<String, dynamic> transactionJson in decodedJson) {
    transactions.add(Transaction(
      transactionJson['value'],
      Contact(
        0,
        transactionJson['contact']['name'],
        transactionJson['contact']['accountNumber'],
      ),
    ));
  }
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };

  final Response response = await client.post(baseUrl,
      headers: {'Content-type': 'application/json', 'password': '1000'},
      body: jsonEncode(transactionMap));

  Map<String, dynamic> json = jsonDecode(response.body);
  return Transaction(
    json['value'],
    Contact(
      0,
      json['contact']['name'],
      json['contact']['accountNumber'],
    ),
  );
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}

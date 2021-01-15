import 'dart:convert';
import 'package:bytebankapp/models/transaction.dart';
import 'package:http/http.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl);
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map<Transaction>((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {

    await Future.delayed(Duration(seconds: 3));

    final Response response = await client.post(baseUrl,
        headers: {'Content-type': 'application/json', 'password': password},
        body: jsonEncode(transaction.toJson()));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(getMessage(response));
  }

  String getMessage(Response response) {
    if (_statusCodeResponses.containsKey(response.statusCode)) {
      return _statusCodeResponses[response.statusCode];
    }
    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting transaction',
    401: 'Authentication failed'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}

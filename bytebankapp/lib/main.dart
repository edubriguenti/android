import 'package:bytebankapp/http/webclient.dart';
import 'package:bytebankapp/screens/contacts_list.dart';
import 'package:bytebankapp/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'models/contact.dart';
import 'models/transaction.dart';

void main() {
  runApp(ByteBankApp());
  //save(Transaction(1000, Contact(0, 'Edu', 200))).then((value) => print('Transaction saved: $value'));
  //findAll().then((transactions) => print('transactions $transactions'));
  // save(Contact(0, 'Eduardo', 1000)).then((id) {
  //   findAll().then((contacts) => debugPrint(contacts.toString()));
  // });
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/contacts_list': (context) => ContactsList()
      },
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )),
      home: Dashboard(),
    );
  }
}


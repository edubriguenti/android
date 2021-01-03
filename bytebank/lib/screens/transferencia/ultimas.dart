import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lista.dart';

final _titulo = 'Últimas transferências';

class UltimasTransferencias extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          _titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            final _ultimasTransferencias = transferencias.transferencias.reversed.toList();
            final _quantidade = transferencias.transferencias.length;
            int _tamanho = 2;
            if (_quantidade < 2) {
              _tamanho = _quantidade;
            }
            if (_quantidade == 0) {
              return SemTransferenciaCadastrada();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _tamanho,
              shrinkWrap: true,
              itemBuilder: (context, indice) {
                return ItemTransferencia(_ultimasTransferencias[indice]);
              },
            );
          },
        ),
        RaisedButton(
          color: Colors.green,
          child: Text('Transferências'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ListaTransferencias();
              }),
            );
          },
        ),
      ],
    );
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Você não cadastrou nenhuma transferência',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
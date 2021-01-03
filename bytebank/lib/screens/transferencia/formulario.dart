import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando transferencia';
const _rotuloCampoNumeroDaConta = 'Número da conta';
const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';
const _dicaCampoConta = '0000';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                  controlador: _controladorCampoNumeroConta,
                  rotulo: _rotuloCampoNumeroDaConta,
                  dica: _dicaCampoConta),
              Editor(
                  controlador: _controladorCampoValor,
                  rotulo: _rotuloCampoValor,
                  dica: _dicaCampoValor,
                  icone: Icons.monetization_on),
              RaisedButton(
                onPressed: () => _criaTransferencia(context),
                child: Text(_textoBotaoConfirmar),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (_isTransferenciaValida(numeroConta, valor, context)) {
      final novaTransferencia = Transferencia(valor, numeroConta);
      _atualizaEstado(context, novaTransferencia, valor);
      Navigator.pop(context, novaTransferencia);
    }
  }

  _isTransferenciaValida(numeroConta, valor, context) {
    return numeroConta != null && valor != null && _isSaldoSuficiente(context, valor);
  }

  _isSaldoSuficiente(context, valor) {
    return valor <=
        Provider.of<Saldo>(
            context,
            listen: false
        ).valor;
  }

  _atualizaEstado(context, novaTransferencia, valor) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);

  }
}

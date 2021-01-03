class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(
    this.valor,
    this.numeroConta,
  );

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }

  String toStringValor() {
    return 'Conta $numeroConta';
  }

  String toStringConta() {
    return 'R\$ $valor';
  }
}

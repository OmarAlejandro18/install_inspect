import 'package:flutter/material.dart';

class ClienteProvider with ChangeNotifier {
  String clienteSelect = '';

  get getCliente {
    return clienteSelect;
  }

  set setCliente(String cliente) {
    clienteSelect = cliente;
    notifyListeners();
  }
}
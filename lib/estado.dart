import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/model/cores.dart';

class Estado with ChangeNotifier {
  final List<Cores> listaCombinacao = [Cores.blue, Cores.green, Cores.red];

  int contadorUsuario = 0;

  Cores? corPiscando;

  bool clicavel = false;

  bool continuar = false;

  EstadoJogo estadoJogo = EstadoJogo.perdeu;

  bool iniciarJogo() {
    estadoJogo = .jogando;
    mostrarCombinacao();
    notifyListeners();
    return clicavel;
  }

  void sortearProximo() {
    final random = Random();
    listaCombinacao.add(Cores.values[random.nextInt(Cores.values.length)]);
    notifyListeners();
  }

  Future<void> mostrarCombinacao() async {
    for (int i = 0; i < listaCombinacao.length; i++) {
      corPiscando = listaCombinacao[i];
      notifyListeners();
      await Future.delayed(Duration(seconds: 1));
    }

    corPiscando = null;
    clicavel = true;
    notifyListeners();
  }

  void recebeClique(Cores cor) {
    if (cor != listaCombinacao[contadorUsuario]) {
      estadoJogo = .perdeu;
      return;
    }

    if (contadorUsuario == listaCombinacao.length - 1) {
      mostrarCombinacao();
      contadorUsuario = 0;
      //
    } else {
      contadorUsuario++;
    }
  }
}

enum EstadoJogo { jogando, perdeu, mostrando }

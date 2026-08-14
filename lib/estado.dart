import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/model/cores.dart';

class Estado with ChangeNotifier {
  final List<Cores> listaCombinacao = [Cores.blue, Cores.green, Cores.red];

  int contadorUsuario = 0;

  int pontuacao = 0;

  Cores? corPiscando;

  EstadoJogo estadoJogo = EstadoJogo.perdeu;

  bool get clicavel => estadoJogo == EstadoJogo.jogando;

  void iniciarJogo() {
    listaCombinacao.clear();

    contadorUsuario = 0;
    pontuacao = 0;

    sortearProximo();

    mostrarCombinacao();
  }

  void sortearProximo() {
    final random = Random();

    listaCombinacao.add(Cores.values[random.nextInt(Cores.values.length)]);
  }

  Future<void> mostrarCombinacao() async {
    estadoJogo = EstadoJogo.mostrando;
    corPiscando = null;

    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    for (final cor in listaCombinacao) {
      print(cor);
      print('----');
      corPiscando = cor;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      corPiscando = null;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 300));
    }

    estadoJogo = EstadoJogo.jogando;
    notifyListeners();
  }

  void recebeClique(Cores cor) {
    if (!clicavel) return;

    if (cor != listaCombinacao[contadorUsuario]) {
      estadoJogo = EstadoJogo.perdeu;
      notifyListeners();
      print('vc perdeu');
      return;
    }

    if (contadorUsuario == listaCombinacao.length - 1) {
      contadorUsuario = 0;
      sortearProximo();
      mostrarCombinacao();
      return;
    }

    contadorUsuario++;

    notifyListeners();
  }
}

enum EstadoJogo { jogando, perdeu, mostrando }

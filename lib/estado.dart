import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/model/cores.dart';
import 'package:untitled/record_repository.dart';

class Estado with ChangeNotifier {
  Estado() {
    carregarRecord();
  }

  final RecordRepository recordRepository = RecordRepository();

  int record = 0;

  final List<Cores> listaCombinacao = [];

  int contadorUsuario = 0;

  int pontuacao = 0;

  Cores? corPiscando;

  EstadoJogo estadoJogo = EstadoJogo.iniciar;

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

  Future<void> recebeClique(Cores cor) async {
    if (!clicavel) return;

    await piscarBotaoClicado(cor);

    // errou
    if (cor != listaCombinacao[contadorUsuario]) {
      estadoJogo = EstadoJogo.perdeu;

      if (pontuacao > record) {
        record = pontuacao;

        await recordRepository.salvarRecord(record);
      }

      notifyListeners();

      return;
    }

    // acertou
    pontuacao++;

    if (contadorUsuario == listaCombinacao.length - 1) {
      contadorUsuario = 0;

      sortearProximo();

      await mostrarCombinacao();

      return;
    }

    contadorUsuario++;

    notifyListeners();
  }

  Future<void> carregarRecord() async {
    record = await recordRepository.buscarRecord();

    notifyListeners();
  }

  Future<void> piscarBotaoClicado(Cores cor) async {
    // Faz o botão clicado piscar
    corPiscando = cor;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));
    corPiscando = null;
    notifyListeners();
  }
}

enum EstadoJogo { iniciar, jogando, perdeu, mostrando }

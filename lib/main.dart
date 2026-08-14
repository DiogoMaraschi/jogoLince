import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled/estado.dart';
import 'package:untitled/model/cores.dart';
import 'package:untitled/ui/botao.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => Estado(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genius',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Genius')),

      body: Consumer<Estado>(
        builder: (context, state, child) {
          if (state.estadoJogo == EstadoJogo.perdeu) {
            return Center(
              child: ElevatedButton(
                onPressed: state.iniciarJogo,
                child: const Text('Começar jogo'),
              ),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Botao(
                    cor: Cores.red,
                    clicavel: state.clicavel,
                    devePiscar: state.corPiscando == Cores.red,
                    funcaoBotao: () => state.recebeClique(Cores.red),
                  ),
                  Botao(
                    cor: Cores.green,
                    clicavel: state.clicavel,
                    devePiscar: state.corPiscando == Cores.green,
                    funcaoBotao: () => state.recebeClique(Cores.green),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Botao(
                    cor: Cores.blue,
                    clicavel: state.clicavel,
                    devePiscar: state.corPiscando == Cores.blue,
                    funcaoBotao: () => state.recebeClique(Cores.blue),
                  ),
                  Botao(
                    cor: Cores.yellow,
                    clicavel: state.clicavel,
                    devePiscar: state.corPiscando == Cores.yellow,
                    funcaoBotao: () => state.recebeClique(Cores.yellow),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

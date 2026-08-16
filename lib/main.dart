import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:untitled/estado.dart';
import 'package:untitled/model/cores.dart';
import 'package:untitled/ui/botao.dart';
import 'package:untitled/ui/game_over_page.dart';
import 'package:untitled/ui/start_page.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => Estado(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Genius',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genius', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),

      body: Consumer<Estado>(
        builder: (context, state, child) {
          // Tela inicial / perdeu
          if (state.estadoJogo == EstadoJogo.iniciar) {
            return StartPage(onComecar: state.iniciarJogo);
          } else if (state.estadoJogo == EstadoJogo.perdeu) {
            return GameOverPage(
              onGameover: state.iniciarJogo,
              pontuacao: state.pontuacao,
              recorde: state.record,
            );
          }

          // Jogo
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 360,
                    height: 360,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Vermelho
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Botao(
                            cor: Cores.red,
                            clicavel: state.clicavel,
                            devePiscar: state.corPiscando == Cores.red,
                            funcaoBotao: () => state.recebeClique(Cores.red),
                          ),
                        ),

                        // Verde
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Botao(
                            cor: Cores.green,
                            clicavel: state.clicavel,
                            devePiscar: state.corPiscando == Cores.green,
                            funcaoBotao: () => state.recebeClique(Cores.green),
                          ),
                        ),

                        // Azul
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: Botao(
                            cor: Cores.blue,
                            clicavel: state.clicavel,
                            devePiscar: state.corPiscando == Cores.blue,
                            funcaoBotao: () => state.recebeClique(Cores.blue),
                          ),
                        ),

                        // Amarelo
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Botao(
                            cor: Cores.yellow,
                            clicavel: state.clicavel,
                            devePiscar: state.corPiscando == Cores.yellow,
                            funcaoBotao: () => state.recebeClique(Cores.yellow),
                          ),
                        ),

                        // Centro
                        Container(
                          width: 130,
                          height: 130,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              '${state.pontuacao}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

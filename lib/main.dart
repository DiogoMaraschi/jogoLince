import 'package:flutter/material.dart';
import 'package:untitled/estado.dart';
import 'package:untitled/model/cores.dart';
import 'package:untitled/ui/botao.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => Estado(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool clicavel = false;

  void _startGame() {
    final state = context.read<Estado>();
    clicavel = state.iniciarJogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<Estado>(
        builder: (_, state, _) {
          if (state.estadoJogo != EstadoJogo.jogando) {
            return Center(
              child: ElevatedButton(
                onPressed: _startGame,
                child: Text("Comecar jogo"),
              ),
            );
          }

          return Row(
            children: [
              Column(
                mainAxisAlignment: .center,
                children: [
                  Botao(
                    cor: .red,
                    clicavel: clicavel,
                    devePiscar: state.corPiscando == .red,
                    funcaoBotao: () => state.recebeClique(.red),
                  ),
                  Botao(
                    cor: .green,
                    clicavel: clicavel,
                    devePiscar: state.corPiscando == .green,
                    funcaoBotao: () => state.recebeClique(.green),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: .center,
                children: [
                  Botao(
                    cor: .blue,
                    clicavel: clicavel,
                    devePiscar: state.corPiscando == .blue,
                    funcaoBotao: () => state.recebeClique(.blue),
                  ),
                  Botao(
                    cor: .yellow,
                    clicavel: clicavel,
                    devePiscar: state.corPiscando == .yellow,
                    funcaoBotao: () => state.recebeClique(.yellow),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Estado>().mostrarCombinacao();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

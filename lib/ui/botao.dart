import 'package:flutter/material.dart';
import 'package:untitled/model/cores.dart';

class Botao extends StatelessWidget {
  const Botao({
    super.key,
    required this.cor,
    required this.clicavel,
    required this.devePiscar,
    required this.funcaoBotao,
  });

  final Cores cor;
  final bool clicavel;
  final bool devePiscar;
  final VoidCallback funcaoBotao;

  Color get corAtual {
    return devePiscar ? cor.color : cor.color.withValues(alpha: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: TextButton(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(corAtual)),
        onPressed: clicavel ? funcaoBotao : null,
        child: const SizedBox(),
      ),
    );
  }
}

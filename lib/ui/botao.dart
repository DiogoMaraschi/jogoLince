import 'package:untitled/model/cores.dart';
import 'package:flutter/material.dart';

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
    return devePiscar ? cor.color : cor.color.withValues(alpha: 0.6);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 170,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(corAtual),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
        onPressed: clicavel ? funcaoBotao : null,
        child: const SizedBox(),
      ),
    );
  }
}

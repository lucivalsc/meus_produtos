import 'package:flutter/material.dart';

class BotaoImagem extends StatelessWidget {
  final Color? cor;
  final IconData icone;
  final Function()? funcao;
  const BotaoImagem({
    Key? key,
    this.cor,
    this.icone = Icons.ac_unit,
    this.funcao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: funcao,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black12),
        ),
        child: Icon(
          icone,
          color:
              cor != null ? Colors.red : const Color.fromRGBO(229, 130, 40, 1),
        ),
      ),
    );
  }
}

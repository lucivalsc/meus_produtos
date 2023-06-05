import 'package:flutter/material.dart';
import 'package:meus_produtos/app/common/widgets/botao.dart';
import 'package:meus_produtos/app/common/widgets/detalhes_itens.dart';
import 'package:meus_produtos/app/layers/data/model/meus_produtos_model.dart';

class DescricaoDados extends StatefulWidget {
  final ProdutosModel dados;
  final String ean;

  const DescricaoDados({
    Key? key,
    required this.dados,
    required this.ean,
  }) : super(key: key);

  @override
  State<DescricaoDados> createState() => _DescricaoDadosState();
}

class _DescricaoDadosState extends State<DescricaoDados> {
  final String valorItem = '0,00';
  int qtdeItem = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        ListTile(
          title: Text('${widget.dados.categoria}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.dados.nome}',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: _showAdicionarValor,
                child: Text(
                  'R\$ $valorItem',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(
                      229,
                      130,
                      40,
                      1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          trailing: const BotaoImagem(
            cor: Colors.red,
            icone: Icons.favorite,
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BotaoImagem(
              icone: Icons.remove,
              funcao: _diminuirItem,
            ),
            Text('$qtdeItem', style: const TextStyle(fontSize: 30)),
            BotaoImagem(
              icone: Icons.add,
              funcao: _aumentarItem,
            ),
          ],
        ),
        const Divider(),
        const Text(
          'Descrição',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        DadosDescricao(ean: widget.ean, dados: widget.dados),
      ],
    );
  }

  _showAdicionarValor() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Insira o valor do produto'),
          content: const TextField(
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  _aumentarItem() {
    setState(() {
      qtdeItem++;
    });
  }

  _diminuirItem() {
    setState(() {
      if (qtdeItem > 1) {
        qtdeItem--;
      }
    });
  }
}

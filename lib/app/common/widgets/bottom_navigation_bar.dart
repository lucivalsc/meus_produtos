import 'package:flutter/material.dart';
import 'package:meus_produtos/app/layers/data/model/meus_produtos_model.dart';

class BottomNaivationBarPadrao extends StatefulWidget {
  final ProdutosModel dados;
  final Function()? funcao;
  final int qtdeItem;
  const BottomNaivationBarPadrao({
    Key? key,
    required this.dados,
    this.funcao,
    required this.qtdeItem,
  }) : super(key: key);

  @override
  State<BottomNaivationBarPadrao> createState() =>
      _BottomNaivationBarPadraoState();
}

class _BottomNaivationBarPadraoState extends State<BottomNaivationBarPadrao> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text(
                'R\$ 0,00',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(widget.qtdeItem > 1
                  ? '${widget.qtdeItem} itens'
                  : 'Nenhum item'),
            ),
          ),
          //Botão inferior da cesta de produtos
          Container(
            height: 50,
            width: (MediaQuery.of(context).size.width / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(229, 130, 40, 1),
            ),
            child: InkWell(
              onTap: widget.funcao,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Adicione no carrinho',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(237, 167, 104, 1),
                    child: Icon(
                      Icons.storefront_outlined,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

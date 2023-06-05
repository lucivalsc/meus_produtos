import 'package:flutter/material.dart';

import 'package:meus_produtos/app/layers/data/model/meus_produtos_model.dart';

class ListaProdutosScreen extends StatefulWidget {
  final List<ProdutosModel> carrinho;
  const ListaProdutosScreen({
    Key? key,
    required this.carrinho,
  }) : super(key: key);

  @override
  State<ListaProdutosScreen> createState() => _ListaProdutosScreenState();
}

class _ListaProdutosScreenState extends State<ListaProdutosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.carrinho.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(widget.carrinho[index].nome ?? ''),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

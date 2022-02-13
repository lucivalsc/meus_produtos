import 'package:flutter/material.dart';
import 'package:meus_produtos/model/meus_produtos_model.dart';

class DadosDescricao extends StatelessWidget {
  final ProdutosModel dados;
  final String EAN;
  const DadosDescricao({
    Key? key,
    required this.dados,
    required this.EAN,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Texto(titulo: 'Código de Barras:', texto: EAN)),
              Texto(titulo: 'NCM:', texto: '${dados.ncm}'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child:
                      Texto(titulo: 'Código:', texto: '${dados.cestCodigo}')),
              Texto(titulo: 'Embalagem:', texto: '${dados.embalagem}'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Texto(
                      titulo: 'Qtde Emb.:',
                      texto: '${dados.quantidadeEmbalagem}')),
              Texto(titulo: 'Marca:', texto: '${dados.marca}'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texto(titulo: 'Peso:', texto: '${dados.peso}'),
              Texto(titulo: 'Cód. Cat.:', texto: '${dados.idCategoria}'),
              Texto(titulo: 'Tributação:', texto: '${dados.tributacao}'),
            ],
          ),
        ],
      ),
    );
  }
}

class Texto extends StatelessWidget {
  final String titulo;
  final String texto;
  const Texto({
    Key? key,
    required this.titulo,
    required this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(titulo),
          Text(
            texto,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

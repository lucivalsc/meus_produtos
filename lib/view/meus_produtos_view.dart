import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meus_produtos/controller/meus_produtos_controller.dart';
import 'package:meus_produtos/data/descricao_dados.dart';
import 'package:meus_produtos/model/meus_produtos_model.dart';
import 'package:meus_produtos/data/bottom_navigation_bar.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final ServicoHttp servico = ServicoHttp();
  ProdutosModel dados = ProdutosModel();
  final TextEditingController _codigo = TextEditingController();
  int qtdeItem = 0;

  bool inLoading = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          escanearCodigoBarras();
        },
        child: const Icon(Icons.qr_code),
      ),
      bottomNavigationBar: BottomNaivationBarPadrao(
          dados: dados, funcao: _inserirValor, qtdeItem: qtdeItem),
      body: Column(
        children: [
          //Campo para apresentar a imagem
          Container(
            height: 200,
            child: const Icon(
              Icons.storefront_outlined,
              size: 150,
              color: Colors.black26,
            ),
          ),
          const SizedBox(height: 15),
          //Dados inferiores do produto
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: inLoading == false
                  ? dados.nome != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              DescricaoDados(dados: dados, ean: _codigo.text))
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Clique no código de barra para pesquisar um produto.',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> escanearCodigoBarras() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancelar',
      true,
      ScanMode.BARCODE,
    );
    if (barcodeScanRes == '-1') {
    } else {
      inLoading = true;
      setState(() {});
      _codigo.text = barcodeScanRes;
      qtdeItem = 0;
      dados = await servico.produtosApi(barcodeScanRes);
      inLoading = false;
      setState(() {});
    }
  }

  void _inserirValor() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Deseja realmente inserir este item no carrinho?'),
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
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}

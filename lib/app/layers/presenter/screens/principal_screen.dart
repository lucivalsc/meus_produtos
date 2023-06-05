import 'dart:async';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meus_produtos/app/common/widgets/descricao_dados.dart';
import 'package:meus_produtos/app/layers/presenter/providers/data_providers.dart';
import 'package:meus_produtos/app/layers/data/model/meus_produtos_model.dart';
import 'package:meus_produtos/app/common/widgets/bottom_navigation_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:meus_produtos/app/layers/presenter/screens/lista_produtos_screen.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({Key? key}) : super(key: key);

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  final ServicoHttp servico = ServicoHttp();
  ProdutosModel dados = ProdutosModel();
  final TextEditingController _codigo = TextEditingController();
  int qtdeItem = 0;
  List<ProdutosModel> carrinho = [];
  bool inLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            //Dados inferiores do produto
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
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
            Positioned(
              top: 0,
              bottom: MediaQuery.of(context).size.height / 2,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ListaProdutosScreen(
                                  carrinho: carrinho,
                                ),
                              ),
                            ),
                            child: badges.Badge(
                              badgeContent: Text(
                                '${carrinho.length}',
                              ),
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Campo para apresentar a imagem
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: const Icon(
                        Icons.storefront_outlined,
                        size: 150,
                        color: Colors.black26,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          escanearCodigoBarras();
        },
        child: const Icon(Icons.qr_code),
      ),
      bottomNavigationBar: BottomNaivationBarPadrao(
        dados: dados,
        funcao: _inserirValor,
        qtdeItem: qtdeItem,
      ),
    );
  }

  buildList() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Lista de Produtos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 350,
                child: ListView.builder(
                  itemCount: carrinho.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(carrinho[index].nome!),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
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
          content: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CentavosInputFormatter(casasDecimais: 2),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (mounted) {
                  Navigator.pop(context);
                }
                if (dados.nome != null && dados.nome!.isNotEmpty) {
                  carrinho.add(dados);
                  setState(() {
                    // dados.nome = null;
                  });
                }
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meus_produtos/app/layers/data/model/meus_produtos_model.dart';
import 'package:path_provider/path_provider.dart';

class ServicoHttp {
  Future<ProdutosModel> produtosApi(String codigo) async {
    String baserUrl = 'http://www.eanpictures.com.br:9000/api/desc/$codigo';
    var url = Uri.parse(baserUrl);
    var response = await http.get(url);
    if (codigo.isNotEmpty) {
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        ProdutosModel lista = ProdutosModel.fromJson(body);
        return lista;
      } else {
        return ProdutosModel();
      }
    } else {
      return ProdutosModel();
    }
  }

  Future<String> downloadFile(String url, String nomeArquivo) async {
    Armazenar armazenar = Armazenar();
    var path = await armazenar.nomeArquivo(nomeArquivo);
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = path;
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else {
        filePath = 'Error code: ${response.statusCode}';
      }
    } catch (ex) {
      filePath = 'Can not fetch url';
    }

    return filePath;
  }
}

class Armazenar {
  String _nomeArquivo = '';
  Future<String> nomeArquivo(String arquivo) async {
    _nomeArquivo = arquivo;
    var nomeArquivo = await _localFile;
    return nomeArquivo;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get _localFile async {
    final path = await _localPath;
    return '$path/$_nomeArquivo.png';
  }
}

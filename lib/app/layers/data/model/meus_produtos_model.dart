class ProdutosModel {
  String? status;
  String? statusDesc;
  String? nome;
  String? ncm;
  String? cestCodigo;
  String? embalagem;
  String? quantidadeEmbalagem;
  String? marca;
  String? categoria;
  String? peso;
  String? idCategoria;
  String? tributacao;
  String? valor;

  ProdutosModel();

  ProdutosModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    statusDesc = json['Status_Desc'];
    nome = json['Nome'];
    ncm = json['Ncm'];
    cestCodigo = json['Cest_Codigo'];
    embalagem = json['Embalagem'];
    quantidadeEmbalagem = json['QuantidadeEmbalagem'];
    marca = json['Marca'];
    categoria = json['Categoria'];
    peso = json['Peso'];
    idCategoria = json['id_categoria'];
    tributacao = json['tributacao'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Status_Desc'] = statusDesc;
    data['Nome'] = nome;
    data['Ncm'] = ncm;
    data['Cest_Codigo'] = cestCodigo;
    data['Embalagem'] = embalagem;
    data['QuantidadeEmbalagem'] = quantidadeEmbalagem;
    data['Marca'] = marca;
    data['Categoria'] = categoria;
    data['Peso'] = peso;
    data['id_categoria'] = idCategoria;
    data['tributacao'] = tributacao;
    data['valor'] = valor;
    return data;
  }
}

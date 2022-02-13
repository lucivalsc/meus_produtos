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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Status_Desc'] = this.statusDesc;
    data['Nome'] = this.nome;
    data['Ncm'] = this.ncm;
    data['Cest_Codigo'] = this.cestCodigo;
    data['Embalagem'] = this.embalagem;
    data['QuantidadeEmbalagem'] = this.quantidadeEmbalagem;
    data['Marca'] = this.marca;
    data['Categoria'] = this.categoria;
    data['Peso'] = this.peso;
    data['id_categoria'] = this.idCategoria;
    data['tributacao'] = this.tributacao;
    return data;
  }
}

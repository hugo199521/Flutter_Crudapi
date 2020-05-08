import 'dart:convert';

class Profile {
  int id;
  String modelo;
  String agencia;
  String ano;
  String precio;
  String carro_foto;

  Profile({this.id = 0, this.modelo, this.agencia, this.ano,
    this.precio,this.carro_foto});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["id"], modelo: map["modelo"], agencia: map["agencia"], ano: map["ano"]
        , precio: map["precio"], carro_foto: map["carro_foto"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "modelo": modelo, "agencia": agencia, "ano":ano,"precio":precio,
      "carro_foto":carro_foto};
  }

  @override
  String toString() {
    return 'Profile{id: $id, modelo: $modelo, agencia: $agencia, ano: $ano,precio:$precio,carro_foto:$carro_foto}';
  }

}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

import 'package:flutter/material.dart';
import 'package:crudwindowsfinal/Crud/modelo/api/api.dart';
import 'package:crudwindowsfinal/Crud/modelo/api/profile.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class VisorSearch extends StatefulWidget {

  Profile profile;

  VisorSearch({this.profile});

  @override
  _AddItems createState() => _AddItems();
}

class _AddItems extends State<VisorSearch> {
  TextEditingController _controllerModelo = TextEditingController();
  TextEditingController _controllerAgencia = TextEditingController();
  TextEditingController _controllerAno = TextEditingController();
  TextEditingController _controllerPrecio = TextEditingController();
  TextEditingController _controllerCarro_foto = TextEditingController();

  @override
  void initState() {
    if (widget.profile != null) {
      _controllerModelo.text = widget.profile.modelo;
      _controllerAgencia.text = widget.profile.agencia;
      _controllerAno.text = widget.profile.ano;
      _controllerPrecio.text = widget.profile.precio;
      _controllerCarro_foto.text = widget.profile.carro_foto;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
         "Visor",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.network(widget.profile.carro_foto),
                _buildTextFieldModelo(),
                _buildTextFieldAgencia(),
                _buildTextFieldAno(),
                _buildTextFieldPrecio(),
                _buildTextFieldCarro_foto(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldModelo() {
    return TextField(
      enabled: false,
      controller: _controllerModelo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Modelo",
      ),
    );
  }

  Widget _buildTextFieldAgencia() {
    return TextField(
      enabled: false,
      controller: _controllerAgencia,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Agencia",
      ),
    );
  }

  Widget _buildTextFieldAno() {
    return TextField(
      enabled: false,
      controller: _controllerAno,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Año",
    ),
    );
  }
  Widget _buildTextFieldPrecio() {
    return TextField(
      enabled: false,
      controller: _controllerPrecio,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Precio",
      ),
    );
  }
  Widget _buildTextFieldCarro_foto() {
    return TextField(
      enabled: false,
      controller: _controllerCarro_foto,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        labelText: "URL del Carro",
      ),
    );
  }
}

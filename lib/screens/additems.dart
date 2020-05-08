import 'package:flutter/material.dart';
import 'package:crudwindowsfinal/Crud/modelo/api/api.dart';
import 'package:crudwindowsfinal/Crud/modelo/api/profile.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddItems extends StatefulWidget {

  Profile profile;

  AddItems({this.profile});

  @override
  _AddItems createState() => _AddItems();
}

class _AddItems extends State<AddItems> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldModeloValid;
  bool _isFieldAgenciaValid;
  bool _isFieldAnoValid;
  bool _isFieldPrecioValid;
  bool _isFieldCarro_fotoValid;
  TextEditingController _controllerModelo = TextEditingController();
  TextEditingController _controllerAgencia = TextEditingController();
  TextEditingController _controllerAno = TextEditingController();
  TextEditingController _controllerPrecio = TextEditingController();
  TextEditingController _controllerCarro_foto = TextEditingController();

  @override
  void initState() {
    if (widget.profile != null) {
      _isFieldModeloValid = true;
      _controllerModelo.text = widget.profile.modelo;
      _isFieldAgenciaValid = true;
      _controllerAgencia.text = widget.profile.agencia;
      _isFieldAnoValid = true;
      _controllerAno.text = widget.profile.ano;
      _isFieldPrecioValid = true;
      _controllerPrecio.text = widget.profile.precio;
      _isFieldCarro_fotoValid = true;
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
          widget.profile == null ? "Agregar" : "Editar",
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
                _buildTextFieldModelo(),
                _buildTextFieldAgencia(),
                _buildTextFieldAno(),
                _buildTextFieldPrecio(),
                _buildTextFieldCarro_foto(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.profile == null
                          ? "Aceptar".toUpperCase()
                          : "Actualizar".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldModeloValid == null ||
                          _isFieldAgenciaValid == null ||
                          _isFieldAnoValid == null ||
                          _isFieldPrecioValid == null ||
                          _isFieldCarro_fotoValid == null ||
                          !_isFieldModeloValid ||
                          !_isFieldAgenciaValid ||
                          !_isFieldAnoValid ||
                          !_isFieldPrecioValid ||
                          !_isFieldCarro_fotoValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Llenar todos los campos"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String modelo = _controllerModelo.text.toString();
                      String agencia = _controllerAgencia.text.toString();
                      String ano = _controllerAno.text.toString();
                      String precio = _controllerPrecio.text.toString();
                      String carro_foto = _controllerCarro_foto.text.toString();
                      Profile profile =
                      Profile(modelo: modelo, agencia: agencia,
                          ano: ano,precio:precio,carro_foto:carro_foto);
                      if  (widget.profile == null) {
                        _apiService.createProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("No se pudo agregar"),
                            ));
                          }
                        });
                      } else {
                        profile.id = widget.profile.id;
                        _apiService.updateProfile(profile).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("No se pudo actualizar"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.green[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ) : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldModelo() {
    return TextField(
      controller: _controllerModelo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Modelo",
        errorText: _isFieldModeloValid == null || _isFieldModeloValid
            ? null
            : "Se requiere Modelo",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldModeloValid) {
          setState(() => _isFieldModeloValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAgencia() {
    return TextField(
      controller: _controllerAgencia,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Agencia",
        errorText: _isFieldAgenciaValid == null || _isFieldAgenciaValid
            ? null
            : "Se requiere Agencia",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAgenciaValid) {
          setState(() => _isFieldAgenciaValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAno() {
    return TextField(
      controller: _controllerAno,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Año",
        errorText: _isFieldAnoValid == null || _isFieldAnoValid
            ? null
            : "Se requiere Año",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldAnoValid) {
          setState(() => _isFieldAnoValid = isFieldValid);
        }
      },
    );
  }
  Widget _buildTextFieldPrecio() {
    return TextField(
      controller: _controllerPrecio,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Precio",
        errorText: _isFieldPrecioValid == null || _isFieldPrecioValid
            ? null
            : "Se requiere Precio",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPrecioValid) {
          setState(() => _isFieldPrecioValid = isFieldValid);
        }
      },
    );
  }
  Widget _buildTextFieldCarro_foto() {
    return TextField(
      controller: _controllerCarro_foto,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "URL del Carro",
        errorText: _isFieldCarro_fotoValid == null || _isFieldCarro_fotoValid
            ? null
            : "Se requiere URL",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldCarro_fotoValid) {
          setState(() => _isFieldCarro_fotoValid = isFieldValid);
        }
      },
    );
  }
}

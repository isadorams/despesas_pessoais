import 'package:controle_gastos/helpers/usuario_helpers.dart';
import 'package:flutter/material.dart';
import 'dart:io'; 
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


class CadastroPage extends StatefulWidget {
  final Usuario usuario;
  CadastroPage({this.usuario});

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nomeController = TextEditingController();
  final _nomeFocus = FocusNode();
  bool _userEdited = false;
  Usuario _editedUsuario;

  List _toDoList = [];
  Map<String, dynamic> _lastRemoved = {};
  int _lastRemovedPos = 0;

 @override
  void initState() {
    super.initState();

 if (widget.usuario == null) {
      _editedUsuario = Usuario();
    } else {
      _editedUsuario = Usuario.fromMap(widget.usuario.toMap());

      _loginController.text = _editedUsuario.login;
      _senhaController.text = _editedUsuario.senha;
      _emailController.text = _editedUsuario.email;
      _nomeController.text = _editedUsuario.nome;
      
    }
  }

   void _addCadastro() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["usuario"] = _loginController.text;

      _loginController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            title: Text(_editedUsuario.nome ?? "Novo Usuario"),
            centerTitle: true,
          ),
           //floatingActionButton: FloatingActionButton(
            //onPressed: () {
              //if (_editedUsuario.nome != null &&
                 // _editedUsuario.nome.isNotEmpty) {
               // Navigator.pop(context, _editedUsuario);
             // } else {
               // FocusScope.of(context).requestFocus(_nomeFocus);
             // }
           // },
            //child: Icon(Icons.save),
            //backgroundColor: Colors.amberAccent,
          //),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        ),
                  ),
                ),
                TextField(
                  controller: _nomeController,
                  focusNode: _nomeFocus,
                  decoration: InputDecoration(labelText: "Nome:"),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedUsuario.nome = text;
                    });
                  },
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "E-mail:"),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedUsuario.email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(labelText: "Login:"),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedUsuario.login = text;
                    });
                  },
                ),
                TextField(
                  controller: _senhaController,
                  decoration: InputDecoration(labelText: "Senha:"),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedUsuario.senha = text;
                    });
                  },
                ),   
                RaisedButton(
                  color: Colors.amberAccent,
                  child: Text("Cadastrar conta!"),
                  textColor: Colors.black,
                  onPressed:_addCadastro,
                 )
              ],
            ),
          ),
        ));
  } 

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();

    return file.writeAsString(data);
  }
  
  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar as Alterações?"),
              content: Text("Caso saia as alterações serão perdidas."),
              actions: [
                FlatButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                FlatButton(
                    child: Text("Sim"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
  }
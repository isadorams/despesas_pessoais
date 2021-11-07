import 'package:controle_gastos/helpers/usuario_helpers.dart';
import 'package:flutter/material.dart';
//import 'dart:io'; 
import 'dart:async';
//import 'dart:convert';
//import 'package:path_provider/path_provider.dart';


class CadastroPage extends StatefulWidget {
  final Usuario usuario;
  CadastroPage({this.usuario});
  

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeFocus = FocusNode();
  bool _userEdited = false;
  Usuario _editedUsuario;

  /*List _toDoList = [];
  Map<String, dynamic> _lastRemoved = {};
  int _lastRemovedPos = 0;*/

 @override
  void initState() {
    super.initState();

 if (widget.usuario == null) {
      _editedUsuario = Usuario();
    } else {
      _editedUsuario = Usuario.fromMap(widget.usuario.toMap());

      _nomeController.text = _editedUsuario.nome;
      _emailController.text = _editedUsuario.email;
      _loginController.text = _editedUsuario.login;
      _senhaController.text = _editedUsuario.senha;
      
      
    }
  }

  double displayHeight() => MediaQuery.of(context).size.height;
  double displayWidth() => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
       child: Column(
         children:<Widget> [
           Container(
            margin: EdgeInsets.only(
              top: displayHeight() / 4,
              right: displayWidth() / 20,
              left: displayWidth() / 20,
              ),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.amberAccent,
                  blurRadius: 3,
                )
              ]
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  prefixIcon: Icon(Icons.person,color: Colors.amber,),
                  border:InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                    ),
                   ),
                   ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              right: displayWidth() / 20,
              left: displayWidth() / 20,
              ),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.amberAccent,
                  blurRadius: 3,
                )
              ]
              ),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(Icons.alternate_email,color: Colors.amber,),
                  border:InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                    ),
                   ),
                   ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              right: displayWidth() / 20,
              left: displayWidth() / 20,
              ),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.amberAccent,
                  blurRadius: 3,
                )
              ]
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  hintText: 'Usuario',
                  prefixIcon: Icon(Icons.person,color: Colors.amber,),
                  border:InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                    ),
                   ),
                   ),
          ),


          Container(
            margin: EdgeInsets.only(
              top: 10,
              right: displayWidth() / 20,
              left: displayWidth() / 20,
              ),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.amberAccent,
                  blurRadius: 3,
                )
              ]
              ),
              child: TextField(
                 keyboardType: TextInputType.text,
                obscureText: true,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: Icon(Icons.vpn_key,color: Colors.amber,),
                  border:InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                    ),

                   ),
                   ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: displayWidth() /20,
            vertical: 25,
            ),
            child: RaisedButton(
             onPressed:(){
                if (_editedUsuario.nome != null &&
                  _editedUsuario.nome.isNotEmpty) {
                Navigator.pop(context, _editedUsuario);
              } else {
                FocusScope.of(context).requestFocus(_nomeFocus);
              }
             },
             color: Colors.amber,
             child: Text("Cadastrar conta!",
             style: TextStyle(color: Colors.black),
             ),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(50),
               ),
             ) ,
          ),
         ],
       ),
    );
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
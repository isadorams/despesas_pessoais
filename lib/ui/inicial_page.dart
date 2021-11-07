import 'dart:io';
import 'dart:async';
import 'package:controle_gastos/helpers/usuario_helpers.dart';
import 'package:controle_gastos/ui/cad_page.dart';
import 'package:flutter/material.dart';

class Inicial_page extends StatefulWidget {
  const Inicial_page({ Key key }) : super(key: key);

  @override
  _Inicial_pageState createState() => _Inicial_pageState();
}

class _Inicial_pageState extends State<Inicial_page> {
  UsuarioHelper helper = UsuarioHelper();

  List<Usuario> usuarios = List();

   @override
    void initState() {
    super.initState();

  /*
    Usuario u = Usuario();
    u.login = "isa_skibinski";
    u.senha = "1012";
    u.nome = "Isadora Skibinski";
    u.email = "isadora@gmail.com";
    

    helper.salvarUsuario(u);
  
  helper.getAllUsuario().then((list){
    print(list);
  });
  */
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Controle de Gastos"),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("");
          //_showUsuarioPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.amberAccent,
    ),
    body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            //return _contatoCard(context, index);
          }),
    );
  }
  
}
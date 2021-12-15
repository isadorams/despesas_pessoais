import 'package:controle_gastos/ui/Empresarial/Emp_inicial.dart';
import 'package:controle_gastos/ui/Pessoal/Pes_inicial.dart';
import 'package:flutter/material.dart';
import 'package:controle_gastos/Helper/Usuario.dart';

class OpcaoPage extends StatefulWidget {
  final Usuario usuario;
  OpcaoPage({this.usuario});

  //final PageController controller;
  //OpcaoPage(this.controller);

  @override
  _OpcaoPageState createState() => new _OpcaoPageState(usuario);
}

class _OpcaoPageState extends State<OpcaoPage> {
  final Usuario usuarioController;
  _OpcaoPageState(this.usuarioController);

  UsuarioHelper helper = UsuarioHelper();

  List<Usuario> usuarios = List();

  @override
  void initState() {
    super.initState();
  }

  double displayHeight() => MediaQuery.of(context).size.height;
  double displayWidth() => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/imagens/moedinha.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: displayHeight() / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            )),
            child: Icon(
              Icons.note_add_rounded,
              color: Colors.black,
              size: 180,
            ),
          ),
          SizedBox(height: displayHeight() / 500),
          Container(
            height: 50,
            margin: EdgeInsets.only(
              top: 10,
              right: displayWidth() / 20,
              left: displayWidth() / 20,
            ),
            // margin: EdgeInsets.symmetric(horizontal: displayWidth() / 10),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InicialPage()),
                );
                //usuarioController.nextPage(
                //duration: Duration(seconds: 1),
                //curve: Curves.ease
                //);
              },
              child: Text("Despesas Pessoais",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 18,
                  )),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.black,
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(
              top: 10,
              right: displayWidth() / 20,
              left: displayWidth() / 20,
            ),
            //  margin: EdgeInsets.symmetric(horizontal: displayWidth() / 10),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InicialPageE()),
                );
                //usuarioController.previousPage(
                //duration: Duration(seconds: 1),
                //curve: Curves.ease
                //);
              },
              child: Text("Despesas Empresariais",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 18,
                  )),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

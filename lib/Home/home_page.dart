import 'package:flutter/material.dart';
import 'package:controle_gastos/Helper/usuario_helpers.dart';

class HomePage extends StatefulWidget {
  final PageController controller;
  HomePage(this.controller);
  //const TelaInicial({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(controller);
}

class _HomePageState extends State<HomePage> {
  final PageController pageController;
  _HomePageState(this.pageController);

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
      //color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: displayHeight() / 2,
            decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            )),
            child: Icon(
              Icons.monetization_on_rounded,
              color: Colors.black,
              size: 180,
            ),
          ),
          SizedBox(height: displayHeight() / 800),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              right: displayWidth() / 20,
              left: displayWidth() / 20,
            ),
            height: 50,
//            margin: EdgeInsets.symmetric(horizontal: displayWidth() / 10),
            child: RaisedButton(
              onPressed: () {
                pageController.nextPage(
                    duration: Duration(seconds: 1), curve: Curves.ease);
              },
              child: Text("Cadastro",
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
                pageController.previousPage(
                    duration: Duration(seconds: 1), curve: Curves.ease);
              },
              child: Text("Login",
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

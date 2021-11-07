
import 'package:flutter/material.dart';
import 'package:controle_gastos/helpers/usuario_helpers.dart';

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

  

  double displayHeight() => MediaQuery.of(context).size.height;
  double displayWidth() => MediaQuery.of(context).size.width;


  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Container(
              height: displayHeight() / 2,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(150),
                 )
                 ),
                 child: Icon(
                   Icons.monetization_on_rounded,
                   color: Colors.amberAccent, 
                   size: 70,
                   ),
          ),

          SizedBox(height: displayHeight() /500),

          Container(
            margin: EdgeInsets.symmetric(
              horizontal: displayWidth() / 10
            ),
            child: RaisedButton(
              onPressed: (){
                pageController.nextPage(
                  duration: Duration(seconds: 1), 
                  curve: Curves.ease
                  );
              },
              child: Text("Cadastro", style: TextStyle(color: Colors.black,)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50) 
                ),
                color: Colors.amber,
              ),
          ),

          Container(
            margin: EdgeInsets.symmetric(
              horizontal: displayWidth() / 10
            ),
            child: FlatButton(
              onPressed: (){
                pageController.previousPage(
                  duration: Duration(seconds: 1), 
                  curve: Curves.ease
                  );
              },
              child: Text("Login", style: TextStyle(color: Colors.black,)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50) 
                ),
                color: Colors.amber,
              ),
          )

        ],
        ),
    );
  }
}
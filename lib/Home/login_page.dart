import 'package:flutter/material.dart';

import 'opcao_page.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
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
                  // color: Colors.white,
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              )),
              child: Icon(
                Icons.person_pin_rounded,
                color: Colors.black,
                size: 180,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: displayHeight() / 1000,
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
                  ]),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  hintText: 'Usuario',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.amber,
                  ),
                  border: InputBorder.none,
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
                  ]),
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.amber,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                horizontal: displayWidth() / 20,
                vertical: 25,
              ),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OpcaoPage()),
                  );
                },
                color: Colors.black,
                child: Text(
                  "Entrar",
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
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
            ),
          ],
        ));
  }
}

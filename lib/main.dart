import 'package:controle_gastos/Home/login_page.dart';
import 'package:controle_gastos/Home/cadastro_page.dart';
import 'package:controle_gastos/Home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final pageController = PageController(initialPage: 1);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de gastos',
      theme: ThemeData(
      primarySwatch: Colors.amber,
      ),
      home:PageView(
        controller: pageController,
        children: <Widget>[
          Scaffold(
            body: HomePage(pageController),
          ),
          Scaffold(
            body: TelaLogin(),
          ),
           Scaffold(
            body: CadastroPage(),
          ),
        ],
      ),
    );
  }
}

import 'package:controle_gastos/Home/Login_page.dart';
import 'package:controle_gastos/Home/Cadastro_page.dart';
import 'package:controle_gastos/Home/Home_page.dart';
//import 'package:controle_gastos/Home/opcao_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

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
      home: PageView(
        controller: pageController,
        children: <Widget>[
          Scaffold(
            body: TelaLogin(),
          ),
          Scaffold(
            body: HomePage(pageController),
          ),
          Scaffold(
            body: CadastroPage(),
          ),

          //Scaffold(
          // body: OpcaoPage(),
          //),
        ],
      ),
    );
  }
}

import 'package:controle_gastos/Widgets/Pessoal/Pes_dimensionaMenu.dart';
import 'package:controle_gastos/ui/Pessoal/Pes_despesas.dart';
import 'package:controle_gastos/ui/Pessoal/Pes_home.dart';
import 'package:controle_gastos/ui/Pessoal/Pes_receitas.dart';
import 'package:controle_gastos/ui/style/drawer.dart';
import 'package:controle_gastos/ui/style/pessoal_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InicialPage extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(
      text: "Despesas",
      iconData: Icons.remove_circle_outline,
      color: Colors.pinkAccent,
    ),
    BarItem(text: "Home", iconData: Icons.home, color: Colors.red),
    BarItem(
      text: "Receitas",
      iconData: Icons.add_circle_outline,
      color: Colors.teal,
    ),
    /*BarItem(
      text: "Search",
      iconData: Icons.search,
      color: Colors.yellow.shade900,
    ),
    */
  ];

  @override
  _InicialPageState createState() => _InicialPageState();
}

class _InicialPageState extends State<InicialPage> {
  int selectedBarIndex = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //systemNavigationBarColor: Colors.lightBlue[700], // navigation bar color
        //statusBarColor: Colors.lightBlue[700],
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light // status bar color
        ));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    List<Widget> telas = [DespesasPessoais(), HomePessoal(), ReceitasResumoP()];

    //_allMov();
    //print("\nMes atual: " + DateTime.now().month.toString());
    return Scaffold(
      appBar: getPessoalAppBar(),
      drawer: getDrawer(),
      body: telas[selectedBarIndex],
      bottomNavigationBar: DimensionaMenuPessoal(
        barItems: widget.barItems,
        animationDuration: const Duration(milliseconds: 150),
        barStyle: BarStyle(fontSize: width * 0.045, iconSize: width * 0.07),
        onBarTap: (index) {
          setState(() {
            selectedBarIndex = index;
          });
        },
      ),
    );
  }
}

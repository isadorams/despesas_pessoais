import 'package:controle_gastos/Helper/Mov_empresarial.dart';
import 'package:controle_gastos/Widgets/Empresarial/Emp_listas.dart';
import 'package:flutter/material.dart';

class ReceitasResumoE extends StatefulWidget {
  @override
  _ReceitasResumoEState createState() => _ReceitasResumoEState();
}

class _ReceitasResumoEState extends State<ReceitasResumoE> {
  MovimentacoesEmpresarial movimentacoesEmpresarial =
      MovimentacoesEmpresarial();
  List<MovimentacoesE> listMovimentacoesE = List();

  _allMovPorTipo() {
    movimentacoesEmpresarial.getAllMovimentacoesPorTipo("r").then((list) {
      setState(() {
        listMovimentacoesE = list;
      });
      print("All Mov: $listMovimentacoesE");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allMovPorTipo();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.8),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: width * 0.05, top: width * 0.2),
              child: Text(
                "Receitas",
                style: TextStyle(
                    color: Colors.white, //Colors.grey[400],
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.08),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.03, top: width * 0.08),
              child: SizedBox(
                width: width,
                height: height * 0.74,
                child: ListView.builder(
                  itemCount: listMovimentacoesE.length,
                  itemBuilder: (context, index) {
                    List movReverse = listMovimentacoesE.reversed.toList();
                    MovimentacoesE mov = movReverse[index];

                    if (movReverse[index] == movReverse.last) {
                      return ListasEmpresarial(
                        mov: mov,
                        colorItem: Colors.green[900],
                        isLast: true,
                      );
                    } else {
                      return ListasEmpresarial(
                        mov: mov,
                        colorItem: Colors.green[900],
                        isLast: false,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:controle_gastos/Helper/Mov_pessoal.dart';
import 'package:controle_gastos/Widgets/Pessoal/Pes_listas.dart';
import 'package:flutter/material.dart';

class ReceitasResumoP extends StatefulWidget {
  @override
  _ReceitasResumoPState createState() => _ReceitasResumoPState();
}

class _ReceitasResumoPState extends State<ReceitasResumoP> {
  MovimentacoesPessoal movimentacoesPessoal = MovimentacoesPessoal();
  List<MovimentacoesP> listMovimentacoesP = List();

  _allMovPorTipo() {
    movimentacoesPessoal.getAllMovimentacoesPorTipo("r").then((list) {
      setState(() {
        listMovimentacoesP = list;
      });
      print("All Mov: $listMovimentacoesP");
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
                  itemCount: listMovimentacoesP.length,
                  itemBuilder: (context, index) {
                    List movReverse = listMovimentacoesP.reversed.toList();
                    MovimentacoesP mov = movReverse[index];

                    if (movReverse[index] == movReverse.last) {
                      return ListasPessoal(
                        mov: mov,
                        colorItem: Colors.green[900],
                        isLast: true,
                      );
                    } else {
                      return ListasPessoal(
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

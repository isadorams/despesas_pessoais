import 'dart:ui';
import 'package:controle_gastos/Helper/Mov_empresarial.dart';
import 'package:controle_gastos/Widgets/Empresarial/Emp_AdicionaValores.dart';
import 'package:controle_gastos/Widgets/Empresarial/Emp_CardMovimentacoesItem.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class HomeEmpresarial extends StatefulWidget {
  @override
  _HomeEmpresarialState createState() => _HomeEmpresarialState();
}

class _HomeEmpresarialState extends State<HomeEmpresarial> {
  String saldoAtual = "";
  var total;
  var width;
  var height;
  bool recDesp = false;
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  MovimentacoesEmpresarial movEmpresarial = MovimentacoesEmpresarial();
  TextEditingController _valorController = TextEditingController();
  MovimentacoesEmpresarial movimentacoesP = MovimentacoesEmpresarial();
  List<MovimentacoesE> listMovimentacoesE = List();
  List<MovimentacoesE> ultimaTarefaRemovida = List();

  var dataAtual = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  var formatterCalendar = new DateFormat('MM-yyyy');
  String dataFormatada;

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  _addValor() {
    String valor = _valorController.text;
    setState(() {
      saldoAtual = valor;
    });
  }

  _saldoTamanho(String conteudo) {
    if (conteudo.length > 8) {
      return width * 0.08;
    } else {
      return width * 0.1;
    }
  }

  _salvar() {
    dataFormatada = formatter.format(dataAtual);
    MovimentacoesE mov = MovimentacoesE();
    mov.valor = 20.50;
    mov.tipo = "r";
    mov.data = "10-03-2020"; //dataFormatada;
    mov.descricao = "CashBack";
    MovimentacoesEmpresarial movimentacoesP = MovimentacoesEmpresarial();
    movimentacoesP.salvarMovimentacao(mov);
    mov.toString();
  }

  _allMov() {
    movimentacoesP.getAllMovimentacoes().then((list) {
      setState(() {
        listMovimentacoesE = list;
      });
      print("All Mov: $listMovimentacoesE");
    });
  }

  _allMovMes(String data) {
    movimentacoesP.getAllMovimentacoesPorMes(data).then((list) {
      if (list.isNotEmpty) {
        setState(() {
          listMovimentacoesE = list;
          //total =listmovimentacoes.map((item) => item.valor).reduce((a, b) => a + b);
        });
        total = listMovimentacoesE
            .map((item) => item.valor)
            .reduce((a, b) => a + b);
        saldoAtual = format(total).toString();
      } else {
        setState(() {
          listMovimentacoesE.clear();
          total = 0;
          saldoAtual = total.toString();
        });
      }

      //print("TOTAL: $total");
      //print("All MovMES: $listmovimentacoes");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //calendarController = CalendarController();
    if (DateTime.now().month != false) {
      //saldoAtual = "1259";
    }
    //_salvar();
    dataFormatada = formatterCalendar.format(dataAtual);
    print(dataFormatada);
    _allMovMes(dataFormatada);

    //_allMov();
  }

  _dialogAddRecDesp() {
    showDialog(
        context: context,
        builder: (context) {
          return AdicionaValoresEmpresarial();
        });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    _allMovMes(dataFormatada);
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scafoldKey,
      body: SingleChildScrollView(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        //physics: ClampingScrollPhysics(),
        //height: height,
        //width: width,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: height * 0.190, //300,
                  color: Colors.black,
                ),
                /*
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                      width: double.infinity,
                      height: height * 0.28, //250,
                      decoration: BoxDecoration(
                          color: Colors.red[700] //Colors.indigo[400],
                          )),
                ),*/
                /*Positioned(
                  top: width * 0.18, //70
                  left: width * 0.18, //30,

                  child: Text(
                    "Contas Pessoais",
                    style: TextStyle(
                        color: Colors.white, fontSize: width * 0.074 //30
                        ),
                  ),
                ),*/
                Positioned(
                  //Largura do paineil(saldo e add)
                  bottom: 0,
                  left: width * 0.0,
                  right: width * 0.0,
                  child: Container(
                    height: height * 0.18, //150,
                    width: width * 0.0, // 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(00),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 5,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                            top: width * 0.04,
                            bottom: width * 0.02,
                          ),
                          child: Text(
                            "Total",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: width * 0.05),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: Container(
                                width: width * 0.6,
                                child: Text(
                                  saldoAtual,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white, //Colors.indigo[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: _saldoTamanho(saldoAtual),
                                    //width * 0.1 //_saldoTamanho(saldoAtual)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: width * 0.04),
                              child: GestureDetector(
                                onTap: () {
                                  _dialogAddRecDesp();
                                },
                                child: Container(
                                  width: width * 0.12,
                                  height: width * 0.12, //65,
                                  decoration: BoxDecoration(
                                      color: Colors.grey, //Colors.indigo[400],
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 7,
                                          offset: Offset(2, 2),
                                        )
                                      ]),
                                  child: Icon(
                                    Icons.add,
                                    size: width * 0.09,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.008,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding:
                    EdgeInsets.only(left: width * 0.04, right: width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Movimentações",
                      style: TextStyle(
                          color: Colors.grey[600], fontSize: width * 0.04),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.02),
                      child: Icon(
                        Icons.sort,
                        size: width * 0.07,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.04, right: width * 0.04, top: 0),
              child: SizedBox(
                width: width,
                height: height * 0.47,
                child: ListView.builder(
                  itemCount: listMovimentacoesE.length,
                  itemBuilder: (context, index) {
                    MovimentacoesE mov = listMovimentacoesE[index];
                    MovimentacoesE ultMov = listMovimentacoesE[index];
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        //_dialogConfimacao(context, width, mov,index);

                        setState(() {
                          listMovimentacoesE.removeAt(index);
                        });
                        movEmpresarial.deletarMovimentacao(mov);
                        final snackBar = SnackBar(
                          content: Container(
                            padding: EdgeInsets.only(bottom: width * 0.025),
                            alignment: Alignment.bottomLeft,
                            height: height * 0.05,
                            child: Text(
                              "Desfazer Ação",
                              style: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: width * 0.05),
                            ),
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.amber[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          action: SnackBarAction(
                            label: "Desfazer",
                            textColor: Colors.black,
                            onPressed: () {
                              setState(() {
                                listMovimentacoesE.insert(index, ultMov);
                              });

                              movEmpresarial.salvarMovimentacao(ultMov);
                            },
                          ),
                        );
                        _scafoldKey.currentState.showSnackBar(snackBar);
                      },
                      key: ValueKey(mov.id),
                      background: Container(
                        padding: EdgeInsets.only(right: 10, top: width * 0.04),
                        alignment: Alignment.topRight,
                        color: Colors.amber[300],
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: width * 0.07,
                        ),
                      ),
                      child: CardMovimentacoesItemEmpresarial(
                        mov: mov,
                        lastItem:
                            listMovimentacoesE[index] == listMovimentacoesE.last
                                ? true
                                : false,
                      ),
                    );
                  },
                ),
              ),
            ), /*
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(""),
            )*/
          ],
        ),
      ),
    );
  }
}

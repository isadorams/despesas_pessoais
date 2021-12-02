import 'package:controle_gastos/Helper/Movimentacoes_helper.dart';
import 'package:flutter/material.dart';

class Listas extends StatelessWidget {
  final Movimentacoes mov;
  final bool isLast;
  final Color colorItem;

  const Listas({Key key, this.mov, this.isLast, this.colorItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //PONTO DE MARCAÇÃO DE LINHA LADO ESQUEDO RECEITAS E DESPESAS
                  Container(
                    width: width * 0.03,
                    height: height * 0.015,
                    decoration: BoxDecoration(
                        color: colorItem, //Colors.red[900],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  //TRAÇO DE MARCAÇÃP DE LINHA LADO ESQUERDO RECEITA E DESPESAS
                  Padding(
                    padding: EdgeInsets.only(
                        top: width * 0.010, bottom: width * 0.02),
                    child: Container(
                      width: width * 0.004,
                      height: isLast != true ? height * 0.05 : height * 0.03,
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                      ),
                    ),
                  )
                ],
              ),
              //COLUNA DA DESCRIÇÃO DE RECEITAS E DESPESAS
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Text(
                      mov.descricao,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          //COLUNA DOS VALORES DE RECEITAS E DESPESAS
          Padding(
            padding: EdgeInsets.only(right: width * 0.05),
            child: Text(
              mov.tipo == "r" ? "+ ${mov.valor}" : " ${mov.valor}",
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

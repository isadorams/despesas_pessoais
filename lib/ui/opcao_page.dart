import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class OpcaoPage extends StatefulWidget {
  @override
  OpcaoPageState createState() => new OpcaoPageState();
}

class OpcaoPageState extends State<OpcaoPage> {
  List<OpcaoModel> opcaoModel = OpcaoModel.getUsers();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
        title: new Text(
          'Seleção de Contas',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: new ListView.builder(
          itemCount: opcaoModel.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    new CheckboxListTile(
                        activeColor: Colors.amber,
                        dense: true,
                        
                        title: new Text(
                          opcaoModel[index].title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        value: opcaoModel[index].isCheck,
                        secondary: Container(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            opcaoModel[index].img,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onChanged: (bool val) {
                          itemChange(val, index);
                        })
                  ],
                ),
              ),
            );
          }),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      opcaoModel[index].isCheck = val;
    });
  }
}
class OpcaoModel {
  int userId;
  String img;
  String title;
  bool isCheck;

  OpcaoModel({this.userId, this.img, this.title, this.isCheck});

  static List<OpcaoModel> getUsers() {
    return <OpcaoModel>[
      OpcaoModel(
          userId: 1,
          img: 'assets/imagens/note.png ',
          title: "Academia",
          isCheck: true),
      OpcaoModel(
          userId: 2,
          img: 'assets/imagens/note.png ',
          title: "Água",
          isCheck: false),
      OpcaoModel(
          userId: 3,
          img: 'assets/imagens/note.png ',
          title: "Aluguel",
          isCheck: false),
      OpcaoModel(
          userId: 4,
          img: 'assets/imagens/note.png ',
          title: "Cartão",
          isCheck: false),
      OpcaoModel(
          userId: 5,
          img: 'assets/imagens/note.png ',
          title: "Energia",
          isCheck: false),
      OpcaoModel(
          userId: 6,
          img: 'assets/imagens/note.png ',
          title: "Gasolina",
          isCheck: false),
      OpcaoModel(
          userId: 7,
          img: 'assets/imagens/note.png ',
          title: "Internet",
          isCheck: false),
      OpcaoModel(
          userId: 8,
          img: 'assets/imagens/note.png ',
          title: "Farmácia",
          isCheck: false),
      OpcaoModel(
          userId: 9,
          img: 'assets/imagens/note.png ',
          title: "Mercado",
          isCheck: false),
    ];
  }
}
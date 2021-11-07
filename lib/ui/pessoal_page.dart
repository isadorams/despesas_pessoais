import 'package:controle_gastos/ui/style/pessoal_appbar.dart';
import 'package:controle_gastos/ui/style/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class Pessoalpage extends StatefulWidget {
  const Pessoalpage({Key key}) : super(key: key);

  @override
  _PessoalpageState createState() => _PessoalpageState();
}

class _PessoalpageState extends State<Pessoalpage> {
  bool _userEdited = false;
  final _toDoController = TextEditingController();
  List _toDoList = [];
  Map<String, dynamic> _lastRemoved = {};
  int _lastRemovedPos = 0;

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;

      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: getPessoalAppBar(),
        drawer: getDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(17.0, 3.0, 9.0, 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    //usado quando tem uum textfield filho o widget expande ao maximo
                    child: TextField(
                      onChanged: (text) {
                        //onchange usada para detectar as alterções do valor do textfild
                        print(text);
                      },
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      controller: _toDoController,
                      decoration: InputDecoration(
                        labelText: 'Categoria',
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      //impede que o usuario insira strings diferentes de numeros
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]+(\.){0,1}[0-9]*'))
                      ],
                      onChanged: (text) {
                        //variavel que recebe o valor de cada entrad
                        double valor_Entrada = 0.0;
                        try {
                          valor_Entrada = double.parse(
                              text); //converte a string para double
                        } catch (e) {
                          print("nao foi possivel converter para double");
                        }
                      },
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Valor',
                      ),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.only(bottom: 10.0),
                      color: Colors.green,
                      child: Text("Entrada"),
                      textColor: Colors.white,
                      onPressed: _addToDo,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.only(bottom: 10.0),
                      color: Colors.red,
                      child: Text("Saidas"),
                      textColor: Colors.white,
                      onPressed: _addToDo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addToDo,
          child: Text("Saidas"),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
          title: Text(_toDoList[index]["title"]),
          value: _toDoList[index]["ok"],
          secondary: CircleAvatar(
            child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
          ),
          onChanged: (c) {
            setState(() {
              _toDoList[index]["ok"] = c;
              _saveData();
            });
            print(c);
          }),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);

          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 2),
          );

          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/data.json");
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: [
                FlatButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                FlatButton(
                    child: Text("Sim"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();

    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return "";
    }
  }
}
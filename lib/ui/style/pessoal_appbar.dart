import 'package:flutter/material.dart';

AppBar getPessoalAppBar() {
  return AppBar(
    leadingWidth: 40,
    title: Text("Contas pessoais",
        style: TextStyle(fontSize: 28, color: Colors.white)),
    toolbarHeight: 80,
    centerTitle: true,
    backgroundColor: Colors.red[700],
    actions: [
      IconButton(
        icon: Icon(
          Icons.more_vert_rounded, //3 pontos canto direito
          color: Colors.black,
        ),
        onPressed: () {}, //aparece que esta sendo pressionado
      ),
    ],
  );
}

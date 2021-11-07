import 'package:flutter/material.dart';

AppBar getPessoalAppBar() {
  return AppBar(
    title: Text("Contas pessoais"),
    centerTitle: true,
    backgroundColor: Color(0xff0A6092),
    actions: [
      IconButton(
        icon: Icon(
          Icons.more_vert_rounded, //3 pontos canto direito
          color: Colors.white,
        ),
        onPressed: () {}, //aparece que esta sendo pressionado
      ),
    ],
  );
}

import 'package:flutter/material.dart';

AppBar getEmpresarialAppBar() {
  return AppBar(
    leadingWidth: 40,
    title: Text("Contas empresariais",
        style: TextStyle(fontSize: 28, color: Colors.grey)),
    toolbarHeight: 80,
    centerTitle: true,
    backgroundColor: Colors.black,
    actions: [
      IconButton(
        icon: Icon(
          Icons.more_vert_rounded, //3 pontos canto direito
          color: Colors.grey,
        ),
        onPressed: () {}, //aparece que esta sendo pressionado
      ),
    ],
  );
}

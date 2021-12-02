import 'package:flutter/material.dart';

Drawer getDrawer() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.red[700]), //caixa
          accountName: Text("Matheus"),
          accountEmail: Text("matheus@gmail"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "RL",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          title: Text(
            "Configurações",
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          title: Text(
            "Sair",
          ),
        ),
      ],
    ),
  );
}

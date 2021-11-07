import 'dart:async';
//import 'dart:html';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String usuarioTabela = "usuarioTabela";
final String idUsuario = "idUsuario";
final String loginUsuario = "loginUsuario";
final String senhaUsuario = "senhaUsuario";
final String emailUsuario = "emailUsuario";
final String nomeUsuario = "nomeUsuario";


class UsuarioHelper {
  static final UsuarioHelper _instance = UsuarioHelper.internal();

  factory UsuarioHelper()=> _instance;

  UsuarioHelper.internal();

  Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }
  Future<Database> initDb() async{
    final databasePath = await getDatabasesPath();

    final path = join(databasePath,"usuarios.db");

    return openDatabase(path,version: 1, 
    onCreate: (Database db, int newerVersion) async{
      await db.execute(
        "CREATE TABLE $usuarioTabela($idUsuario INTEGER PRIMARY KEY, $loginUsuario TEXT, $senhaUsuario TEXT, "
         "$emailUsuario TEXT, $nomeUsuario TEXT)");
    });
  }

  Future<Usuario> salvarUsuario(Usuario usuario) async{
    Database dbUsuario = await db;
    usuario.id = await dbUsuario.insert(usuarioTabela, usuario.toMap());
    return usuario;
  }

  Future<Usuario> buscarUsuario(int id) async{
    Database dbUsuario = await db;
    List<Map> maps = await dbUsuario.query(usuarioTabela,
        columns: [idUsuario,loginUsuario,senhaUsuario,emailUsuario,nomeUsuario],
        where: "$idUsuario = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

 Future<int> deletarUsuario(int id) async {
    Database dbUsuario = await db;
    return await dbUsuario
        .delete(usuarioTabela, where: "$idUsuario = ?", whereArgs: [id]);
  }

  Future<int> updateUsuario(Usuario usuario) async {
    Database dbUsuario = await db;
    return await dbUsuario.update(usuarioTabela, usuario.toMap(),
        where: "$idUsuario = ?", whereArgs: [usuario.id]);
  }

  Future<List> getAllUsuario() async {
    Database dbUsuario = await db;
    List listMap = await dbUsuario.rawQuery("SELECT * FROM $usuarioTabela");
    List<Usuario> listUsuario = List();
    for (Map m in listMap) {
      listUsuario.add(Usuario.fromMap(m));
    }
    return listUsuario;
  }
  
  Future close() async {
    Database dbUsuario = await db;
    dbUsuario.close();
  }
}

class Usuario {
  int id;
  String login;
  String senha;
  String email;
  String nome;

  Usuario();

  Usuario.fromMap(Map map) {
    id = map[idUsuario];
    login = map[loginUsuario];
    senha = map[senhaUsuario];
    email = map[emailUsuario];
    nome = map[nomeUsuario];
  }
 
  Map toMap(){
    Map<String,dynamic> map = {
      loginUsuario: login,
      senhaUsuario: senha,
      emailUsuario: email,
      nomeUsuario: nome,
    };

    if (id != null) {
      map[idUsuario] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Usuario(id: $id, login: $login, senha: $senha, email: $email, nome: $nome)";
  }
}
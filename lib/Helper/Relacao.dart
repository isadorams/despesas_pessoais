import 'dart:async';

import 'package:controle_gastos/Helper/Mov_pessoal.dart';
import 'package:controle_gastos/Helper/Usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String relacaoTabela = "relacaoTabela";
final String idRelacao = "idRelacao";
final String idUsuarioRelacao = "idUsuarioRelacao";
final String idMovPessoalRelacao = "idMovPessoalRelacao";
//final String relatorChamado = "relatorChamado";

class RelacaoConnect {
  static final RelacaoConnect _instance = RelacaoConnect.internal();

  factory RelacaoConnect() => _instance;

  RelacaoConnect.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  get idMovPessoalRelacao => null;

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "relacao.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $relacaoTabela($idRelacao INTEGER PRIMARY KEY,"
          "$idUsuarioRelacao TEXT, $idMovPessoalRelacao INTEGER,"
          "FOREIGN KEY($idMovPessoalRelacao) REFERENCES $idMovPessoalRelacao($idPessoal))");
    });
  }

  Future<Relacao> save(Relacao relacao) async {
    Database dbrelacao = await db;
    relacao.id = await dbrelacao.insert(relacaoTabela, relacao.toMap());
    return relacao;
  }

  Future<Relacao> getRelacao(int id) async {
    Database dbrelacao = await db;
    List<Map> maps = await dbrelacao.query(relacaoTabela,
        columns: [idRelacao, idUsuarioRelacao, idMovPessoalRelacao],
        where: "$idRelacao = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Relacao.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleterelacao(int id) async {
    Database dbrelacao = await db;
    return await dbrelacao
        .delete(relacaoTabela, where: "$idRelacao = ?", whereArgs: [id]);
  }

  Future<int> update(Relacao relacao) async {
    Database dbrelacao = await db;
    return await dbrelacao.update(relacaoTabela, relacao.toMap(),
        where: "$idRelacao = ?", whereArgs: [relacao.id]);
  }

  Future<List> getAllRelacoes() async {
    Database dbrelacao = await db;
    List listMap = await dbrelacao.rawQuery(
      'SELECT * FROM $relacaoTabela'
      'LEFT JOIN $movPessoalTabela on $idMovPessoalRelacao = $idPessoal '
      'LEFT JOIN $movPessoalTabela on $idUsuarioRelacao = $idUsuario',
    );

    List<Relacao> listChamado = [];

    for (Map m in listMap) {
      listChamado.add(Relacao.fromMap(m));
    }
    return listChamado;
  }

  Future<int> getNumber() async {
    Database dbrelacao = await db;
    return Sqflite.firstIntValue(
        await dbrelacao.rawQuery("SELECT COUNT(*) FROM $relacaoTabela"));
  }

  Future<void> dropTable() async {
    Database dbrelacao = await db;
    return await dbrelacao.rawQuery("DROP TABLE IF EXISTS $relacaoTabela");
  }

  Future<void> createTable() async {
    Database dbrelacao = await db;
    await dbrelacao.rawQuery(
        "CREATE TABLE IF NOT EXISTS $relacaoTabela($idRelacao INTEGER PRIMARY KEY,"
        "$idUsuarioRelacao TEXT, $idMovPessoalRelacao INTEGER,"
        "FOREIGN KEY($idMovPessoalRelacao) REFERENCES $idMovPessoalRelacao($idPessoal))");
  }

  Future close() async {
    Database dbrelacao = await db;
    dbrelacao.close();
  }
}

class Relacao {
  int id;
  Usuario usuario = Usuario();
  MovimentacoesP movimentacoesP = MovimentacoesP();

  Relacao();

  Relacao.fromMap(Map map) {
    id = map[idRelacao];
    usuario = Usuario.fromMap(map);
    movimentacoesP = MovimentacoesP.fromMap(map);
  }

  get movPessoalRelacao => null;

  Map toMap() {
    Map<String, dynamic> map = {
      idUsuarioRelacao: usuario.id,
      idMovPessoalRelacao: movimentacoesP.id,
    };

    if (id != null) {
      map[idRelacao] = id;
    }
    return map;
  }

  @override
  String toString() {
    //sobrescrita do método para facilitar a visualização dos dados
    return "Chamado(id: $id, usuario: $usuario, movimentacoesP: $movimentacoesP)";
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String movEmpresarialTabela = "movEmpresarialTabela";
final String idEmpresarial = "idEmpresarial";
final String dataEmpresarial = "dataEmpresarial";
final String valorEmpresarial = "valorEmpresarial";
final String tipoEmpresarial = "tipoEmpresarial";
final String descricaoEmpresarial = "descricaoEmpresarial";

class MovimentacoesEmpresarial {
  static final MovimentacoesEmpresarial _instance =
      MovimentacoesEmpresarial.internal();

  factory MovimentacoesEmpresarial() => _instance;

  MovimentacoesEmpresarial.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "movimentacao_empresarial.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE $movEmpresarialTabela(" +
          "$idEmpresarial INTEGER PRIMARY KEY," +
          "$valorEmpresarial FLOAT," +
          "$dataEmpresarial TEXT," +
          "$tipoEmpresarial TEXT," +
          "$descricaoEmpresarial TEXT)");
    });
  }

  Future<MovimentacoesE> salvarMovimentacao(
      MovimentacoesE movimentacoesE) async {
    print("chamada save");
    Database dbMovimentacoesEmpresarial = await db;
    movimentacoesE.id = await dbMovimentacoesEmpresarial.insert(
        movEmpresarialTabela, movimentacoesE.toMap());
    return movimentacoesE;
  }

  Future<MovimentacoesE> getMovimentacoes(int id) async {
    Database dbMovimentacoesEmpresarial = await db;
    List<Map> maps =
        await dbMovimentacoesEmpresarial.query(movEmpresarialTabela,
            columns: [
              idEmpresarial,
              valorEmpresarial,
              dataEmpresarial,
              tipoEmpresarial,
              descricaoEmpresarial
            ],
            where: "$idEmpresarial =?",
            whereArgs: [id]);

    if (maps.length > 0) {
      return MovimentacoesE.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deletarMovimentacao(MovimentacoesE movimentacoesE) async {
    Database dbMovimentacoesEmpresarial = await db;
    return await dbMovimentacoesEmpresarial.delete(movEmpresarialTabela,
        where: "$idEmpresarial =?", whereArgs: [movimentacoesE.id]);
  }

  Future<int> updateMovimentacao(MovimentacoesE movimentacoesE) async {
    print("chamada update");
    print(movimentacoesE.toString());
    Database dbMovimentacoesEmpresarial = await db;
    return await dbMovimentacoesEmpresarial.update(
        movEmpresarialTabela, movimentacoesE.toMap(),
        where: "$idEmpresarial =?", whereArgs: [movimentacoesE.id]);
  }

  Future<List> getAllMovimentacoes() async {
    Database dbMovimentacoesEmpresarial = await db;
    List listMap = await dbMovimentacoesEmpresarial
        .rawQuery("SELECT * FROM $movEmpresarialTabela");
    List<MovimentacoesE> listMovimentacoesE = List();

    for (Map m in listMap) {
      listMovimentacoesE.add(MovimentacoesE.fromMap(m));
    }
    return listMovimentacoesE;
  }

  Future<List> getAllMovimentacoesPorMes(String data) async {
    Database dbMovimentacoesEmpresarial = await db;
    List listMap = await dbMovimentacoesEmpresarial.rawQuery(
        "SELECT * FROM $movEmpresarialTabela WHERE $dataEmpresarial LIKE '%$data%'");
    List<MovimentacoesE> listMovimentacoesE = List();

    for (Map m in listMap) {
      listMovimentacoesE.add(MovimentacoesE.fromMap(m));
    }
    return listMovimentacoesE;
  }

  Future<List> getAllMovimentacoesPorTipo(String tipo) async {
    Database dbMovimentacoesEmpresarial = await db;
    List listMap = await dbMovimentacoesEmpresarial.rawQuery(
        "SELECT * FROM $movEmpresarialTabela WHERE $tipoEmpresarial ='$tipo' ");
    List<MovimentacoesE> listMovimentacoesE = List();

    for (Map m in listMap) {
      listMovimentacoesE.add(MovimentacoesE.fromMap(m));
    }
    return listMovimentacoesE;
  }

  Future<int> getNumber() async {
    Database dbMovimentacoesEmpresarial = await db;
    return Sqflite.firstIntValue(await dbMovimentacoesEmpresarial
        .rawQuery("SELECT COUNT(*) FROM $movEmpresarialTabela"));
  }

  Future close() async {
    Database dbMovimentacoesEmpresarial = await db;
    dbMovimentacoesEmpresarial.close();
  }
}

class MovimentacoesE {
  int id;
  String data;
  double valor;
  String tipo;
  String descricao;

  MovimentacoesE();

  MovimentacoesE.fromMap(Map map) {
    id = map[idEmpresarial];
    valor = map[valorEmpresarial];
    data = map[dataEmpresarial];
    tipo = map[tipoEmpresarial];
    descricao = map[descricaoEmpresarial];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      valorEmpresarial: valor,
      dataEmpresarial: data,
      tipoEmpresarial: tipo,
      descricaoEmpresarial: descricao,
    };
    if (id != null) {
      map[idEmpresarial] = id;
    }
    return map;
  }

  String toString() {
    return "MovimentacoesE(id: $id, valor: $valor, data: $data, tipo: $tipo, desc: $descricao)";
  }
}

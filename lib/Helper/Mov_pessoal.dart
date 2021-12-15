import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String movPessoalTabela = "movPessoalTabela";
final String idPessoal = "idPessoal";
final String dataPessoal = "dataPessoal";
final String valorPessoal = "valorPessoal";
final String tipoPessoal = "tipoPessoal";
final String descricaoPessoal = "descricaoPessoal";

final String movEmpresarialTabela = "movEmpresarialTabela";
final String idEmpresarial = "idEmpresarial";
final String dataEmpresarial = "dataEmpresarial";
final String valorEmpresarial = "valorEmpresarial";
final String tipoEmpresarial = "tipoEmpresarial";
final String descricaoEmpresarial = "descricaoEmpresarial";

class MovimentacoesPessoal {
  static final MovimentacoesPessoal _instance = MovimentacoesPessoal.internal();

  factory MovimentacoesPessoal() => _instance;

  MovimentacoesPessoal.internal();

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
    final path = join(databasePath, "movimentacao_pessoal.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE $movPessoalTabela(" +
          "$idPessoal INTEGER PRIMARY KEY," +
          "$valorPessoal FLOAT," +
          "$dataPessoal TEXT," +
          "$tipoPessoal TEXT," +
          "$descricaoPessoal TEXT)");
    });
  }

  Future<MovimentacoesP> salvarMovimentacao(
      MovimentacoesP movimentacoesP) async {
    print("chamada save");
    Database dbMovimentacoesP = await db;
    movimentacoesP.id =
        await dbMovimentacoesP.insert(movPessoalTabela, movimentacoesP.toMap());
    return movimentacoesP;
  }

  Future<MovimentacoesP> getMovimentacoes(int id) async {
    Database dbMovimentacoesP = await db;
    List<Map> maps = await dbMovimentacoesP.query(movPessoalTabela,
        columns: [
          idPessoal,
          valorPessoal,
          dataPessoal,
          tipoPessoal,
          descricaoPessoal
        ],
        where: "$idPessoal =?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return MovimentacoesP.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deletarMovimentacao(MovimentacoesP movimentacoesP) async {
    Database dbMovimentacoesP = await db;
    return await dbMovimentacoesP.delete(movPessoalTabela,
        where: "$idPessoal =?", whereArgs: [movimentacoesP.id]);
  }

  Future<int> updateMovimentacao(MovimentacoesP movimentacoesP) async {
    print("chamada update");
    print(movimentacoesP.toString());
    Database dbMovimentacoesP = await db;
    return await dbMovimentacoesP.update(
        movPessoalTabela, movimentacoesP.toMap(),
        where: "$idPessoal =?", whereArgs: [movimentacoesP.id]);
  }

  Future<List> getAllMovimentacoes() async {
    Database dbMovimentacoesP = await db;
    List listMap =
        await dbMovimentacoesP.rawQuery("SELECT * FROM $movPessoalTabela");
    List<MovimentacoesP> listMovimentacoesP = List();

    for (Map m in listMap) {
      listMovimentacoesP.add(MovimentacoesP.fromMap(m));
    }
    return listMovimentacoesP;
  }

  Future<List> getAllMovimentacoesPorMes(String data) async {
    Database dbMovimentacoesP = await db;
    List listMap = await dbMovimentacoesP.rawQuery(
        "SELECT * FROM $movPessoalTabela WHERE $dataPessoal LIKE '%$data%'");
    List<MovimentacoesP> listMovimentacoesP = List();

    for (Map m in listMap) {
      listMovimentacoesP.add(MovimentacoesP.fromMap(m));
    }
    return listMovimentacoesP;
  }

  Future<List> getAllMovimentacoesPorTipo(String tipo) async {
    Database dbMovimentacoesP = await db;
    List listMap = await dbMovimentacoesP.rawQuery(
        "SELECT * FROM $movPessoalTabela WHERE $tipoPessoal ='$tipo' ");
    List<MovimentacoesP> listMovimentacoesP = List();

    for (Map m in listMap) {
      listMovimentacoesP.add(MovimentacoesP.fromMap(m));
    }
    return listMovimentacoesP;
  }

  Future<int> getNumber() async {
    Database dbMovimentacoesP = await db;
    return Sqflite.firstIntValue(await dbMovimentacoesP
        .rawQuery("SELECT COUNT(*) FROM $movPessoalTabela"));
  }

  Future close() async {
    Database dbMovimentacoesP = await db;
    dbMovimentacoesP.close();
  }
}

class MovimentacoesP {
  int id;
  String data;
  double valor;
  String tipo;
  String descricao;

  MovimentacoesP();

  MovimentacoesP.fromMap(Map map) {
    id = map[idPessoal];
    valor = map[valorPessoal];
    data = map[dataPessoal];
    tipo = map[tipoPessoal];
    descricao = map[descricaoPessoal];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      valorPessoal: valor,
      dataPessoal: data,
      tipoPessoal: tipo,
      descricaoPessoal: descricao,
    };
    if (id != null) {
      map[idPessoal] = id;
    }
    return map;
  }

  String toString() {
    return "MovimentacoesP(id: $id, valor: $valor, data: $data, tipo: $tipo, desc: $descricao)";
  }
}

import 'package:list_maker/database/db_manager.dart';
import 'package:list_maker/model/model.dart';

class TobuyOperator{
  final dbHelper = DBHelper.dbHero;

  Future<int> insert(Tobuy tobuy) async {
    return await dbHelper.insertDb(tobuy.toMap());
  }

  Future<List<Tobuy>> getAllTobuys() async {
    final List<Map<String, dynamic>> maps = await dbHelper.readDb();
    return List.generate(maps.length, (i) {
      return Tobuy(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: (maps[i]['price']).toDouble(),
        amount: maps[i]['amount'],
      );
    });
  }

  Future<int> update(Tobuy tobuy) async {
    return await dbHelper.updateDb(tobuy.toMap());
  }

  Future<int> delete(int id) async {
    return await dbHelper.deleteDb(id);
  }

  Future dropAll() async {
    dbHelper.debugResetTable();
  }
}
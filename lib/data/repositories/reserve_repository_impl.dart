import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:tennis_territory_app/domain/reserve/reserve.dart';
import 'package:tennis_territory_app/domain/reserve/reserve_repository.dart';

class ReserveRepositoryImpl implements ReserveRepository {
  final String database;
  ReserveRepositoryImpl({required this.database});

  final String nameTable = 'Reserve';
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, database),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Reserve(id INTEGER PRIMARY KEY AUTOINCREMENT, courtId TEXT NOT NULL, date DATETIME NOT NULL, userName TEXT NOT NULL )",
        );
      },
      version: 1,
    );
  }

  @override
  Future<Reserve> addReserve({required Reserve reserve}) async {
    try {
      final Database db = await initializeDB();

      reserve.id = (await db.insert(nameTable, reserve.toJson(),
              conflictAlgorithm: ConflictAlgorithm.replace))
          .toString();

      return reserve;
    } catch (e) {
      debugPrint("Something went wrong when addReserve: $e");
      throw Exception("No se ha podido agendar la cancha");
    }
  }

  @override
  Future<void> deleteReserve({required String id}) async {
    try {
      final Database db = await initializeDB();

      await db.delete(nameTable, where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong when deleteReserve: $e");
      throw Exception("No se ha podido eliminar la reserva");
    }
  }

  @override
  Future<List<Reserve>> getAllReserve(
      {required DateTime date, bool upcoming = true}) async {
    try {
      String where = '=';
      final Database db = await initializeDB();

      if (upcoming) where = '>=';
      final List<Map<String, Object?>> queryResult = await db.query(nameTable,
          orderBy: "date ASC",
          where: 'date $where ?',
          whereArgs: [date.toIso8601String()]);

      return queryResult.map((reserve) => Reserve.fromJson(reserve)).toList();
    } catch (e) {
      debugPrint("Something went wrong when getAllReserve: $e");
      throw Exception("No se han podido cargar los registros");
    }
  }
}

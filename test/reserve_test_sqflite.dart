import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_territory_app/data/repositories/reserve_repository_impl.dart';
import 'package:tennis_territory_app/domain/reserve/reserve.dart';
import 'package:tennis_territory_app/domain/reserve/reserve_use_cases.dart';

/// Initialize sqflite for test.
DatabaseFactory sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;

  return databaseFactory;
}

void main() {
  const String nameDatabase = 'database_test.db';
  final day = DateTime.now().subtract(const Duration(days: 1));

  final ReserveUseCase reserveUseCase =
      ReserveUseCase(ReserveRepositoryImpl(database: nameDatabase));
  final DatabaseFactory databaseFactory = sqfliteTestInit();

  tearDownAll(() async {
    String path = await getDatabasesPath();
    databaseFactory.deleteDatabase(join(path, nameDatabase));
  });

  group(
    'Reserve',
    () {
      setUpAll(
        () async {
          // Insert
          await reserveUseCase.makeReserve(
              reserve: Reserve(courtId: 'A', date: day, userName: 'Wilderman'));
        },
      );

      test('Reserve Insert', () async {
        final getReserve = await reserveUseCase.viewAllReserve(date: day);

        expect(getReserve.isNotEmpty, true);
      });
      test('Reserve Delete', () async {
        await reserveUseCase.cancelReserve(id: '1');
        final getReserve = await reserveUseCase.viewAllReserve(date: day);

        expect(getReserve.isEmpty, true);
      });

      test('Reserve limit 3', () async {
        await reserveUseCase.makeReserve(
            reserve: Reserve(courtId: 'A', date: day, userName: 'Wilderman'));

        try {
          await reserveUseCase.makeReserve(
              reserve: Reserve(courtId: 'A', date: day, userName: 'Wilderman'));
          fail('Se esperaba una excepción pero no se lanzó ninguna.');
        } catch (e) {
          expect(e, isA<Exception>());
        }
      });
    },
  );
}

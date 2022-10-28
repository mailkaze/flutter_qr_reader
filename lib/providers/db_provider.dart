import 'dart:io';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fl_qrreader/models/scan_model.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // para que todo funcione le tuve que añadir unas lineas al build.graddle,
    // aquí la solución: https://stackoverflow.com/questions/55591958/flutter-firestore-causing-d8-cannot-fit-requested-classes-in-a-single-dex-file
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    // esto viene del paquete path que no se importa
    // automáticamente. Unimos la ruta de documentos con el nombre
    // que le queremos dar a nuestra DB
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print('el path: $path');
    // crea la base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  // Forma 1 de hacer un INSERT:
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final db = await database; // esto es una llamada al getter de arriba

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, $tipo, $valor )
    ''');

    // la respuesta de la base datos a una operacion es un integer
    return res;
  }

  // Forma 2 de hacer un INSERT:
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;

    // aqui toJson es el metodo que esta en nuestro modelo del Scan
    // simplemente convierte la instancia de la clase a un map (un objeto)
    final res = await db.insert('Scans', nuevoScan.toJson());

    print('Inserto esto: ${nuevoScan.toJson()}');
    print('respuesta de la DB: $res');
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }
}

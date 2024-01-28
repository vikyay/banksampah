import 'package:banksampah/perdataan/model/barang.dart';
import 'package:banksampah/perdataan/model/kategori.dart';
import 'package:banksampah/perdataan/model/aturan.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'flutter_sqflite_database.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store breeds
  // and a table to store dogs.

  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {breeds} TABLE statement on the database.
    await db.execute(
      //'CREATE TABLE breeds(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
      'CREATE TABLE breeds(id INTEGER PRIMARY KEY, kategori TEXT, subkategori TEXT, satuan TEXT, hargasatuan TEXT)',
    );
    // Run the CREATE {dogs} TABLE statement on the database.
    await db.execute(
      //'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, color INTEGER, breedId INTEGER, FOREIGN KEY (breedId) REFERENCES breeds(id) ON DELETE SET NULL)',
      'CREATE TABLE dogs(id INTEGER PRIMARY KEY, nama TEXT, waktu INTEGER, catatan TEXT, barang001 TEXT, barang002 TEXT, barang003 TEXT, barang004 TEXT, barang005 TEXT, barang006 TEXT, barang007 TEXT, barang008 TEXT, barang009 TEXT, barang010 TEXT, barang011 TEXT, barang012 TEXT, barang013 TEXT, barang014 TEXT, barang015 TEXT, barang016 TEXT, barang017 TEXT, barang018 TEXT, barang019 TEXT, barang020 TEXT, barang021 TEXT, barang022 TEXT, barang023 TEXT, barang024 TEXT, barang025 TEXT, barang026 TEXT, barang027 TEXT, barang028 TEXT, barang029 TEXT, barang030 TEXT, barang031 TEXT, barang032 TEXT, barang033 TEXT, barang034 TEXT, barang035 TEXT, barang036 TEXT, barang037 TEXT, barang038 TEXT, barang039 TEXT, barang040 TEXT, barang041 TEXT, barang042 TEXT, barang043 TEXT, barang044 TEXT, barang045 TEXT, barang046 TEXT, barang047 TEXT, barang048 TEXT, barang049 TEXT, barang050 TEXT)',
    );
    // Run the CREATE {aturan} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE aturan(id INTEGER PRIMARY KEY, nama TEXT, lingkungan TEXT)',
    );
  }

  // Define a function that inserts breeds into the database
  Future<void> insertBreed(Breed breed) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Breed into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same breed is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'breeds',
      breed.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertDog(Dog dog) async {
    final db = await _databaseService.database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAturan(Aturan aturan) async {
    final db = await _databaseService.database;
    await db.insert(
      'aturan',
      aturan.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the breeds from the breeds table.
  Future<List<Breed>> breeds() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await db.query('breeds');

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => Breed.fromMap(maps[index]));
  }

  Future<Breed> breed(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('breeds', where: 'id = ?', whereArgs: [id]);
    return Breed.fromMap(maps[0]);
  }

  Future<List<Dog>> dogs() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (index) => Dog.fromMap(maps[index]));
  }

  Future<List<Aturan>> aturan() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('aturan');
    return List.generate(maps.length, (index) => Aturan.fromMap(maps[index]));
  }

  // A method that updates a breed data from the breeds table.
  Future<void> updateBreed(Breed breed) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given breed
    await db.update(
      'breeds',
      breed.toMap(),
      // Ensure that the Breed has a matching id.
      where: 'id = ?',
      // Pass the Breed's id as a whereArg to prevent SQL injection.
      whereArgs: [breed.id],
    );
  }

  Future<void> updateDog(Dog dog) async {
    final db = await _databaseService.database;
    await db.update('dogs', dog.toMap(), where: 'id = ?', whereArgs: [dog.id]);
  }

  Future<void> updateAturan(Aturan aturan) async {
    final db = await _databaseService.database;
    await db.update('aturan', aturan.toMap(), where: 'id = ?', whereArgs: [aturan.id]);
  }

  // A method that deletes a breed data from the breeds table.
  Future<void> deleteBreed(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Breed from the database.
    await db.delete(
      'breeds',
      // Use a `where` clause to delete a specific breed.
      where: 'id = ?',
      // Pass the Breed's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteDog(int id) async {
    final db = await _databaseService.database;
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);

  }

  Future<void> deleteAturan(int id) async {
    final db = await _databaseService.database;
    await db.delete('aturan', where: 'id = ?', whereArgs: [id]);
  }

}

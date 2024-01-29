import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE penyetor(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nama TEXT,
        description TEXT
      )
      """);
    await database.execute("""CREATE TABLE daftarkategori(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        kategori TEXT NOT NULL
      )
      """);
    await database.execute("""CREATE TABLE daftarsubkategori(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idkategori INTEGER NOT NULL,
        subkategori TEXT NOT NULL,
        satuan TEXT NOT NULL,
        hargapersatuan INT NOT NULL 
      )
      """);
    await database.execute("""CREATE TABLE setoran(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idtglsetor INTEGER NOT NULL,
        idsubkategori INTEGER NOT NULL,
        jumlah INTEGER NOT NULL
      )  
      """);
    await database.execute("""CREATE TABLE tglsetor(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idpenyetor INTEGER NOT NULL,
        createdAt TIMESTAMP NOT NULL
      )  
      """);
    await database.rawInsert("""INSERT INTO tglsetor (id, idpenyetor, createdAt) VALUES
        (1, 2, '2024-01-29 00:05:01'),
        (2, 3, '2024-01-29 00:05:01'),
        (3, 8, '2024-01-29 00:05:01'),
        (4, 4, '2024-01-29 00:05:01'),
        (5, 5, '2024-01-29 00:05:01');
      """);
    await database.rawInsert("""INSERT INTO setoran (id, idtglsetor, idsubkategori, jumlah) VALUES
        (1, 1, 3, 100),
        (2, 1, 4, 550),
        (3, 2, 4, 120),
        (4, 2, 12, 300),
        (5, 3, 1, 100),
        (6, 4, 2, 120),
        (7, 5, 7, 130);
      """);
    await database.rawInsert("""INSERT INTO penyetor (id, nama, description) VALUES
        (1, 'Ayu', 'CSJ 1'),
        (2, 'Dinda', 'CSJ 2'),
        (3, 'Wulan', 'CSJ 6'),
        (4, 'Santi', 'CSJ 9'),
        (5, 'Dewi', 'CSJ 13'),
        (6, 'Wardhani', 'CSJ 17'),
        (7, 'Susan', 'CSJ 24'),
        (8, 'Yanti', 'CSJ 25'),
        (9, 'Ningsih', 'CSJ 26'),
        (10, 'Nabila', 'CSJ 27');
      """);
    await database.rawInsert("""INSERT INTO daftarkategori (id, kategori) VALUES
        (1, 'Metal'),
        (2, 'Plastik'),
        (3, 'Kertas'),
        (4, 'Beling/Kaca'),
        (5, 'Akrilik'),
        (6, 'Fiber'),
        (7, 'Styrofoam'),
        (8, 'Jelantah'),
        (9, 'Sepatu'),
        (10, 'Aki'),
        (11, 'Karpet'),
        (12, 'Impact');
      """);
    await database.rawInsert("""INSERT INTO daftarsubkategori (id, idkategori, subkategori, satuan, hargapersatuan) VALUES
        (1, 1, 'Besi', 'Kg', 0),
        (2, 1, 'Tembaga', 'Kg', 11000),
        (3, 1, 'Aluminium', 'Kg', 0),
        (4, 1, 'Babet/Kran', 'Kg', 0),
        (5, 1, 'Kaleng', 'Kg', 2000),
        (6, 1, 'Seng/Kawat', 'Kg', 1000),
        (7, 2, 'PE (Plastik Putih)', 'Kg', 0),
        (8, 2, 'PVC (Paralon)', 'Kg', 0),
        (9, 2, 'Asoy (Plastik Bekas)', 'Kg', 250),
        (10, 2, 'Botol Putih (Bodong Bersih)', 'Kg', 3500),
        (11, 2, 'Botol Warna (Bodong Warna)', 'Kg', 900),
        (12, 2, 'Gelas Mineral (Bersih)', 'Kg', 0),
        (13, 2, 'Gelas Mineral (Kotor)', 'Kg', 0),
        (14, 2, 'Gelas Mineral (Warna)', 'Kg', 0),
        (15, 2, 'Tutup Botol', 'Kg', 2500),
        (16, 2, 'Tutup Galon', 'Kg', 4000),
        (17, 2, 'Emberan', 'Kg', 1500),
        (18, 2, 'Kabin', 'Kg', 0),
        (19, 2, 'Botol Kotor', 'Kg', 0),
        (20, 2, 'Ember Hitam/Pot', 'Kg', 0),
        (21, 3, 'Putihan/HVS', 'Kg', 1600),
        (22, 3, 'Majalah', 'Kg', 0),
        (23, 3, 'Buku Kotor', 'Kg', 1200),
        (24, 3, 'Koran', 'Kg', 0),
        (25, 3, 'Karton/Boncos', 'Kg', 400),
        (26, 3, 'Kardus', 'Kg', 1200),
        (27, 3, 'Duplek', 'Kg', 0),
        (28, 3, 'Karung Semen', 'Kg', 0),
        (29, 3, 'Kertas Buram', 'Kg', 0),
        (30, 4, 'Botol/Beling', 'Kg', 250),
        (31, 4, 'Beling Pecah', 'Kg', 0),
        (32, 5, 'Kristal', 'Kg', 3000),
        (33, 5, 'Keping CD/DVD', 'Kg', 0),
        (34, 5, 'Toples Tipis', 'Kg', 0),
        (35, 6, 'Galon LeMinerale', 'Buah', 2800),
        (36, 7, 'Styrofoam', 'Buah', 0),
        (37, 8, 'Jelantah', 'Kg', 5500),
        (38, 9, 'Sepatu', 'Kg', 0),
        (39, 10, 'Aki Mobil', 'Kg', 0),
        (40, 11, 'Karpet', 'Kg', 0),
        (41, 12, 'Impact', 'Kg', 0);
      """);
  }
// id: the id of a item
// nama, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'bank.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // tambah tglsetor
  static Future<int> createItem(int idpenyetor) async {
    final db = await SQLHelper.db();
    final data = {'idpenyetor': idpenyetor, 'createdAt': DateTime.now().toString()};
    final id = await db.insert('tglsetor', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // // Create new item (journal)
  // static Future<int> createItem(String nama, String? descrption) async {
  //   final db = await SQLHelper.db();
  //
  //   final data = {'nama': nama, 'description': descrption};
  //   final id = await db.insert('penyetor', data,
  //       conflictAlgorithm: sql.ConflictAlgorithm.replace);
  //   return id;
  // }


  // Read all penyetor (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('penyetor', orderBy: "id");
  }

  // Ambil kategori
  static Future<List<Map<String, dynamic>>> getKategori() async {
    final db = await SQLHelper.db();
    return db.query('daftarkategori', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getSubKategori() async {
    final db = await SQLHelper.db();
    return db.query('daftarsubkategori', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getJumlah() async {
    final db = await SQLHelper.db();
    return db.query('setoran', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getSetoran() async {
    final db = await SQLHelper.db();
    return db.query('setoran', orderBy: "id");
  }

  // Ambil nama di daftar setoran
  static Future<List<Map<String, dynamic>>> getTglsetor() async {
    final db = await SQLHelper.db();
    return db.query('tglsetor', orderBy: "createdAt");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('penyetor', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String nama) async {
    final db = await SQLHelper.db();

    final data = {
      'nama': nama,

    };

    final result =
    await db.update('penyetor', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  //update setoran per biji
  static Future<int> updateSetoran(
      int idpenyetor, int idsubkategori, int jumlah) async {
    final db = await SQLHelper.db();
    final data = {
      'idpenyetor': idpenyetor,
      'idsubkategori': idsubkategori,
      'jumlah': jumlah,
      'createdAt': DateTime.now().toString()
    };
    // cek ada nggak
    final cek = await db.rawQuery(
        'SELECT * FROM setoran WHERE idpenyetor=? and idsubkategori=?',
        [idpenyetor, idsubkategori]);
    if(cek.isNotEmpty){
      //update
      final result = await db.rawUpdate('''
                UPDATE setoran 
                SET jumlah = ?, createdAt = ? 
                WHERE idpenyetor = ?
                AND idsubkategori = ?
                ''',
          [jumlah, DateTime.now().toString(), idpenyetor, idsubkategori]);
      return result;
    }else{
      //bikin baru
      final result = await db.insert('setoran', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return result;
    }
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("tglsetor", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Terjadi kesalahan ketika menghapus...: $err");
    }
  }
}

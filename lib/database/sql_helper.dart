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
        hargapersatuan REAL NOT NULL 
      )
      """);
    await database.execute("""CREATE TABLE setoran(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idtglsetor INTEGER NOT NULL,
        idsubkategori INTEGER NOT NULL,
        jumlah REAL NOT NULL
      )  
      """);
    await database.execute("""CREATE TABLE tglsetor(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        idpenyetor INTEGER NOT NULL,
        createdAt TEXT NOT NULL
      )  
      """);
    await database.execute("""CREATE TABLE pengaturan(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        aturan TEXT NOT NULL,
        nilai TEXT NOT NULL
      )  
      """);
    await database.rawInsert("""INSERT INTO pengaturan (id, aturan, nilai) VALUES
        (1, 'namabank', 'Bank Sampah CSJ'),
        (2, 'alamat', 'Jalan Jombang Raya, Kelurahan Jombang, Kecamatan Ciputat, Kota Tangerang Selatan'),
        (3, 'namalingkungan', 'Cluster Sudimara Jombang'),
        (4, 'contactperson', 'Evi (085111111xxx)');
      """);
    await database.rawInsert("""INSERT INTO tglsetor (id, idpenyetor, createdAt) VALUES
        (1, 1, '2024-01-20 07:00:00'),
        (2, 2, '2024-01-21 08:12:00'),
        (3, 3, '2024-01-22 09:28:00'),
        (4, 4, '2024-01-23 09:30:00'),
        (5, 5, '2024-01-23 09:42:00'),
        (6, 6, '2024-01-24 13:11:00'),
        (7, 7, '2024-01-24 07:22:00'),
        (8, 8, '2024-01-25 19:08:00'),
        (9, 9, '2024-01-25 19:38:00'),
        (10, 1, '2024-01-26 12:12:00'),
        (11, 2, '2024-01-29 16:05:00');
      """);
    await database.rawInsert("""INSERT INTO setoran (id, idtglsetor, idsubkategori, jumlah) VALUES
        (1, 1, 1, 135.0),
        (2, 1, 2, 298.0),
        (3, 1, 3, 470.0),
        (4, 1, 4, 321.0),
        (5, 1, 5, 405.0),
        (6, 1, 6, 372.0),
        (7, 1, 7, 334.0),
        (8, 1, 8, 228.0),
        (9, 2, 1, 357.0),
        (10, 2, 2, 319.0),
        (11, 2, 3, 278.0),
        (12, 2, 4, 369.0),
        (13, 2, 5, 150.0),
        (14, 2, 6, 388.0),
        (15, 2, 7, 118.0),
        (16, 3, 1, 136.0),
        (17, 3, 2, 253.0),
        (18, 3, 3, 124.0),
        (19, 3, 4, 233.0),
        (20, 3, 5, 224.0),
        (21, 3, 6, 419.0),
        (22, 3, 7, 304.0),
        (23, 3, 8, 227.0),
        (24, 3, 9, 154.0),
        (25, 4, 1, 201.0),
        (26, 4, 2, 463.0),
        (27, 4, 3, 181.0),
        (28, 4, 4, 258.0),
        (29, 4, 5, 489.0),
        (30, 4, 6, 324.0),
        (31, 4, 7, 387.0),
        (32, 4, 8, 190.0);
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
        (1, 1, 'Besi', 'gram', 0),
        (2, 1, 'Tembaga', 'gram', 11),
        (3, 1, 'Aluminium', 'gram', 0),
        (4, 1, 'Babet/Kran', 'gram', 0),
        (5, 1, 'Kaleng', 'gram', 2),
        (6, 1, 'Seng/Kawat', 'gram', 1),
        (7, 2, 'PE (Plastik Putih)', 'gram', 0),
        (8, 2, 'PVC (Paralon)', 'gram', 0),
        (9, 2, 'Asoy (Plastik Bekas)', 'gram', 0.25),
        (10, 2, 'Botol Putih (Bodong Bersih)', 'gram', 3.5),
        (11, 2, 'Botol Warna (Bodong Warna)', 'gram', 0.9),
        (12, 2, 'Gelas Mineral (Bersih)', 'gram', 0),
        (13, 2, 'Gelas Mineral (Kotor)', 'gram', 0),
        (14, 2, 'Gelas Mineral (Warna)', 'gram', 0),
        (15, 2, 'Tutup Botol', 'gram', 2.5),
        (16, 2, 'Tutup Galon', 'gram', 4),
        (17, 2, 'Emberan', 'gram', 1.5),
        (18, 2, 'Kabin', 'gram', 0),
        (19, 2, 'Botol Kotor', 'gram', 0),
        (20, 2, 'Ember Hitam/Pot', 'gram', 0),
        (21, 3, 'Putihan/HVS', 'gram', 1.6),
        (22, 3, 'Majalah', 'gram', 0),
        (23, 3, 'Buku Kotor', 'gram', 1.2),
        (24, 3, 'Koran', 'gram', 0),
        (25, 3, 'Karton/Boncos', 'gram', 0.4),
        (26, 3, 'Kardus', 'gram', 1.2),
        (27, 3, 'Duplek', 'gram', 0),
        (28, 3, 'Karung Semen', 'gram', 0),
        (29, 3, 'Kertas Buram', 'gram', 0),
        (30, 4, 'Botol/Beling', 'gram', 0.25),
        (31, 4, 'Beling Pecah', 'gram', 0),
        (32, 5, 'Kristal', 'gram', 3),
        (33, 5, 'Keping CD/DVD', 'gram', 0),
        (34, 5, 'Toples Tipis', 'gram', 0),
        (35, 6, 'Galon LeMinerale', 'Buah', 2.8),
        (36, 7, 'Styrofoam', 'Buah', 0),
        (37, 8, 'Jelantah', 'gram', 5.5),
        (38, 9, 'Sepatu', 'gram', 0),
        (39, 10, 'Aki Mobil', 'gram', 0),
        (40, 11, 'Karpet', 'gram', 0),
        (41, 12, 'Impact', 'gram', 0);
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

  // Ambil identitas, pengaturan dkk
  static Future<List<Map<String, dynamic>>> getPengaturan() async {
    final db = await SQLHelper.db();
    return db.query('pengaturan', orderBy: "id");
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

  static Future<List<Map<String, dynamic>>> getNasabah() async {
    final db = await SQLHelper.db();
    return db.query('penyetor', orderBy: "id");
  }

  // Ambil nama di daftar setoran
  static Future<List<Map<String, dynamic>>> getTglSetor() async {
    final db = await SQLHelper.db();
    return db.query('tglsetor', orderBy: "createdAt");
  }

  // Ambil setoran utk print pdf dari pegawai
  static Future<List<List<dynamic>>> getSetoranBuatPDF(int idtglsetor) async {
    final db = await SQLHelper.db();
    //setoran
    List<Map<String, dynamic>> setoran = [];
    // setoran = await db.query('setoran', orderBy:'idsubkategori', where: '$idtglsetor = ?', whereArgs: [idtglsetor]);
    setoran = await db.rawQuery(
        'SELECT * FROM setoran WHERE idtglsetor=?',
        [idtglsetor]);
    //subkategori
    List<Map<String, dynamic>> subkategori = [];
    subkategori = await db.query('daftarsubkategori', orderBy:'id');
    //kategori
    List<Map<String, dynamic>> kategori = [];
    kategori = await db.query('daftarkategori', orderBy:'id');
    //gabung
    List<List<dynamic>> njajal = [];
    setoran.forEach((e) {
      njajal.addAll([[subkategori.firstWhere((element) => element.values.elementAt(0) == e.values.elementAt(2)).values.elementAt(2),
        kategori.firstWhere((element) => element.values.elementAt(0) == subkategori.firstWhere((element) => element.values.elementAt(0) == e.values.elementAt(2)).values.elementAt(1)).values.elementAt(1),
        subkategori.firstWhere((element) => element.values.elementAt(0) == e.values.elementAt(2)).values.elementAt(3),
        e.values.elementAt(3),
        e.values.elementAt(3) * subkategori.firstWhere((element) => element.values.elementAt(0) == e.values.elementAt(2)).values.elementAt(4)
        ]]);
    });
    // setoran = [];

    return njajal;
  }






  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('penyetor', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String nama) async {
    final db = await SQLHelper.db();
    final data = {
      'nama': nama,
    };
    final result = await db.update('penyetor', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Update pengaturan
  static Future<int> updatePengaturan(int id, String nilai) async {
    final db = await SQLHelper.db();
    final data = {
      'nilai': nilai,
    };
    final result = await db.update('pengaturan', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  //update setoran per biji
  static Future<int> updateSetoran(
      int idtglsetor, int idsubkategori, int jumlah) async {
    final db = await SQLHelper.db();
    final data = {
      'idtglsetor': idtglsetor,
      'idsubkategori': idsubkategori,
      'jumlah': jumlah,
    };
    // cek ada nggak
    final cek = await db.rawQuery(
        'SELECT * FROM setoran WHERE idtglsetor=? and idsubkategori=?',
        [idtglsetor, idsubkategori]);
    if(cek.isNotEmpty){
      //update
      final result = await db.rawUpdate('''
                UPDATE setoran 
                SET jumlah = ?
                WHERE idtglsetor = ?
                AND idsubkategori = ?
                ''',
          [jumlah, idtglsetor, idsubkategori]);
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

  static Future<void> tambahNasabah(String nama, String description) async {
    final db = await SQLHelper.db();
    final data = {
      'nama': nama,
      'description': description,
    };
    await db.insert('penyetor', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> tambahTglSetor(int? idpenyetor, String createdAt) async {
    final db = await SQLHelper.db();
    final data = {
      'idpenyetor': idpenyetor,
      'createdAt': createdAt,
    };
    // print(idpenyetor.toString());
    // print(createdAt);
    if (idpenyetor!=null)  {
      await db.insert('tglsetor', data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    }

  }

  static Future<void> hapusNasabah(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("penyetor", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Terjadi kesalahan ketika menghapus...: $err");
    }
  }

  static Future<void> hapusTglSetor(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("tglsetor", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Terjadi kesalahan ketika menghapus...: $err");
    }
  }

  static Future<void> hapusSubKategori(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("daftarsubkategori", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Terjadi kesalahan ketika menghapus...: $err");
    }
  }


}


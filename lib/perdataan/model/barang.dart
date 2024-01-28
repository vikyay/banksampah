import 'dart:convert';
import 'package:intl/intl.dart';

class Dog {
  final int? id;
  final String nama;
  final int waktu;
  final String catatan;
  final int barang001;
  final int barang002;
//  final int barang003;
//  final int barang004;
//  final int barang005;
//  final int barang006;
//  final int barang007;
//  final int barang008;
//  final int barang009;
//  final int barang010;
//  final int barang011;
//  final int barang012;
//  final int barang013;
//  final int barang014;
//  final int barang015;
//  final int barang016;
//  final int barang017;
//  final int barang018;
//  final int barang019;
//  final int barang020;
//  final int barang021;
//  final int barang022;
//  final int barang023;
//  final int barang024;
//  final int barang025;
//  final int barang026;
//  final int barang027;
//  final int barang028;
//  final int barang029;
//  final int barang030;
//  final int barang031;
//  final int barang032;
//  final int barang033;
//  final int barang034;
//  final int barang035;
//  final int barang036;
//  final int barang037;
//  final int barang038;
//  final int barang039;
//  final int barang040;
//  final int barang041;
//  final int barang042;
//  final int barang043;
//  final int barang044;
//  final int barang045;
//  final int barang046;
//  final int barang047;
//  final int barang048;
//  final int barang049;
//  final int barang050;


  Dog({
    this.id,
    required this.nama,
    required this.waktu,
    required this.catatan,
    required this.barang001,
    required this.barang002,
//    required this.barang003,
//    required this.barang004,
//    required this.barang005,
//    required this.barang006,
//    required this.barang007,
//    required this.barang008,
//    required this.barang009,
//    required this.barang010,
//    required this.barang011,
//    required this.barang012,
//    required this.barang013,
//    required this.barang014,
//    required this.barang015,
//    required this.barang016,
//    required this.barang017,
//    required this.barang018,
//    required this.barang019,
//    required this.barang020,
//    required this.barang021,
//    required this.barang022,
//    required this.barang023,
//    required this.barang024,
//    required this.barang025,
//    required this.barang026,
//    required this.barang027,
//    required this.barang028,
//    required this.barang029,
//    required this.barang030,
//    required this.barang031,
//    required this.barang032,
//    required this.barang033,
//    required this.barang034,
//    required this.barang035,
//    required this.barang036,
//    required this.barang037,
//    required this.barang038,
//    required this.barang039,
//    required this.barang040,
//    required this.barang041,
//    required this.barang042,
//    required this.barang043,
//    required this.barang044,
//    required this.barang045,
//    required this.barang046,
//    required this.barang047,
//    required this.barang048,
//    required this.barang049,
//    required this.barang050,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'waktu': waktu,
      'catatan': catatan,
      'barang001': barang001,
      'barang002': barang002,
      // 'barang003': barang003,
      // 'barang004': barang004,
      // 'barang005': barang005,
      // 'barang006': barang006,
      // 'barang007': barang007,
      // 'barang008': barang008,
      // 'barang009': barang009,
      // 'barang010': barang010,
      // 'barang011': barang011,
      // 'barang012': barang012,
      // 'barang013': barang013,
      // 'barang014': barang014,
      // 'barang015': barang015,
      // 'barang016': barang016,
      // 'barang017': barang017,
      // 'barang018': barang018,
      // 'barang019': barang019,
      // 'barang020': barang020,
      // 'barang021': barang021,
      // 'barang022': barang022,
      // 'barang023': barang023,
      // 'barang024': barang024,
      // 'barang025': barang025,
      // 'barang026': barang026,
      // 'barang027': barang027,
      // 'barang028': barang028,
      // 'barang029': barang029,
      // 'barang030': barang030,
      // 'barang031': barang031,
      // 'barang032': barang032,
      // 'barang033': barang033,
      // 'barang034': barang034,
      // 'barang035': barang035,
      // 'barang036': barang036,
      // 'barang037': barang037,
      // 'barang038': barang038,
      // 'barang039': barang039,
      // 'barang040': barang040,
      // 'barang041': barang041,
      // 'barang042': barang042,
      // 'barang043': barang043,
      // 'barang044': barang044,
      // 'barang045': barang045,
      // 'barang046': barang046,
      // 'barang047': barang047,
      // 'barang048': barang048,
      // 'barang049': barang049,
      // 'barang050': barang050,
    };
  }

  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(
      id: map['id']?.toInt() ?? 0,
      nama: map['nama'] ?? '',
      catatan: map['catatan'] ?? '',
      waktu: map['waktu']?.toInt() ?? 0,
      barang001: map['barang001']?.toInt() ?? 0,
      barang002: map['barang002']?.toInt() ?? 0,
      // barang003: map['barang003']?.toInt() ?? 0,
      // barang004: map['barang004']?.toInt() ?? 0,
      // barang005: map['barang005']?.toInt() ?? 0,
      // barang006: map['barang006']?.toInt() ?? 0,
      // barang007: map['barang007']?.toInt() ?? 0,
      // barang008: map['barang008']?.toInt() ?? 0,
      // barang009: map['barang009']?.toInt() ?? 0,
      // barang010: map['barang010']?.toInt() ?? 0,
      // barang011: map['barang011']?.toInt() ?? 0,
      // barang012: map['barang012']?.toInt() ?? 0,
      // barang013: map['barang013']?.toInt() ?? 0,
      // barang014: map['barang014']?.toInt() ?? 0,
      // barang015: map['barang015']?.toInt() ?? 0,
      // barang016: map['barang016']?.toInt() ?? 0,
      // barang017: map['barang017']?.toInt() ?? 0,
      // barang018: map['barang018']?.toInt() ?? 0,
      // barang019: map['barang019']?.toInt() ?? 0,
      // barang020: map['barang020']?.toInt() ?? 0,
      // barang021: map['barang021']?.toInt() ?? 0,
      // barang022: map['barang022']?.toInt() ?? 0,
      // barang023: map['barang023']?.toInt() ?? 0,
      // barang024: map['barang024']?.toInt() ?? 0,
      // barang025: map['barang025']?.toInt() ?? 0,
      // barang026: map['barang026']?.toInt() ?? 0,
      // barang027: map['barang027']?.toInt() ?? 0,
      // barang028: map['barang028']?.toInt() ?? 0,
      // barang029: map['barang029']?.toInt() ?? 0,
      // barang030: map['barang030']?.toInt() ?? 0,
      // barang031: map['barang031']?.toInt() ?? 0,
      // barang032: map['barang032']?.toInt() ?? 0,
      // barang033: map['barang033']?.toInt() ?? 0,
      // barang034: map['barang034']?.toInt() ?? 0,
      // barang035: map['barang035']?.toInt() ?? 0,
      // barang036: map['barang036']?.toInt() ?? 0,
      // barang037: map['barang037']?.toInt() ?? 0,
      // barang038: map['barang038']?.toInt() ?? 0,
      // barang039: map['barang039']?.toInt() ?? 0,
      // barang040: map['barang040']?.toInt() ?? 0,
      // barang041: map['barang041']?.toInt() ?? 0,
      // barang042: map['barang042']?.toInt() ?? 0,
      // barang043: map['barang043']?.toInt() ?? 0,
      // barang044: map['barang044']?.toInt() ?? 0,
      // barang045: map['barang045']?.toInt() ?? 0,
      // barang046: map['barang046']?.toInt() ?? 0,
      // barang047: map['barang047']?.toInt() ?? 0,
      // barang048: map['barang048']?.toInt() ?? 0,
      // barang049: map['barang049']?.toInt() ?? 0,
      // barang050: map['barang050']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dog.fromJson(String source) => Dog.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    //return 'Dog(id: $id, name: $name, age: $age, color: $color, breedId: $breedId)';
    //return 'Dog(id: $id, nama: $nama, waktu: $waktu, catatan: $catatan, barang001: $barang001, barang002: $barang002, barang003: $barang003, barang004: $barang004,barang005: $barang005, barang006: $barang006, barang007: $barang007, barang008:$barang008, barang009: $barang009, barang010: $barang010, barang011: $barang011,barang012: $barang012, barang013: $barang013, barang014: $barang014, barang015:$barang015, barang016: $barang016, barang017: $barang017, barang018: $barang018,barang019: $barang019, barang020: $barang020, barang021: $barang021, barang022:$barang022, barang023: $barang023, barang024: $barang024, barang025: $barang025,barang026: $barang026, barang027: $barang027, barang028: $barang028, barang029:$barang029, barang030: $barang030, barang031: $barang031, barang032: $barang032,barang033: $barang033, barang034: $barang034, barang035: $barang035, barang036:$barang036, barang037: $barang037, barang038: $barang038, barang039: $barang039,barang040: $barang040, barang041: $barang041, barang042: $barang042, barang043:$barang043, barang044: $barang044, barang045: $barang045, barang046: $barang046,barang047: $barang047, barang048: $barang048, barang049: $barang049, barang050: $barang050)';
    return 'Dog(id: $id, nama: $nama, waktu: $waktu, catatan: $catatan, barang001: $barang001, barang002: $barang002)';
  }
}

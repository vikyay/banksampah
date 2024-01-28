import 'dart:convert';

class Breed {
  final int? id;
  final String kategori;
  final String subkategori;
  final String satuan;
  final int hargasatuan;
  Breed({
    this.id,
    required this.kategori,
    required this.subkategori,
    required this.satuan,
    required this.hargasatuan,
  });

  // Convert a Breed into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategori': kategori,
      'subkategori': subkategori,
      'satuan': satuan,
      'hargasatuan': hargasatuan,
    };
  }

  factory Breed.fromMap(Map<String, dynamic> map) {
    return Breed(
      id: map['id']?.toInt() ?? 0,
      kategori: map['kategori'] ?? '',
      subkategori: map['subkategori'] ?? '',
      satuan: map['satuan'] ?? '',
      hargasatuan: map['hargasatuan']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Breed.fromJson(String source) => Breed.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each Breed when using the print statement.
  @override
  String toString() {
    return 'Breed(id: $id, kategori: $kategori, subkategori: $subkategori, satuan: $satuan, hargasatuan: $hargasatuan)';
  }
}

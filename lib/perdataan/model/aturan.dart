import 'dart:convert';

class Aturan {
  final int? id;
  final String nama;
  final String lingkungan;

  Aturan({
    this.id,
    required this.nama,
    required this.lingkungan,
  });

  // Convert a Aturan into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': nama,
      'description': lingkungan,
    };
  }

  factory Aturan.fromMap(Map<String, dynamic> map) {
    return Aturan(
      id: map['id']?.toInt() ?? 0,
      nama: map['nama'] ?? '',
      lingkungan: map['lingkungan'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Aturan.fromJson(String source) => Aturan.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each Aturan when using the print statement.
  @override
  String toString() => 'Aturan(id: $id, nama: $nama, lingkungan: $lingkungan)';
}

import 'package:flutter/material.dart';
import '../database/sql_helper.dart';
import 'package:intl/intl.dart';
import 'info.dart';
import '../bantuan/bantuan.dart';

void laporan() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Laporan(),
  ));
}

class Laporan extends StatefulWidget {
  const Laporan({super.key});

  @override
  State<Laporan> createState() => _LaporanState();
}
class _LaporanState extends State<Laporan> {
  // final List<Map<String, dynamic>> _nasabah = [];
  List<Map<String, dynamic>> _daftarsetoran = [];
  String? textkategori;
  String? textnasabah;

  // final TextEditingController _nama = TextEditingController();
  // final TextEditingController _description = TextEditingController();

  //ambil data
  void _refresh() async {
    final data1 = await SQLHelper.getTglSetor();
    final data2 = await SQLHelper.getNasabah();
    _daftarsetoran = [];
    data1.forEach((e) {
      var daftar = {
        'id': e['id'],
        'idnasabah': e['idnasabah'],
        'nasabah': data2.firstWhere((el) => el['id'] == e['idnasabah']).values.elementAt(1).toString(),
        'createdAt': DateFormat("EEEE, d MMMM yyyy - hh:MM", "id_ID")
            .format(DateTime.parse(e['createdAt'])),
      };
      _daftarsetoran.add(daftar);
    });
    setState(() {
      _daftarsetoran;
    });

  }

  @override
  void initState() {
    super.initState();
    //load ketika mulai
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Buat ",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 0.5),
                        blurRadius: 5.0,
                        color: Color.fromARGB(150, 255, 255, 255),
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: "Laporan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.0, 1.0),
                        blurRadius: 5.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(padding: const EdgeInsets.only(right: 15), child: Ink(
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
              ),
              child: const InfoLaporan(),
            ))

          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                              //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PerNasabah()),
                            );
                          },
                          child: const Column(children: [
                            Icon(Icons.supervised_user_circle,
                                color: Colors.white, size: 70.0),
                            Text("Per Nasabah")
                          ])),
                    ),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                              //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PerKategori()),
                            );
                          },
                          child: const Column(children: [
                            Icon(Icons.category_outlined,
                                color: Colors.white, size: 70.0),
                            Text("Per Kategori")
                          ])),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                              //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PerBulan()),
                            );
                          },
                          child: const Column(children: [
                            Icon(Icons.calendar_month,
                                color: Colors.white, size: 70.0),
                            Text("Per Bulan")
                          ])),
                    ),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            shape: RoundedRectangleBorder(
                              //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PilihPeriode()),
                            );
                          },
                          child: const Column(children: [
                            Icon(Icons.date_range_outlined,
                                color: Colors.white, size: 70.0),
                            Text("Sesuaikan...")
                          ])),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

    );
  }
}

class PerNasabah extends StatefulWidget {
  const PerNasabah({super.key});

  @override
  State<PerNasabah> createState() => _PerNasabahState();
}
class _PerNasabahState extends State<PerNasabah> {
  List<Map<String, dynamic>> _nasabah = [];
  List<Map<String, dynamic>> _kategori = [];
  String? nasabah;
  int idnasabahterpilih=0;
  int? nasabahterpilih;
  String? kategori;
  int idkategoriterpilih=0;
  int? kategoriterpilih;

  //ambil daftar
  void _refreshKategori() async {
    final data = await SQLHelper.getKategori();
    setState(() {
      _kategori = data;
    });
  }

  //ambil daftar
  void _refreshNasabah() async {
    final data = await SQLHelper.getNasabah();
    setState(() {
      _nasabah = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNasabah();
    _refreshKategori();
  }

  //tanggal dan waktu
  final TextEditingController _tglmulai = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  final TextEditingController _wktmulai = TextEditingController(text: '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}:00');
  final TextEditingController _tglselesai = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  final TextEditingController _wktselesai = TextEditingController(text: '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}:00');
  //waktu
  Future<void> _selectTime(BuildContext context, TextEditingController kont) async {
    final TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (waktu != null) {
      setState(() {
        kont.text = '${waktu.hour.toString().padLeft(2, '0')}:${waktu.minute.toString().padLeft(2, '0')}:00';
      });
    }
  }
  //tanggal
  Future<void> _selectDate(BuildContext context, TextEditingController kont) async {
    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );
    if (tanggal != null) {
      setState(() {
        kont.text = DateFormat('yyyy-MM-dd').format(tanggal).toString();
      });
    }
  }

  //buatpdf
  num total = 0;
  void _buatPDF(int? nasabahterpilih, int? kategoriterpilih, String mulai, String selesai) async {
    final String judul;
    final String subjudul;
    //data
    final data = await SQLHelper.buatlaporanPDF(nasabahterpilih, kategoriterpilih, mulai, selesai);
    //total
    total = 0;

    data.forEach((e) {
      total = total + e.elementAt(4);});
    //wkt
    String wkt='${DateFormat('dd MMM yyyy').format(DateTime.parse(mulai)).toString()} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(selesai)).toString()}';

    if(nasabahterpilih!=null && kategoriterpilih!=null){
      judul=_nasabah[nasabahterpilih]['nama'].toString();
      subjudul='Kategori ${_kategori[kategoriterpilih]['kategori'].toString()}';
      final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
      FileHandleApi.openFile(pdfFile);
    }
    else{
      if(nasabahterpilih!=null && kategoriterpilih==null){
        judul=_nasabah[nasabahterpilih]['nama'].toString();
        subjudul='Semua Kategori';
        final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
        FileHandleApi.openFile(pdfFile);
      }
      else{
        if(nasabahterpilih==null && kategoriterpilih!=null){
          judul='Semua Nasabah';
          subjudul='Kategori ${_kategori[kategoriterpilih]['kategori'].toString()}';
          final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
          FileHandleApi.openFile(pdfFile);
        }
        else{
          if(nasabahterpilih==null && kategoriterpilih==null){
            judul='Semua Nasabah';
            subjudul='Semua Kategori';
            final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
            FileHandleApi.openFile(pdfFile);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropnasabah = [];
    _nasabah.forEach((element) {
      dropnasabah.add(element['nama']);
    });
    List<String> dropkategori = [];
    _kategori.forEach((element) {dropkategori.add(element['kategori']);});

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Per Nasabah'),
        ),
        body: Column(
          children: <Widget>[
            const Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.supervised_user_circle,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    'Buat Laporan Per Nasabah',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 0,
                    child: Text('Mulai',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ))),
                SizedBox(width: 38),
                Expanded(
                    flex: 0,
                    child: Text('Selesai',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _tglmulai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.date_range_outlined),
                        onPressed: () {
                          _selectDate(context, _tglmulai);
                        },
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _tglselesai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context, _tglselesai);
                        },
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _wktmulai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () {
                          _selectTime(context, _wktmulai);
                        },
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _wktselesai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () {
                          _selectTime(context, _wktselesai);
                        },
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 0,
                    child: DropdownButton<int>(
                      value: nasabahterpilih,
                      hint: const Text('Pilih nama...'),
                      items: dropnasabah.asMap().entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          nasabahterpilih = value;
                          if(nasabahterpilih!=null){
                            idnasabahterpilih = nasabahterpilih?.toInt() ?? 0;
                            nasabah = dropnasabah[idnasabahterpilih].toString();
                          }
                        });
                      },
                    ))
              ],
            ),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
                    child: Text(
                      'Buat Laporan (PDF)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    _buatPDF(nasabahterpilih, null, DateTime.parse('${_tglmulai.text} ${_wktmulai.text}').toIso8601String().toString() ,DateTime.parse('${_tglselesai.text} ${_wktselesai.text}').toIso8601String().toString());
                  },
                ),
              ],
            )
          ],
        ));
  }
}

class PerKategori extends StatefulWidget {
  const PerKategori({super.key});

  @override
  State<PerKategori> createState() => _PerKategoriState();
}
class _PerKategoriState extends State<PerKategori> {
  List<Map<String, dynamic>> _nasabah = [];
  List<Map<String, dynamic>> _kategori = [];
  String? nasabah;
  int idnasabahterpilih=0;
  int? nasabahterpilih;
  String? kategori;
  int idkategoriterpilih=0;
  int? kategoriterpilih;

  //ambil daftar
  void _refreshKategori() async {
    final data = await SQLHelper.getKategori();
    setState(() {
      _kategori = data;
    });
  }

  //ambil daftar
  void _refreshNasabah() async {
    final data = await SQLHelper.getNasabah();
    setState(() {
      _nasabah = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNasabah();
    _refreshKategori();
  }

  //tanggal dan waktu
  final TextEditingController _tglmulai = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  final TextEditingController _wktmulai = TextEditingController(text: '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}:00');
  final TextEditingController _tglselesai = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  final TextEditingController _wktselesai = TextEditingController(text: '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}:00');
  //waktu
  Future<void> _selectTime(BuildContext context, TextEditingController kont) async {
    final TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (waktu != null) {
      setState(() {
        kont.text = '${waktu.hour.toString().padLeft(2, '0')}:${waktu.minute.toString().padLeft(2, '0')}:00';
      });
    }
  }
  //tanggal
  Future<void> _selectDate(BuildContext context, TextEditingController kont) async {
    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );
    if (tanggal != null) {
      setState(() {
        kont.text = DateFormat('yyyy-MM-dd').format(tanggal).toString();
      });
    }
  }

  //buatpdf
  num total = 0;
  void _buatPDF(int? nasabahterpilih, int? kategoriterpilih, String mulai, String selesai) async {
    final String judul;
    final String subjudul;
    //data
    final data = await SQLHelper.buatlaporanPDF(nasabahterpilih, kategoriterpilih, mulai, selesai);


    //total
    total = 0;
    data.forEach((e) {total = total + e.elementAt(4);});
    //wkt
    String wkt='${DateFormat('dd MMM yyyy').format(DateTime.parse(mulai)).toString()} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(selesai)).toString()}';

    if(nasabahterpilih==null && kategoriterpilih!=null){
      judul='Semua Nasabah';
      subjudul='Kategori ${_kategori[kategoriterpilih]['kategori'].toString()}';
      final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
      FileHandleApi.openFile(pdfFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropnasabah = [];
    _nasabah.forEach((element) {
      dropnasabah.add(element['nama']);
    });
    List<String> dropkategori = [];
    _kategori.forEach((element) {dropkategori.add(element['kategori']);});

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Per Kategori'),
        ),
        body: Column(
          children: <Widget>[
            const Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.category_outlined,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    'Buat Laporan Per Kategori',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 0,
                    child: Text('Mulai',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ))),
                SizedBox(width: 38),
                Expanded(
                    flex: 0,
                    child: Text('Selesai',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _tglmulai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context, _tglmulai);
                        },
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _tglselesai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context, _tglselesai);
                        },
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _wktmulai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () {
                          _selectTime(context, _wktmulai);
                        },
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _wktselesai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () {
                          _selectTime(context, _wktselesai);
                        },
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 0,
                    child: DropdownButton<int>(
                      value: kategoriterpilih,
                      hint: const Text('Pilih kategori...'),
                      items: dropkategori.asMap().entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          kategoriterpilih = value;
                          if(kategoriterpilih!=null){
                            idkategoriterpilih = kategoriterpilih?.toInt() ?? 0;
                            kategori = dropkategori[idkategoriterpilih].toString();
                          }
                        });
                      },
                    ))
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
                    child: Text(
                      'Buat Laporan (PDF)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    _buatPDF(null, kategoriterpilih, DateTime.parse('${_tglmulai.text} ${_wktmulai.text}').toIso8601String().toString() ,DateTime.parse('${_tglselesai.text} ${_wktselesai.text}').toIso8601String().toString());
                  },
                ),
              ],
            )
          ],
        ));
  }
}

class PerBulan extends StatefulWidget {
  const PerBulan({super.key});

  @override
  State<PerBulan> createState() => _PerBulanState();
}
class _PerBulanState extends State<PerBulan> {
  final List<String> _bulan = ['Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember'];
  final _tahun = List<String>.generate(20, (int index) => (DateTime.now().year - 1 + index).toString(), growable: false);
  String? bulan;
  String? tahun;
  int? bulanterpilih;
  int? tahunterpilih;

  List<Map<String, dynamic>> _nasabah = [];
  List<Map<String, dynamic>> _kategori = [];
  String? nasabah;
  int idnasabahterpilih=0;
  int? nasabahterpilih;
  String? kategori;
  int idkategoriterpilih=0;
  int? kategoriterpilih;

  //ambil daftar
  void _refreshKategori() async {
    final data = await SQLHelper.getKategori();
    setState(() {
      _kategori = data;
    });
  }

  //ambil daftar
  void _refreshNasabah() async {
    final data = await SQLHelper.getNasabah();
    setState(() {
      _nasabah = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNasabah();
    _refreshKategori();
  }

  //buatpdf
  num total = 0;
  void _buatPDF(int? bulanterpilih, int? tahunterpilih, String mulai, String selesai) async {
    final String judul;
    final String subjudul;
    //data
    mulai = DateTime(int.parse(_tahun.elementAt(tahunterpilih?.toInt() ?? 0)), int.parse(((bulanterpilih?.toInt() ?? 0)+1).toString()), 1).toIso8601String();
    selesai = DateTime(int.parse(_tahun.elementAt(tahunterpilih?.toInt() ?? 0)), int.parse(((bulanterpilih?.toInt() ?? 0)+2).toString()), 1).subtract(const Duration(days: 1)).toIso8601String();
    final data = await SQLHelper.buatlaporanPDF(null, null, mulai, selesai);
    //total
    total = 0;
    data.forEach((e) {total = total + e.elementAt(4);});
    //wkt
    String wkt='${DateFormat('dd MMM yyyy').format(DateTime.parse(mulai)).toString()} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(selesai)).toString()}';

    if(bulanterpilih!=null && tahunterpilih!=null){
      judul=_nasabah[bulanterpilih]['nama'].toString();
      subjudul='Kategori ${_kategori[tahunterpilih]['kategori'].toString()}';
      final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
      FileHandleApi.openFile(pdfFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropnasabah = [];
    _nasabah.forEach((element) {
      dropnasabah.add(element['nama']);
    });
    List<String> dropkategori = [];
    _kategori.forEach((element) {dropkategori.add(element['kategori']);});

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Per Bulan'),
        ),
        body: Column(
          children: <Widget>[
            const Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.calendar_month,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    'Buat Laporan Per Bulan',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 0,
                    child: DropdownButton<int>(
                      value: bulanterpilih,
                      hint: const Text('Bulan...'),
                      items: _bulan.asMap().entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          bulanterpilih = value;
                        });
                      },
                    )),
                const SizedBox(width: 15),
                Expanded(
                    flex: 0,
                    child: DropdownButton<int>(
                      value: tahunterpilih,
                      hint: const Text('Tahun...'),
                      items: _tahun.asMap().entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          tahunterpilih = value;
                        });
                      },
                    ))
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
                    child: Text(
                      'Buat Laporan (PDF)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    _buatPDF(bulanterpilih, tahunterpilih, '', '');
                  },
                ),
              ],
            )
          ],
        ));
  }
}

class PilihPeriode extends StatefulWidget {
  const PilihPeriode({super.key});

  @override
  State<PilihPeriode> createState() => _PilihPeriodeState();
}
class _PilihPeriodeState extends State<PilihPeriode> {
  List<Map<String, dynamic>> _nasabah = [];
  List<Map<String, dynamic>> _kategori = [];
  String? nasabah;
  int idnasabahterpilih=0;
  int? nasabahterpilih;
  String? kategori;
  int idkategoriterpilih=0;
  int? kategoriterpilih;

  //ambil daftar
  void _refreshKategori() async {
    final data = await SQLHelper.getKategori();
    setState(() {
      _kategori = data;
    });
  }

  //ambil daftar
  void _refreshNasabah() async {
    final data = await SQLHelper.getNasabah();
    setState(() {
      _nasabah = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshNasabah();
    _refreshKategori();
  }

  //tanggal dan waktu
  final TextEditingController _tglmulai = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  final TextEditingController _wktmulai = TextEditingController(text: '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}:00');
  final TextEditingController _tglselesai = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  final TextEditingController _wktselesai = TextEditingController(text: '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}:00');
  //waktu
  Future<void> _selectTime(BuildContext context, TextEditingController kont) async {
    final TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (waktu != null) {
      setState(() {
        kont.text = '${waktu.hour.toString().padLeft(2, '0')}:${waktu.minute.toString().padLeft(2, '0')}:00';
      });
    }
  }
  //tanggal
  Future<void> _selectDate(BuildContext context, TextEditingController kont) async {
    final DateTime? tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2099),
    );
    if (tanggal != null) {
      setState(() {
        kont.text = DateFormat('yyyy-MM-dd').format(tanggal).toString();
      });
    }
  }

  //buatpdf
  num total = 0;
  void _buatPDF(int? nasabahterpilih, int? kategoriterpilih, String mulai, String selesai) async {
    final String judul;
    final String subjudul;
    //data
    final data = await SQLHelper.buatlaporanPDF(nasabahterpilih, kategoriterpilih, mulai, selesai);
    //total
    total = 0;
    data.forEach((e) {total = total + e.elementAt(4);});
    //wkt
    String wkt='${DateFormat('dd MMM yyyy').format(DateTime.parse(mulai)).toString()} - ${DateFormat('dd MMM yyyy').format(DateTime.parse(selesai)).toString()}';

    if(nasabahterpilih!=null && kategoriterpilih!=null){
      judul=_nasabah[nasabahterpilih]['nama'].toString();
      subjudul='Kategori ${_kategori[kategoriterpilih]['kategori'].toString()}';
      final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
      FileHandleApi.openFile(pdfFile);
    }
    else{
      if(nasabahterpilih!=null && kategoriterpilih==null){
        judul=_nasabah[nasabahterpilih]['nama'].toString();
        subjudul='Semua Kategori';
        final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
        FileHandleApi.openFile(pdfFile);
      }
      else{
        if(nasabahterpilih==null && kategoriterpilih!=null){
          judul='Semua Nasabah';
          subjudul='Kategori ${_kategori[kategoriterpilih]['kategori'].toString()}';
          final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
          FileHandleApi.openFile(pdfFile);
        }
        else{
          if(nasabahterpilih==null && kategoriterpilih==null){
            judul='Semua Nasabah';
            subjudul='Semua Kategori';
            final pdfFile = await BuatLaporanPDF.generate(data, judul, subjudul, wkt, total);
            FileHandleApi.openFile(pdfFile);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> dropnasabah = [];
    _nasabah.forEach((element) {
      dropnasabah.add(element['nama']);
    });
    List<String> dropkategori = [];
    _kategori.forEach((element) {dropkategori.add(element['kategori']);});

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Sesuaikan laporan...'),
        ),
        body: Column(
          children: <Widget>[
            const Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.date_range_outlined,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    'Sesuaikan laporan...',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    flex: 0,
                    child: Text('Mulai',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ))),
                SizedBox(width: 38),
                Expanded(
                    flex: 0,
                    child: Text('Selesai',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _tglmulai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context, _tglmulai);
                        },
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _tglselesai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.date_range),
                        onPressed: () {
                          _selectDate(context, _tglselesai);
                        },
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _wktmulai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () {
                          _selectTime(context, _wktmulai);
                        },
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _wktselesai,
                      )),
                  Expanded(
                      flex: 0,
                      child: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () {
                          _selectTime(context, _wktselesai);
                        },
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 0,
                    child: DropdownButton<int>(
                      value: nasabahterpilih,
                      hint: const Text('Pilih nama...'),
                      items: dropnasabah.asMap().entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          nasabahterpilih = value;
                          if(nasabahterpilih!=null){
                            idnasabahterpilih = nasabahterpilih?.toInt() ?? 0;
                            nasabah = dropnasabah[idnasabahterpilih].toString();
                          }
                        });
                      },
                    ))
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 0,
                    child: DropdownButton<int>(
                      value: kategoriterpilih,
                      hint: const Text('Pilih kategori...'),
                      items: dropkategori.asMap().entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          kategoriterpilih = value;
                          if(kategoriterpilih!=null){
                            idkategoriterpilih = kategoriterpilih?.toInt() ?? 0;
                            kategori = dropkategori[idkategoriterpilih].toString();
                          }
                        });
                      },
                    ))
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
                    child: Text(
                      'Buat Laporan (PDF)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    _buatPDF(nasabahterpilih, kategoriterpilih, DateTime.parse('${_tglmulai.text} ${_wktmulai.text}').toIso8601String().toString() ,DateTime.parse('${_tglselesai.text} ${_wktselesai.text}').toIso8601String().toString());
                  },
                ),
              ],
            )
          ],
        ));
  }
}


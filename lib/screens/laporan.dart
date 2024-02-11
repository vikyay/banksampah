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
  final List<Map<String, dynamic>> _nasabah = [];
  List<Map<String, dynamic>> _daftarsetoran = [];
  String? textkategori;
  String? textnasabah;

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _description = TextEditingController();

  //ambil data
  void _refresh() async {
    final data1 = await SQLHelper.getTglSetor();
    final data2 = await SQLHelper.getNasabah();
    _daftarsetoran = [];
    data1.forEach((e) {
      var daftar = {
        'id': e['id'],
        'idpenyetor': e['idpenyetor'],
        'penyetor': data2.firstWhere((el) => el['id'] == e['idpenyetor']).values.elementAt(1).toString(),
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
                        // blurRadius: 1.0,
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
                        blurRadius: 1.0,
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
              child: const InfoDaftarSetoran(),
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
                            Icon(Icons.calendar_month_outlined,
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
                            Icon(Icons.date_range,
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
  String? terpilih;

  //ambil daftar nasabah
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
  }

  //tanggal dan waktu
  final TextEditingController _tglmulai = TextEditingController(text: DateFormat.yMMMd('id_ID').format(DateTime.now()).toString());
  final TextEditingController _tglselesai = TextEditingController(text: DateFormat.yMMMd('id_ID').format(DateTime.now()).toString());
  final TextEditingController _wktmulai = TextEditingController(text: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}');
  final TextEditingController _wktselesai = TextEditingController(text: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}');
  //waktu
  Future<void> _selectTime(BuildContext context, TextEditingController kont) async {
    final TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (waktu != null) {
      setState(() {
        kont.text = '${waktu.hour}:${waktu.minute}';
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
        kont.text = DateFormat.yMMMd('id_ID').format(tanggal).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> drop = [];
    _nasabah.forEach((element) {
      drop.add(element['nama']);
    });
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
                    child: DropdownButton<String>(
                      value: terpilih,
                      hint: const Text('Pilih nama...'),
                      items: drop.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        terpilih = value;
                        setState(() {
                          terpilih;
                          // _refreshNasabah();
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
                    // generate pdf file
                    final pdfFile = await PdfInvoiceApi.generate();

                    // opening the pdf file
                    FileHandleApi.openFile(pdfFile);
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
  List<Map<String, dynamic>> _kategori = [];
  String? terpilih;

  //ambil daftar
  void _refreshKategori() async {
    final data = await SQLHelper.getKategori();
    setState(() {
      _kategori = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshKategori();
  }

  //tanggal dan waktu
  final TextEditingController _tglmulai = TextEditingController(text: DateFormat.yMMMd('id_ID').format(DateTime.now()).toString());
  final TextEditingController _tglselesai = TextEditingController(text: DateFormat.yMMMd('id_ID').format(DateTime.now()).toString());
  final TextEditingController _wktmulai = TextEditingController(text: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}');
  final TextEditingController _wktselesai = TextEditingController(text: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}');
  //waktu
  Future<void> _selectTime(BuildContext context, TextEditingController kont) async {
    final TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (waktu != null) {
      setState(() {
        kont.text = '${waktu.hour}:${waktu.minute}';
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
        kont.text = DateFormat.yMMMd('id_ID').format(tanggal).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> drop = [];
    _kategori.forEach((element) {drop.add(element['kategori']);});
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
                    child: DropdownButton<String>(
                      value: terpilih,
                      hint: const Text('Pilih kategori...'),
                      items: drop.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        terpilih = value;
                        setState(() {
                          terpilih;
                          // _refreshNasabah();
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
                    // generate pdf file
                    final pdfFile = await PdfInvoiceApi.generate();

                    // opening the pdf file
                    FileHandleApi.openFile(pdfFile);
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
  List<String> _bulan = ['Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember'];
  final _tahun = List<String>.generate(20, (int index) => (DateTime.now().year - 1 + index).toString(), growable: false);
  String? bulan;
  String? tahun;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    Icons.calendar_month_outlined,
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
                    child: DropdownButton<String>(
                      value: bulan,
                      hint: const Text('Bulan...'),
                      items: _bulan.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        bulan = value;
                        setState(() {
                          bulan;
                          // _refreshNasabah();
                        });
                      },
                    )),
                Expanded(
                    flex: 0,
                    child: DropdownButton<String>(
                      value: tahun,
                      hint: const Text('Tahun...'),
                      items: _tahun.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        tahun = value;
                        setState(() {
                          tahun;
                          // _refreshNasabah();
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
                    // generate pdf file
                    final pdfFile = await PdfInvoiceApi.generate();

                    // opening the pdf file
                    FileHandleApi.openFile(pdfFile);
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
  String? kategori;

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
  final TextEditingController _tglmulai = TextEditingController(text: DateFormat.yMMMd('id_ID').format(DateTime.now()).toString());
  final TextEditingController _tglselesai = TextEditingController(text: DateFormat.yMMMd('id_ID').format(DateTime.now()).toString());
  final TextEditingController _wktmulai = TextEditingController(text: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}');
  final TextEditingController _wktselesai = TextEditingController(text: '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}');
  //waktu
  Future<void> _selectTime(BuildContext context, TextEditingController kont) async {
    final TimeOfDay? waktu = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (waktu != null) {
      setState(() {
        kont.text = '${waktu.hour}:${waktu.minute}';
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
        kont.text = DateFormat.yMMMd('id_ID').format(tanggal).toString();
      });
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
                    child: DropdownButton<String>(
                      value: nasabah,
                      hint: const Text('Pilih nama...'),
                      items: dropnasabah.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        nasabah = value;
                        setState(() {
                          nasabah;
                          // _refreshNasabah();
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
                    child: DropdownButton<String>(
                      value: kategori,
                      hint: const Text('Pilih kategori...'),
                      items: dropkategori.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        kategori = value;
                        setState(() {
                          kategori;
                          // _refreshNasabah();
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
                    // generate pdf file
                    final pdfFile = await PdfInvoiceApi.generate();

                    // opening the pdf file
                    FileHandleApi.openFile(pdfFile);
                  },
                ),
              ],
            )
          ],
        ));
  }
}


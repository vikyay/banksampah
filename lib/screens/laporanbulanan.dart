import 'package:flutter/material.dart';
import 'filehandle_api.dart';
import 'pdf_api.dart';
import 'package:banksampah/widgets/select_date_time.dart';
import '../database/sql_helper.dart';

void pdfscreen() {
  runApp(const Laporan());
}

class Laporan extends StatelessWidget {
  const Laporan({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Buat Laporan Periodik',
      debugShowCheckedModeBanner: false,
      home: BerandaLaporan(),
    );
  }
}

class BerandaLaporan extends StatelessWidget {
  const BerandaLaporan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Daftar nasabah
                  ElevatedButton(
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
                  //Daftar kategori
                  ElevatedButton(
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
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
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
                  ElevatedButton(
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PerNasabah extends StatefulWidget {
  const PerNasabah({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    List<String> drop = [];
    _nasabah.forEach((element) {drop.add(element['nama']);});
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Per Nasabah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.supervised_user_circle,
              size: 200.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Buat Laporan Per Nasabah',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SelectDate(),
                  ),
                  SizedBox(width: 40, child: Text(' s.d. ')),
                  Expanded(
                    child: SelectDateTwo(),
                  ),
                ],
              ),
            ),

            DropdownButton<String>(
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
            ),
            
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
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
        ),
      ),
    );
  }
}

class PerKategori extends StatefulWidget {
  const PerKategori({Key? key}) : super(key: key);

  @override
  State<PerKategori> createState() => _PerKategoriState();
}
class _PerKategoriState extends State<PerKategori> {
  List<Map<String, dynamic>> _kategori = [];
  String? terpilih;

  //ambil daftar nasabah
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

  @override
  Widget build(BuildContext context) {
    List<String> drop = [];
    _kategori.forEach((element) {drop.add(element['kategori']);});
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Per Kategori'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.category_outlined,
              size: 200.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Buat Laporan Per Kategori',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SelectDate(),
                  ),
                  SizedBox(width: 40, child: Text(' s.d. ')),
                  Expanded(
                    child: SelectDateTwo(),
                  ),
                ],
              ),
            ),

            DropdownButton<String>(
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
            ),

            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
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
        ),
      ),
    );
  }
}

class PerBulan extends StatefulWidget {
  const PerBulan({Key? key}) : super(key: key);

  @override
  State<PerBulan> createState() => _PerBulanState();
}
class _PerBulanState extends State<PerBulan> {
  List<String> bulan = ['Januari','Februari','Maret','April','Mei','Juni','Juli','Agustus','September','Oktober','November','Desember'];
  String? terpilih;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Per Bulan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              size: 200.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Buat Laporan Per Bulan',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15,),
            DropdownButton<String>(
              value: terpilih,
              hint: const Text('Pilih bulan...'),
              items: bulan.map((String value) {
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
            ),

            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
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
        ),
      ),
    );
  }
}

class PilihPeriode extends StatefulWidget {
  const PilihPeriode({Key? key}) : super(key: key);

  @override
  State<PilihPeriode> createState() => _PilihPeriodeState();
}
class _PilihPeriodeState extends State<PilihPeriode> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pilih Periode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.date_range,
              size: 200.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Pilih Periode Laporan',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SelectDate(),
                  ),
                  SizedBox(width: 40, child: Text(' s.d. ')),
                  Expanded(
                    child: SelectDateTwo(),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 8.0),
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
        ),
      ),
    );
  }
}

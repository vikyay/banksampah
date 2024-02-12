import 'package:flutter/material.dart';
import '../database/sql_helper.dart';
import 'package:intl/intl.dart';
import 'detilsetoran.dart';
import 'info.dart';

void daftar() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DaftarSetoran(),
  ));
}

class DaftarSetoran extends StatefulWidget {
  const DaftarSetoran({super.key});

  @override
  State<DaftarSetoran> createState() => _DaftarSetoranState();
}

class _DaftarSetoranState extends State<DaftarSetoran> {
  List<Map<String, dynamic>> _nasabah = [];
  List<Map<String, dynamic>> _daftarsetoran = [];
  String? textkategori;
  String? textnasabah;
  int idterpilih=0;
  int? terpilih;

  //tanggal dan waktu
  final TextEditingController _tglmulai = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString());
  final TextEditingController _wktmulai = TextEditingController(text: '${TimeOfDay.now().hour.toString().padLeft(2, '0')}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}:00');

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


  //ambil daftar nasabah
  void _refreshNasabah() async {
    final data = await SQLHelper.getNasabah();
    setState(() {
      _nasabah = data;
    });
  }


  //tambah setoran
  Future<void> _tambahSetoran(BuildContext context) async {
    List<String> daftardropdown = [];
    _nasabah.forEach((element) {
      daftardropdown.add(element['nama']);
    });
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setStateSB) {
          return AlertDialog(
            title: const Text('Tambah Setoran'),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateSB) {
                return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DropdownButton<int>(
                            isExpanded:true,
                            value: terpilih,
                            hint: const Text('Pilih nasabah...'),
                            items: daftardropdown.asMap().entries.map((entry) {
                              return DropdownMenuItem<int>(
                                value: entry.key,
                                child: Text(entry.value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setStateSB(() {
                                terpilih = value;
                                if(terpilih!=null){
                                  idterpilih = terpilih?.toInt() ?? 0;
                                }
                              });
                            },
                          ),
                          Row(children: [
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
                                ))
                          ]),
                        ]));
              },
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text('BATAL'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                ),
                onPressed: () {
                  SQLHelper.tambahTglSetor(idterpilih+1, '${_tglmulai.text} ${_wktmulai.text}');
                  setState(() {
                    _refresh();
                    Navigator.pop(context);

                  });
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      ),
    );
  }

  //ambil data
  void _refresh() async {
    final data1 = await SQLHelper.getTglSetor();
    final data2 = await SQLHelper.getNasabah();
    _daftarsetoran = [];
    // data1.forEach((element) {_namanasabah.add(data2.firstWhere((e) => e['id'] == element['idpenyetor']).values.elementAt(1).toString());});
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
    _refreshNasabah();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    List<String> drop = [];
    _nasabah.forEach((element) {
      drop.add(element['nama']);
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Daftar ",
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
                  text: "Setoran",
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _tambahSetoran(context);
          },
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
          splashColor: Colors.yellow,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _daftarsetoran.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: Colors.white,
                  child:
                  Dismissible(
                    key: Key(_daftarsetoran[index]['penyetor']),
                    confirmDismiss: (direction) async {
                      setState(() {
                        SQLHelper.hapusTglSetor(_daftarsetoran[index]['id']);
                        _refresh();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Dihapus!'),
                        duration: Duration(milliseconds: 2000),
                      ));
                      return Future.value(false);
                    },
                    background: Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.red,
                      child: const Center(
                        child: Row(children: [
                          Icon(Icons.delete),
                        ]),
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    secondaryBackground: Container(),
                    child:
                      ListTile(
                        leading: const Icon(Icons.receipt),
                        title: Text(_daftarsetoran[index]['penyetor']),
                        subtitle: Text(_daftarsetoran[index]['createdAt']),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetilSetoran(nama: _daftarsetoran[index]['penyetor'], tgl: _daftarsetoran[index]['createdAt'].toString(), tglsetor_id: _daftarsetoran[index]['id']),
                            ),
                          );
                        },
                      ),
                  )
              );
            })
    );
  }
}

class Tes extends StatelessWidget {
  const Tes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
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
                        Navigator.pop(context);
                      },
                      child: const Column(children: [
                        Icon(Icons.supervised_user_circle,
                            color: Colors.white, size: 70.0),
                        Text("Daftar Nasabah")
                      ])),
                  //Daftar kategori
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Column(children: [
                        Icon(Icons.category_outlined,
                            color: Colors.white, size: 70.0),
                        Text("Daftar Kategori")
                      ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
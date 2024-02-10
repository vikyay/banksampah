import 'package:flutter/material.dart';
import '../database/sql_helper.dart';
import 'package:intl/intl.dart';
import '../widgets/select_date_time.dart';
import './daftar.dart';

void daftar() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Daftar Setoran',
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

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _description = TextEditingController();

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
            content: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            //valueText = value;
                            // print(value);
                          });
                        },
                        controller: _nama,
                        decoration: const InputDecoration(hintText: "Nama"),
                      ),
                      SelectDate(),

                    ])),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: const Text('BATAL'),
                onPressed: () {
                  setState(() {
                    //codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  SQLHelper.tambahNasabah(_nama.text, _description.text);
                  // _refreshNasabah();
                  setState(() {
                    Navigator.pop(context);
                  });
                },
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
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Daftar ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0.5, 1.5),
                        // blurRadius: 1.0,
                        color: Color.fromARGB(0, 0, 0, 0),
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
                      child: Center(
                        child: const Row(children: [
                          Icon(Icons.delete),
                        ]),
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    secondaryBackground: Container(),
                    child:
                      ListTile(
                        leading: Icon(Icons.receipt),
                        title: Text(_daftarsetoran[index]['penyetor']),
                        subtitle: Text(_daftarsetoran[index]['createdAt']),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(nama: 'aaaa', tglsetor_id: _daftarsetoran[index]['id']),
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
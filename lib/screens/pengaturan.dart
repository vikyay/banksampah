import 'package:flutter/material.dart';
import '../database/sql_helper.dart';
import 'info.dart';

void jalankan() {
  runApp(const MaterialApp(
    home: SecondRoute(),
    debugShowCheckedModeBanner: false,
  ));
}

class SecondRoute extends StatefulWidget {
const SecondRoute({Key? key}) : super(key: key);

@override
State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  List<Map<String, dynamic>> _nasabah = [];
  List<Map<String, dynamic>> _kategori = [];
  List<Map<String, dynamic>> _subkategori = [];
  String? textkategori;
  String? textnasabah;

  final TextEditingController _nama = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _namasubkategori = TextEditingController();
  final TextEditingController _satuan = TextEditingController();
  final TextEditingController _hargapersatuan = TextEditingController();
  final TextEditingController _namabank = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _namalingkungan = TextEditingController();
  final TextEditingController _contactperson = TextEditingController();


  //tambah nasabah
  Future<void> _tambahNasabah(BuildContext context) async {
    List<String> daftardropdown = [];
    _nasabah.forEach((element) {
      daftardropdown.add(element['nama']);
    });
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setStateSB) {
          return AlertDialog(
            title: const Text('Tambah Nasabah'),
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
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            //valueText = value;
                            // print(value);
                          });
                        },
                        controller: _description,
                        decoration: const InputDecoration(hintText: "Catatan"),
                      )
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
                  _refreshNasabah();
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

  //tambah kategori
  Future<void> _tambahKategori(BuildContext context) async {
    print(textkategori);
    List<String> daftardropdown = [];
    _kategori.forEach((element) {
      daftardropdown.add(element['kategori']);
    });
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setStateSB) {
          return AlertDialog(
            title: const Text('Tambah Kategori'),
            content: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
              DropdownButton<String>(
                  isExpanded: true,
                  value: textkategori,
                  hint: Text('Pilih kategori...'),
                  items: daftardropdown.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setStateSB(() {
                      textkategori = value!;
                    });
                  }),
              TextField(
                onChanged: (value) {
                  setState(() {
                    //valueText = value;
                    // print(value);
                  });
                },
                controller: _namasubkategori,
                decoration: const InputDecoration(hintText: "Nama subkategori"),
              ),
              TextField(
                    onChanged: (value) {
                      setState(() {
                        //valueText = value;
                        // print(value);
                      });
                    },
                    controller: _satuan,
                    decoration: const InputDecoration(hintText: "Satuan (Gram, Kilogram, Liter)"),
                  ),
              TextField(
                    onChanged: (value) {
                      setState(() {
                        //valueText = value;
                        // print(value);
                      });
                    },
                    controller: _hargapersatuan,
                    decoration: const InputDecoration(hintText: "Harga per satuan"),
                  )
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
                  _refreshNasabah();
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

  //ambil daftar nama
  void _refreshNasabah() async {
    final data = await SQLHelper.getNasabah();
    setState(() {
      _nasabah = data;
    });
  }

  //ambil daftar kategori
  void _refreshKategori() async {
    final data = await SQLHelper.getKategori();
    setState(() {
      _kategori = data;
    });
  }

  //ambil identitas
  void _refreshPengaturan() async {
    final data = await SQLHelper.getPengaturan();
    setState(() {
      _namabank.text = data[0]['nilai'].toString();
      _alamat.text = data[1]['nilai'].toString();
      _namalingkungan.text = data[2]['nilai'].toString();
      _contactperson.text = data[3]['nilai'].toString();

    });
  }

  void _refreshSubKategori() async {
    final data = await SQLHelper.getSubKategori();
    setState(() {
      _subkategori = data;
    });
  }

  @override
  void initState() {
    super.initState();
    //load ketika mulai
    _refreshNasabah();
    _refreshKategori();
    _refreshSubKategori();
    _refreshPengaturan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "Pengaturan",
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
        actions: <Widget>[
          Padding(padding: const EdgeInsets.only(right: 15), child: Ink(
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
            ),
            child: InfoPengaturan(),
          ))

        ],
      ),
      body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Daftar Nasabah
          ExpansionTile(
            leading: const Icon(Icons.people_alt),
            title: const Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Daftar ', style: TextStyle(fontSize: 20)),
                  TextSpan(text: 'Nasabah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ],
              ),
            ),
            children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _nasabah.length,
                        itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              key: Key(_nasabah[index]['nama']),
                              confirmDismiss: (direction) async {
                                setState(() {
                                  SQLHelper.hapusNasabah(_nasabah[index]['id']);
                                  _refreshNasabah();
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
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
                              child: Container(
                                height: 50,
                                child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: _nasabah[index]['nama'],
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                )

                                  ,
                                ),
                              ),
                            );
                          }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurpleAccent),
                          onPressed: () {
                            _tambahNasabah(context);
                          },
                          child: const Text('Tambah'),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurple),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Kembali'),
                        ),
                      ],
                    ),

                  ],
                ),
            ],
          ),
          //Daftar Kategori
          ExpansionTile(
            leading: const Icon(Icons.category_rounded),
            title: const Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Daftar ', style: TextStyle(fontSize: 22)),
                  TextSpan(text: 'Kategori', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                ],
              ),
            ),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _kategori.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTile(
                            leading: const Icon(Icons.category_outlined),
                            title: Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: _kategori[index]['kategori'], style: const TextStyle(fontSize: 19)),
                                ],
                              ),
                            ),
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.all(8),
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: _subkategori.where((element) => element['idkategori'].toString() == _kategori[index]['id'].toString()).length,
                                      itemBuilder: (BuildContext context, int indexa) {
                                        var id_subkategori = _subkategori.where((map)=>map['idkategori'].toString() == _kategori[index]['id'].toString()).elementAt(indexa).values.elementAt(0);
                                        var teks_subkategori = _subkategori.where((map)=>map['idkategori'].toString() == _kategori[index]['id'].toString()).elementAt(indexa).values.elementAt(2).toString();
                                        return Dismissible(
                                          key: Key(teks_subkategori),
                                          confirmDismiss: (direction) async {
                                            setState(() {
                                              SQLHelper.hapusSubKategori(id_subkategori);
                                              _refreshSubKategori();
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
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
                                          child: Container(
                                            height: 50,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child:
                                              Text.rich(
                                                TextSpan(
                                                  children: <TextSpan>[
                                                    TextSpan(text: teks_subkategori, style: const TextStyle(fontSize: 16)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),

                                ],
                              ),
                            ],
                          );

                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurpleAccent),
                        onPressed: () {
                          _tambahKategori(context);
                        },
                        child: const Text('Tambah'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Kembali'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          //Daftar Identitas Bank
          ExpansionTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: const Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Identitas ', style: TextStyle(fontSize: 22)),
                  TextSpan(text: 'Bank', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                ],
              ),
            ),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(children: [
                        TextField(
                          controller: _namabank,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nama Bank',
                          ),
                        ),
                        SizedBox(height: 11,),
                        TextField(
                          controller: _alamat,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Alamat Bank',
                          ),
                        ),
                        SizedBox(height: 11,),
                        TextField(
                          controller: _namalingkungan,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nama Lingkungan',
                          ),
                        ),
                        SizedBox(height: 11,),
                        TextField(
                          controller: _contactperson,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contact Person',
                          ),
                          onChanged: (value) {
                            setState(() {
                              SQLHelper.updatePengaturan(4, _contactperson.text);
                              // print(value);
                            });
                          },
                        ),


                      ]),
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurpleAccent),
                        onPressed: () {
                          _tambahNasabah(context);
                        },
                        child: const Text('Tambah'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Kembali'),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ],
      )
    )

    );
  }
}


class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SecondRoute()),
                        );
                      },
                      child: const Column(children: [
                        Icon(Icons.supervised_user_circle,
                            color: Colors.white, size: 70.0),
                        Text("Daftar Nasabah")
                      ])),
                  //Daftar kategori
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ThirdRoute()),
                        );
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


class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
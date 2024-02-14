import 'package:flutter/material.dart';
import '../database/sql_helper.dart';
import 'info.dart';

void kategori() {
  runApp(const MaterialApp(
    home: Kategori(),
    debugShowCheckedModeBanner: false,
  ));
}

class Kategori extends StatefulWidget {
  const Kategori({Key? key}) : super(key: key);

  @override
  State<Kategori> createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  List<Map<String, dynamic>> _kategori = [];
  List<Map<String, dynamic>> _subkategori = [];
  String? textkategori;

  //ambil daftar kategori
  void _refreshKategori() async {
    final data = await SQLHelper.getKategori();
    setState(() {
      _kategori = data;
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
    _refreshKategori();
    _refreshSubKategori();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Kategori",
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
                //Daftar Kategori
                ExpansionTile(
                  initiallyExpanded: true,
                  leading: const Icon(Icons.category_rounded, color: Colors.teal),
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
                                initiallyExpanded: true,
                                leading: const Icon(Icons.category_outlined, color: Colors.teal,),
                                title: Text.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: _kategori[index]['kategori'], style: const TextStyle(fontSize: 21)),
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
                                                  duration: Duration(milliseconds: 2500),
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
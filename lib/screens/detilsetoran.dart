import 'package:flutter/material.dart';
import '../database/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bantuan/bantuan.dart';
import 'screens.dart';

class DetilSetoran extends StatefulWidget {
  const DetilSetoran({Key? key, required this.nama, required this.tgl, required this.tglsetor_id}) : super(key: key);
  final String nama;
  final String tgl;
  final int tglsetor_id;
  @override
  State<DetilSetoran> createState() => _DetilSetoranState();
}
class _DetilSetoranState extends State<DetilSetoran> {
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> _DaftarKategori = [];
  List<Map<String, dynamic>> _DaftarSubKategori = [];
  List<Map<String, dynamic>> _DaftarSetoran = [];
  bool _isLoading = true;

  //nama
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  // refresh kategori
  void _refreshDaftarKategori() async {
    final data = await SQLHelper.getKategori();
    setState(() {
      _DaftarKategori = data;
      _isLoading = false;
    });
  }

  // refresh sub kategori
  void _refreshDaftarSubKategori() async {
    final datasub = await SQLHelper.getSubKategori();
    setState(() {
      _DaftarSubKategori = datasub;
      _isLoading = false;
    });
  }

  void _refreshDaftarSetoran() async {
    final datasub = await SQLHelper.getSetoran();
    setState(() {
      _DaftarSetoran = datasub;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshDaftarKategori(); // Load ketika mulai
    _refreshDaftarSubKategori(); // Load ketika mulai
    _refreshDaftarSetoran(); // Load ketika mulai
    _refreshJournals();
  }

  // Update setoran
  Future<void> _updateSetoran(int idpenyetor, int idsubkategori, int jumlah) async {
    await SQLHelper.updateSetoran(
        idpenyetor, idsubkategori, jumlah);
    _refreshDaftarKategori(); // Load ketika mulai
    _refreshDaftarSubKategori(); // Load ketika mulai
  }

  Widget build(BuildContext context) {
    String? jumlah;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          title: RichText(
            text: const TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Detil ",
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
              child: InfoDetilSetoran(),
            ))

          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.amberAccent,
          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.person),
                    onPressed: () {}
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(widget.tgl.toString()),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(40.0, 0, 0, 0), child: Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const FaIcon(FontAwesomeIcons.print,
                          color: Colors.black87),
                      onPressed: () async {
                        // generate pdf file
                        final pdfFile = await PerNasabahPDF.generate();
                        // opening the pdf file
                        FileHandleApi.openFile(pdfFile);
                      },
                    ),
                  ) ),
                ]),
        ),
        body: Center(
            child:
            ListView.builder(
              itemCount: _DaftarKategori.length,
              itemBuilder: (context, index) {
                var teks_kategori = _DaftarKategori[index]['kategori'];
                var id_kategori = _DaftarKategori[index]['id'];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Ink(
                          decoration: const ShapeDecoration(
                            color: Colors.amberAccent,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: const FaIcon(FontAwesomeIcons.recycle,
                                color: Colors.black),
                            onPressed: () {},
                          ),
                        ),
                        title:
                            Text('Kategori ${_DaftarKategori[index]['kategori']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const Divider(),
                      ListView.builder(
                        itemCount: _DaftarSubKategori.where((map) =>
                            map['idkategori'].toString() ==
                            _DaftarKategori[index]['id'].toString()).length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexa) {
                          var id_subkategori = _DaftarSubKategori.where((map) =>
                                  map['idkategori'].toString() ==
                                  _DaftarKategori[index]['id'].toString())
                              .elementAt(indexa)
                              .values
                              .elementAt(0)
                              .toString();
                          var teks_subkategori = _DaftarSubKategori.where((map) =>
                                  map['idkategori'].toString() ==
                                  _DaftarKategori[index]['id'].toString())
                              .elementAt(indexa)
                              .values
                              .elementAt(2)
                              .toString();
                          jumlah = null;
                          var list_jumlah = _DaftarSetoran.where((map) =>
                              map['idtglsetor'] == widget.tglsetor_id &&
                              map['idsubkategori'].toString() ==
                                  id_subkategori.toString());
                          if (list_jumlah.isNotEmpty) {
                            jumlah =
                                (list_jumlah.single.values.elementAt(3).toString());
                          }
                          ;
                          return ListTile(
                            title: Text(teks_subkategori),
                            trailing:

                            Container(
                              height: double.infinity,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: TextFormField(
                                  keyboardType: const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  textAlign: TextAlign.right,
                                  initialValue: jumlah,
                                  onChanged: (text) => _updateSetoran(
                                      _journals
                                          .elementAt(_DaftarSetoran.elementAt(
                                          widget.tglsetor_id)
                                          .values
                                          .elementAt(1))
                                          .values
                                          .elementAt(0),
                                      int.parse(id_subkategori),
                                      int.parse(text)),
                                ),
                              ),
                            ),




                          );
                        },
                      ),
                    ],
                  ),
                );
          },
            )

        )
    );
  }
}


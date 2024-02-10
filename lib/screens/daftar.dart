import 'package:flutter/material.dart';
import '../database/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:banksampah/widgets/select_date_time.dart';
import 'package:banksampah/screens/pdf_api.dart';
import 'package:banksampah/screens/filehandle_api.dart';

void daftarku() {
  runApp(const Daftar());
}

class Daftar extends StatelessWidget {
  const Daftar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Daftar Setoran Barang Daur Ulang',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // All journals
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> _setoran = [];
  List<Map<String, dynamic>> _jumlah = [];
  List<Map<String, dynamic>> _tglsetor = [];

  bool _isLoading = true;

  // penyetor
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  //nama2 di daftar setoran/tglsetoran
  void _refreshNamaPenyetor() async {
    final data = await SQLHelper.getSetoran();
    setState(() {
      _setoran = data;
      _isLoading = false;
    });
  }

  void _refreshJumlah() async {
    final data = await SQLHelper.getJumlah();
    setState(() {
      _jumlah = data;
      _isLoading = false;
    });
  }

  //yang di daftar setoran
  void _refreshDaftarSetoran() async {
    final data = await SQLHelper.getTglSetor();
    setState(() {
      _tglsetor = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
    _refreshJumlah();
    _refreshNamaPenyetor();
    _refreshDaftarSetoran();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController dropclicked = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {

    //buat dropdown
    final drop = _journals.map((e) => e['nama']).toList();
    dropclicked.text = drop.first;

    //cek ubah atau buat
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      int idtglsetor = _tglsetor[id].values.elementAt(1);
      dropclicked.text = _journals[_tglsetor[id].values.elementAt(1)-1]['nama'].toString();
    };

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                  DropdownButton<String>(
                    value: dropclicked.text,
                    isExpanded:true,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (value) {
                      // ini pas di klik ganti ke value baru
                      setState(() {
                        dropclicked.text = value.toString();
                      });
                    },
                    items: drop.map((data) {
                      return DropdownMenuItem(
                        value: data.toString(),
                        child: Text(
                          data,
                        ),
                      );
                    }).toList(),
                  ),
              const SizedBox(
                height: 20,
              ),
              const SelectDate(),
              ElevatedButton(
                onPressed: () async {
                  // Save new journal
                  if (id == null) {
                    await _addItem();
                  }

                  //edit masih blm bisa di disable dulu
                  if (id != null) {
                    await _updateItem(_tglsetor[id].values.elementAt(1));
                  }

                  // Clear the text fields
                  _titleController.text = '';
                  _descriptionController.text = '';

                  // Close the bottom sheet
                  if (!mounted) return;
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Buat' : 'Ubah'),
              )
            ],
          ),
        ));
  }

// Tambah tglsetor
  Future<void> _addItem() async {
     await SQLHelper.createItem(
        _journals.firstWhere((map)=>map['nama'].toString() == dropclicked.text)['id']);
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
       content: Text('Data ditambahkan!'),
       duration: const Duration(milliseconds: 1500),
     ));
    _refreshDaftarSetoran();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, dropclicked.text);
    _refreshDaftarSetoran();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Berhasil menghapus data!'),
      duration: const Duration(milliseconds: 2000),
    ));
    _refreshDaftarSetoran();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Setoran'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _showForm(null);
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.add,
                // color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _tglsetor.length,
        itemBuilder: (context, index) => Card(
          color: Colors.orange,
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(_journals[_tglsetor[index].values.elementAt(1)-1]['nama']),
              subtitle: Text(_tglsetor[index]['createdAt'].toString()),
              trailing: SizedBox(
                child: Wrap(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.list),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(nama: _journals[index]['nama'], tglsetor_id: _tglsetor[index]['id']),
                          ),
                        );
                      },
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.edit),
                    //   onPressed: () => _showForm(_tglsetor[index].values.elementAt(0)-1),
                    // ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                        _deleteItem(int.parse(_tglsetor[index]['id'].toString()))
                        ,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.nama, required this.tglsetor_id}) : super(key: key);
  final String nama;
  final int tglsetor_id;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> {
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
        title: Text('Detil Setoran'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.print,
              color: Colors.white,
            ),
            onPressed: () async {
              // generate pdf file
              final pdfFile = await PerNasabahPDF.generate();
              // opening the pdf file
              FileHandleApi.openFile(pdfFile);
            },
          )
        ],
        centerTitle: true,
        ),
      body: Center(
        child:
        ListView.builder(
        itemCount: _DaftarKategori.length,
        itemBuilder: (context, index) {
          var teks_kategori = _DaftarKategori[index]['kategori'];
          var id_kategori = _DaftarKategori[index]['id'];
          return Card(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  leading: Material(
                    child: Ink(decoration: const ShapeDecoration(color: Colors.black26, shape: CircleBorder(),),
                      child: IconButton(icon: const FaIcon(FontAwesomeIcons.recycle, color: Colors.white), onPressed: () {},),
                    ),
                  ),
                      title: Text('Kategori ${_DaftarKategori[index]['kategori']}'),
                ),
                const Divider(),
                ListView.builder(
                  itemCount: _DaftarSubKategori.where((map)=>map['idkategori'].toString() == _DaftarKategori[index]['id'].toString()).length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, indexa) {
                    var id_subkategori = _DaftarSubKategori.where((map)=>map['idkategori'].toString() == _DaftarKategori[index]['id'].toString()).elementAt(indexa).values.elementAt(0).toString();
                    var teks_subkategori = _DaftarSubKategori.where((map)=>map['idkategori'].toString() == _DaftarKategori[index]['id'].toString()).elementAt(indexa).values.elementAt(2).toString();
                    jumlah = null;
                    var list_jumlah = _DaftarSetoran.where((map)=>map['idtglsetor'] == widget.tglsetor_id && map['idsubkategori'].toString() == id_subkategori.toString());
                    if(list_jumlah.isNotEmpty){
                      jumlah = (list_jumlah.single.values.elementAt(3).toString());
                    };
                    return ListTile(
                      title: Text(teks_subkategori),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.right,
                          initialValue: jumlah,
                          onChanged: (text) =>_updateSetoran(_journals.elementAt(_DaftarSetoran.elementAt(widget.tglsetor_id).values.elementAt(1)).values.elementAt(0), int.parse(id_subkategori), int.parse(text)),
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


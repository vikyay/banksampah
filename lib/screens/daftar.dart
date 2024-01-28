import 'package:flutter/material.dart';
import 'sql_helper.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
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

  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
      _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }

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
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Nama'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Catatan'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Save new journal
                  if (id == null) {
                    await _addItem();
                  }

                  if (id != null) {
                    await _updateItem(id);
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

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Berhasil menghapus data!'),
    ));
    _refreshJournals();
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
        itemCount: _journals.length,
        itemBuilder: (context, index) => Card(
          color: Colors.orange,
          margin: const EdgeInsets.all(15),
          child: ListTile(
              title: Text(_journals[index]['title']),
              subtitle: Text(_journals[index]['description']),
              trailing: SizedBox(
                child: Wrap(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.list),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(title: _journals[index]['title']),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showForm(_journals[index]['id']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _deleteItem(_journals[index]['id']),
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
  const DetailScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> {
  List<Map<String, dynamic>> _DaftarKategori = [];
  List<Map<String, dynamic>> _DaftarSubKategori = [];
  List<Map<String, dynamic>> _DaftarSetoran = [];
  bool _isLoading = true;
  // refresh kategori
  void _refreshDaftarKategori() async {
    final datakat = await SQLHelper.getKategori();
    setState(() {
      _DaftarKategori = datakat;
      _isLoading = false;
    });
  }

  // refresh sub kategori
  void _refreshDaftarSubKategori() async {
    final datasub = await SQLHelper.getSetoran();
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
  }

  // Update setoran
  Future<void> _updateSetoran(int idpenyetor, int idsubkategori, int jumlah) async {
    await SQLHelper.updateSetoran(
        idpenyetor, idsubkategori, jumlah);
  }

  Widget build(BuildContext context) {
    Map<String, dynamic> _controller = new Map();
    return Scaffold(
      appBar: AppBar(
        title: Text('Isi jumlah setoran'),
        centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'Balik',
              icon: const FaIcon(FontAwesomeIcons.floppyDisk),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      body: Center(
        child:
        ListView.builder(
        itemCount: _DaftarKategori.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  leading: Material(
                    child: Ink(decoration: const ShapeDecoration(color: Colors.lightBlue,shape: CircleBorder(),),
                      child: IconButton(icon: const FaIcon(FontAwesomeIcons.trash, color: Colors.white), onPressed: () {},),
                    ),
                  ),
                      title: Text('Kategori ${_DaftarKategori[index]['kategori']}'),
                ),
                const Divider(),
                ListView.builder(
                  itemCount: _DaftarSubKategori.where((map)=>map['idkategori'].toString().contains(_DaftarKategori[index]['id'].toString())).length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, indexa) {
                    _controller.putIfAbsent('teks${_DaftarSubKategori[indexa]['id']}',
                            () => new TextEditingController());
                    return ListTile(
                      title: Text(_DaftarSubKategori.where((map)=>map['idkategori'].toString().contains(_DaftarKategori[index]['id'].toString())).elementAt(indexa).values.elementAt(2).toString()),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.right,
                          controller: _controller[indexa.toInt()+1],
                          initialValue: '0',
                          if(_DaftarSetoran.[indexa]){}

                          onChanged: (text) =>_updateSetoran(1, _DaftarSubKategori.where((map)=>map['idkategori'].toString().contains(_DaftarKategori[index]['id'].toString())).elementAt(indexa).values.elementAt(0), int.parse(text)),
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


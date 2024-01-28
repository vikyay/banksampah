import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KategoriBarang extends ConsumerStatefulWidget {
  static KategoriBarang builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const KategoriBarang();
  const KategoriBarang({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KategoriBarangState();
}

class _KategoriBarangState extends ConsumerState<KategoriBarang> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kategori Barang'),

        ),
        bottomNavigationBar:

        BottomAppBar(
          color: Colors.blue,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  tooltip: 'Balik',
                  icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                  onPressed: () => Navigator.of(context).pop(),
                ),

                IconButton(
                  tooltip: 'Search',
                  icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                  onPressed: () {},
                ),

                IconButton(
                  tooltip: 'Selesai',
                  icon: const FaIcon(FontAwesomeIcons.check),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),

        body: ListsWithCards(),

      ),
    );
  }
}

class ListsWithCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data for three lists
    List<List<String>> judulKat = [['Metal', 'Besi', 'Tembaga', 'Aluminium', 'Tembaga', 'Babet/Kran', 'Kaleng', 'Seng/Kawat']];
    List<List<String>> isiKat = [['Metal', 'Besi', 'Tembaga', 'Aluminium', 'Tembaga', 'Babet/Kran', 'Kaleng', 'Seng/Kawat']];

    List<List<String>> listsData = [
      ['Metal', 'Besi', 'Tembaga', 'Aluminium', 'Tembaga', 'Babet/Kran', 'Kaleng', 'Seng/Kawat'],
      ['Plastik', 'PE (Plastik Putih)', 'PVC (Paralon)', 'Asoy (Plastik Bekas)', 'Botol Putih (Bodong Bersih)', 'Botol Warna (Bodong Warna)', 'Gelas Mineral (Bersih)', 'Gelas Mineral (Kotor)', 'Gelas Mineral (Warna)', 'Tutup Botol', 'Tutup Galon', 'Emberan', 'Kabin', 'Botol Kotor', 'Ember Hitam/Pot'],
      ['Kertas', 'Putihan/HVS', 'Majalah', 'Buku Kotor', 'Koran', 'Karton/Boncos', 'Kardus', 'Duplek', 'Karung Semen', 'Kertas Buram'],
      ['Beling/Kaca', 'Botol/Beling', 'Beling Pecah'],
      ['Akrilik', 'Kristal', 'Keping CD/DVD', 'Toples Tipis'],
      ['Fiber', 'Galon LeMinerale'],
      ['Styrofoam', 'Styrofoam'],
      ['Jelantah', 'Jelantah'],
      ['Sepatu', 'Sepatu'],
      ['Aki Mobil', 'Aki Mobil'],
      ['Karpet', 'Karpet'],
      ['Impact', 'Impact'],
    ];
    // List judul=listsData.removeAt(2);
    // List isi=listsData..removeAt(listsData.length-1);

    return ListView.builder(
      itemCount: listsData.length,
      itemBuilder: (context, index) {
        return CardList(listData: listsData[index]
        );
      },
    );
  }
}

class CardList extends StatelessWidget {
  final List<String> listData;
  const CardList({required this.listData});

  @override
  Widget build(BuildContext context) {
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
            trailing: IconButton(icon: const FaIcon(FontAwesomeIcons.pencil), onPressed: () {},),
            title: Text('Kategori ${listData[0]}'),
          ),
          const Divider(),
          ListView.builder(
            itemCount: listData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listData[index]),
                trailing: IconButton(icon: const FaIcon(FontAwesomeIcons.pencil), onPressed: () {},),
              );
            },
          ),
        ],
      ),
    );
  }
}

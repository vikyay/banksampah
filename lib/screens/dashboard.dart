import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens.dart';
import 'package:banksampah/database/sql_helper.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardDetail(),
    );
  }
}




class DashboardDetailx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Color(0xFF399D63)),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'APLIKASI BANK SAMPAH',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8AC7A4)),
                    ),
                    const Text(
                      'CSJ',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 41.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'LINGKUNGAN',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8AC7A4)),
                    ),
                    const Text(
                      'CSJ Ciputat Tangsel',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'TAHUN',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8AC7A4)),
                    ),
                    const Text(
                      '2024',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white),
                      child: const Center(
                        child: Icon(Icons.home, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height / 2) - 185.0,
                left: (MediaQuery.of(context).size.width / 2) - 25.0,
                child: const Image(
                  image: AssetImage('assets/trashcan.png'),
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height - 360.0,
                      left: 20.0,
                      right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const DaftarSetoran()),
                            );
                          },
                          splashColor: Colors.lightGreen,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.list_alt_rounded, size: 50.0, color: Colors.green),
                                title: Text('Daftar Setoran'),
                                subtitle: Text('Lihat daftar setoran berdasarkan nama'),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Kategori()),
                            );
                          },
                          splashColor: Colors.green,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.category_rounded, size: 50.0, color: Colors.green),
                                title: Text('Kategori'),
                                subtitle: Text('Lihat dan atur kategori barang'),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Laporan()),
                            );
                          },
                          splashColor: Colors.green,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.document_scanner, size: 50.0, color: Colors.green),
                                title: Text('Laporan'),
                                subtitle: Text('Buat laporan hasil kegiatan'),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SecondRoute()),
                            );
                          },
                          splashColor: Colors.green,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.settings, size: 50.0, color: Colors.green),
                                title: Text('Pengaturan'),
                                subtitle: Text('Ubah pengaturan aplikasi'),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}


class DashboardDetail extends StatefulWidget {
  const DashboardDetail({Key? key}) : super(key: key);

  @override
  State<DashboardDetail> createState() => _DashboardDetailState();
}

class _DashboardDetailState extends State<DashboardDetail> {
  List<Map<String, dynamic>> _pengaturan = [];
  //ambil daftar nama
  void _refreshPengaturan() async {
    final data = await SQLHelper.getPengaturan();
    setState(() {
      _pengaturan = data;
    });
  }
  @override
  void initState() {
    super.initState();
    //load ketika mulai
    _refreshPengaturan();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Color(0xFF399D63)),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'APLIKASI BANK SAMPAH',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8AC7A4)),
                    ),
                    Text(
                      _pengaturan[0].values.elementAt(2).toString(),
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 41.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'LINGKUNGAN',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8AC7A4)),
                    ),
                    Text(
                      _pengaturan[2].values.elementAt(2).toString(),
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'TAHUN',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8AC7A4)),
                    ),
                    Text(
                      DateTime.now().year.toString(),
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white),
                      child: const Center(
                        child: Icon(Icons.home, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height / 2) - 185.0,
                left: (MediaQuery.of(context).size.width / 2) - 25.0,
                child: const Image(
                  image: AssetImage('assets/trashcan.png'),
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height - 360.0,
                      left: 20.0,
                      right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const DaftarSetoran()),
                            );
                          },
                          splashColor: Colors.lightGreen,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.list_alt_rounded, size: 50.0, color: Colors.green),
                                title: Text('Daftar Setoran'),
                                subtitle: Text('Lihat daftar setoran berdasarkan nama'),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Kategori()),
                            );
                          },
                          splashColor: Colors.green,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.category_rounded, size: 50.0, color: Colors.green),
                                title: Text('Kategori'),
                                subtitle: Text('Lihat dan atur kategori barang'),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Laporan()),
                            );
                          },
                          splashColor: Colors.green,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.document_scanner, size: 50.0, color: Colors.green),
                                title: Text('Laporan'),
                                subtitle: Text('Buat laporan hasil kegiatan'),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SecondRoute()),
                            );
                          },
                          splashColor: Colors.green,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.settings, size: 50.0, color: Colors.green),
                                title: Text('Pengaturan'),
                                subtitle: Text('Ubah pengaturan aplikasi'),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
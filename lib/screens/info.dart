import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoDetilSetoran extends StatelessWidget {
  const InfoDetilSetoran({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.info,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                    offset: Offset(0, 1))
              ]),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Menu', style: TextStyle(fontSize: 16)),
                          TextSpan(text: ' Detil Setoran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Berisi daftar kategori setoran nasabah berikut'),
                          TextSpan(text: ' jumlah ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'setorannya'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(
                            text: "Tekan tombol print (",
                          ),
                          WidgetSpan(
                            child: Icon(Icons.print, size: 14),
                          ),
                          TextSpan(
                            text: ") di kanan bawah untuk mencetak setoran",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),


        // TextButton(
        //   onPressed: () => showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => Dialog(
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: <Widget>[
        //             const Text('This is a typical dialog.'),
        //             const SizedBox(height: 15),
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //               child: const Text('Close'),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        //   child: const Text('Show Dialog'),
        // ),
        // const SizedBox(height: 10),
        // TextButton(
        //   onPressed: () => showDialog<String>(
        //     context: context,
        //     builder: (BuildContext context) => Dialog.fullscreen(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           const Text('This is a fullscreen dialog.'),
        //           const SizedBox(height: 15),
        //           TextButton(
        //             onPressed: () {
        //               Navigator.pop(context);
        //             },
        //             child: const Text('Close'),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        //   child: const Text('Show Fullscreen Dialog'),
        // ),
      ],
    );
  }
}

class InfoDaftarSetoran extends StatelessWidget {
  const InfoDaftarSetoran({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.info,
              color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                  offset: Offset(0, 1))
            ],
          ),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Menu', style: TextStyle(fontSize: 16)),
                          TextSpan(text: ' Daftar Setoran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Berisi daftar setoran sampah dari nasabah'),
                          TextSpan(text: ' Bank Sampah', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Pilih tombol '),
                          TextSpan(text: ' (+)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          TextSpan(text: ' di bawah untuk menambahkan setoran baru'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Geser setoran kekanan untuk'),
                          TextSpan(text: ' menghapus ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: 'setoran'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Pilih setoran untuk melihat'),
                          TextSpan(text: ' detil ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'dan mencetak daftarnya'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoPengaturan extends StatelessWidget {
  const InfoPengaturan({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.info,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                    offset: Offset(0, 1))
              ]),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Menu Pengaturan'),
                    const SizedBox(height: 15),
                    const Text('Berisi menu-menu untuk mengatur dan konfigurasi sistem pada program'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoKategori extends StatelessWidget {
  const InfoKategori({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.info,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                    offset: Offset(0, 1))
              ]),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Menu Kategori'),
                    const SizedBox(height: 15),
                    const Text('Berisi daftar kategori dan sub kategorinya.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class InfoLaporan extends StatelessWidget {
  const InfoLaporan({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.info,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                  offset: Offset(0, 1))
            ],
          ),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.right,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Menu', style: TextStyle(fontSize: 16)),
                          TextSpan(text: ' Buat Laporan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Berisi menu-menu untuk membuat laporan dan info setoran'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(text: 'Laporan dapat diatur per nasabah, per kategori, per bulan, atau kombinasi ketiganya'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: '',
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(
                            text: "Laporan akan terbentuk menjadi berkas PDF ",
                          ),
                          WidgetSpan(
                            child: Icon(Icons.picture_as_pdf, size: 18),
                          ),
                          TextSpan(
                            text: " yang bisa dibagikan, diunggah, disimpan, dan dicetak sesuai kebutuhan",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

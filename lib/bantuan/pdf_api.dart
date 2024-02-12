import 'dart:io';
import 'package:flutter/services.dart';
import 'filehandle_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class PdfInvoiceApi {
  static Future<File> generate() async {
    final pdf = pw.Document();

    final iconImage =
    (await rootBundle.load('assets/icon.png')).buffer.asUint8List();

    final tableHeaders = [
      'Jenis',
      'Kategori',
      'Satuan',
      'Jumlah',
      'Total',
    ];

    final tableData = [
      ['Besi', 'Metal', 'gram', '0', '0',],
      ['Aluminium', 'Metal', 'gram', '2300', '11000',],
      ['Tembaga', 'Metal', 'gram', '0', '0',],
      ['Babet/Kran', 'Metal', 'gram', '0', '0',],
      ['Kaleng', 'Metal', 'gram', '6000', '2000',],
      ['Seng/Kawat', 'Metal', 'gram', '0', '1000',],
      ['PE (Plastik Putih)', 'Plastik', 'gram', '0', '0',],
      ['PVC (Paralon)', 'Plastik', 'gram', '0', '0',],
      ['Asoy (Plastik Bekas)', 'Plastik', 'gram', '8000', '250',],
      ['Botol Putih (Bodong Bersih)', 'Plastik', 'gram', '0', '3500',],
      ['Botol Warna (Bodong Warna)', 'Plastik', 'gram', '0', '900',],
      ['Gelas Mineral (Bersih)', 'Plastik', 'gram', '0', '0',],
      ['Gelas Mineral (Kotor)', 'Plastik', 'gram', '0', '0',],
      ['Gelas Mineral (Warna)', 'Plastik', 'gram', '0', '0',],
      ['Tutup Botol', 'Plastik', 'gram', '3000', '2500',],
      ['Tutup Galon', 'Plastik', 'gram', '4000', '4000',],
      ['Emberan', 'Plastik', 'gram', '3000', '1500',],
      ['Kabin', 'Plastik', 'gram', '0', '0',],
      ['Botol Kotor', 'Plastik', 'gram', '0', '0',],
      ['Ember Hitam/Pot', 'Plastik', 'gram', '0', '0',],
      ['Putihan/HVS', 'Kertas', 'gram', '12500', '1600',],
      ['Majalah', 'Kertas', 'gram', '0', '0',],
      ['Buku Kotor', 'Kertas', 'gram', '0', '1200',],
      ['Koran', 'Kertas', 'gram', '0', '0',],
      ['Karton/Boncos', 'Kertas', 'gram', '1200', '400',],
      ['Kardus', 'Kertas', 'gram', '4000', '1200',],
      ['Duplek', 'Kertas', 'gram', '0', '0',],
      ['Karung Semen', 'Kertas', 'gram', '0', '0',],
      ['Kertas Buram', 'Kertas', 'gram', '0', '0',],
      ['Botol/Beling', 'Plastik', 'gram', '7500', '250',],
      ['Beling Pecah', 'Plastik', 'gram', '0', '0',],
      ['Kristal', 'Plastik', 'gram', '0', '3000',],
      ['Keping CD/DVD', 'Plastik', 'gram', '0', '0',],
      ['Toples Tipis', 'Plastik', 'gram', '0', '0',],
      ['Galon LeMinerale', 'Plastik', 'gram', '0', '2800',],
      ['Styrofoam', 'Plastik', 'gram', '0', '0',],
      ['Jelantah', 'Plastik', 'gram', '16100', '5500',],
      ['Sepatu', 'Plastik', 'gram', '0', '0',],
      ['Aki Mobil', 'Plastik', 'gram', '0', '0',],
      ['Aki Motor', 'Plastik', 'gram', '0', '0',],
      ['Karpet', 'Plastik', 'gram', '0', '0',],
      ['Impact', 'Plastik', 'gram', '0', '0',],
    ];

    pdf.addPage(
      pw.MultiPage(
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'BANK SAMPAH',
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Laporan Kegiatan',
                      style: const pw.TextStyle(
                        fontSize: 15.0,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.Text(
                      'Periode Januari 2024',
                      style: const pw.TextStyle(
                        fontSize: 12.0,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Cluster Jombang Sudimara',
                      style: pw.TextStyle(
                        fontSize: 15.5,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Jalan Betawi, Kelurahan Jombang,\nKecamatan Ciputat, Kota Tangerang Selatan',
                    ),
                    pw.Text(
                      DateTime.now().toString(),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.TableHelper.fromTextArray(
              headers: tableHeaders,
              data: tableData,
              border: null,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
              const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30.0,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
              },
            ),
            pw.Divider(),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // pw.Row(
                        //   children: [
                        //     pw.Expanded(
                        //       child: pw.Text(
                        //         'Net total',
                        //         style: pw.TextStyle(
                        //           fontWeight: pw.FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     pw.Text(
                        //       '\$ 464',
                        //       style: pw.TextStyle(
                        //         fontWeight: pw.FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // pw.Row(
                        //   children: [
                        //     pw.Expanded(
                        //       child: pw.Text(
                        //         'Vat 19.5 %',
                        //         style: pw.TextStyle(
                        //           fontWeight: pw.FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     pw.Text(
                        //       '\$ 90.48',
                        //       style: pw.TextStyle(
                        //         fontWeight: pw.FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // pw.Divider(),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Total ',
                                style: pw.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Text(
                              'Rp 368.500',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                        pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              // pw.SizedBox(height: 2 * PdfPageFormat.mm),
              // pw.Text(
              //   'Flutter Approach',
              //   style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              // ),
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.center,
              //   children: [
              //     pw.Text(
              //       'Address: ',
              //       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              //     ),
              //     pw.Text(
              //       'Merul Badda, Anandanagor, Dhaka 1212',
              //     ),
              //   ],
              // ),
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.center,
              //   children: [
              //     pw.Text(
              //       'Email: ',
              //       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              //     ),
              //     pw.Text(
              //       'flutterapproach@gmail.com',
              //     ),
              //   ],
              // ),
            ],
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'banksampah.pdf', pdf: pdf);
  }
}

class PerNasabahPDF {
  static Future<File> generate(List<List<dynamic>> daftardata, num total, nama, tgl) async {
    // print(daftardata);
    final pdf = pw.Document();

    final iconImage =
    (await rootBundle.load('assets/icon.png')).buffer.asUint8List();

    final tableHeaders = [
      'Jenis',
      'Kategori',
      'Satuan',
      'Jumlah',
      'Total',
    ];

    final tableDataASLI = [
      ['Besi', 'Metal', 'gram', '0', '0',],
      ['Aluminium', 'Metal', 'gram', '2300', '11000',],
      ['Tembaga', 'Metal', 'gram', '0', '0',],
      ['Babet/Kran', 'Metal', 'gram', '0', '0',],
      ['Kaleng', 'Metal', 'gram', '6000', '2000',],
      ['Seng/Kawat', 'Metal', 'gram', '0', '1000',],
      ['PE (Plastik Putih)', 'Plastik', 'gram', '0', '0',],
      ['PVC (Paralon)', 'Plastik', 'gram', '0', '0',],
      ['Asoy (Plastik Bekas)', 'Plastik', 'gram', '8000', '250',],
      ['Botol Putih (Bodong Bersih)', 'Plastik', 'gram', '0', '3500',],
      ['Botol Warna (Bodong Warna)', 'Plastik', 'gram', '0', '900',],
      ['Gelas Mineral (Bersih)', 'Plastik', 'gram', '0', '0',],
      ['Gelas Mineral (Kotor)', 'Plastik', 'gram', '0', '0',],
      ['Gelas Mineral (Warna)', 'Plastik', 'gram', '0', '0',],
      ['Tutup Botol', 'Plastik', 'gram', '3000', '2500',],
      ['Tutup Galon', 'Plastik', 'gram', '4000', '4000',],
      ['Emberan', 'Plastik', 'gram', '3000', '1500',],
      ['Kabin', 'Plastik', 'gram', '0', '0',],
      ['Botol Kotor', 'Plastik', 'gram', '0', '0',],
      ['Ember Hitam/Pot', 'Plastik', 'gram', '0', '0',],
      ['Putihan/HVS', 'Kertas', 'gram', '12500', '1600',],
      ['Majalah', 'Kertas', 'gram', '0', '0',],
      ['Buku Kotor', 'Kertas', 'gram', '0', '1200',],
      ['Koran', 'Kertas', 'gram', '0', '0',],
      ['Karton/Boncos', 'Kertas', 'gram', '1200', '400',],
      ['Kardus', 'Kertas', 'gram', '4000', '1200',],
      ['Duplek', 'Kertas', 'gram', '0', '0',],
      ['Karung Semen', 'Kertas', 'gram', '0', '0',],
      ['Kertas Buram', 'Kertas', 'gram', '0', '0',],
      ['Botol/Beling', 'Plastik', 'gram', '7500', '250',],
      ['Beling Pecah', 'Plastik', 'gram', '0', '0',],
      ['Kristal', 'Plastik', 'gram', '0', '3000',],
      ['Keping CD/DVD', 'Plastik', 'gram', '0', '0',],
      ['Toples Tipis', 'Plastik', 'gram', '0', '0',],
      ['Galon LeMinerale', 'Plastik', 'gram', '0', '2800',],
      ['Styrofoam', 'Plastik', 'gram', '0', '0',],
      ['Jelantah', 'Plastik', 'gram', '16100', '5500',],
      ['Sepatu', 'Plastik', 'gram', '0', '0',],
      ['Aki Mobil', 'Plastik', 'gram', '0', '0',],
      ['Aki Motor', 'Plastik', 'gram', '0', '0',],
      ['Karpet', 'Plastik', 'gram', '0', '0',],
      ['Impact', 'Plastik', 'gram', '0', '0',],
    ];
    final tableData = [
    ['Besi', 'Metal', 'gram', '0', '0',],
    ['Aluminium', 'Metal', 'gram', '230', '2530',],
    ['Tembaga', 'Metal', 'gram', '0', '0',],
    ['Babet/Kran', 'Metal', 'gram', '0', '0',],
    ['Kaleng', 'Metal', 'gram', '120', '240',],
    ['Seng/Kawat', 'Metal', 'gram', '0', '0',],
    ['PE (Plastik Putih)', 'Plastik', 'gram', '0', '0',],
    ['PVC (Paralon)', 'Plastik', 'gram', '0', '2530',],
    ['Asoy (Plastik Bekas)', 'Plastik', 'gram', '0', '0',],
    ['Botol Putih (Bodong Bersih)', 'Plastik', 'gram', '340', '0',],
    ['Botol Warna (Bodong Warna)', 'Plastik', 'gram', '210', '240',],
    ['Gelas Mineral (Bersih)', 'Plastik', 'gram', '0', '0',],
    ['Gelas Mineral (Kotor)', 'Plastik', 'gram', '0', '0',],
    ['Gelas Mineral (Warna)', 'Plastik', 'gram', '0', '0',],
    ['Tutup Botol', 'Plastik', 'gram', '160', '0',],
    ['Tutup Galon', 'Plastik', 'gram', '180', '1190',],
    ['Emberan', 'Plastik', 'gram', '0', '189',],
    ['Kabin', 'Plastik', 'gram', '0', '0',],
    ['Botol Kotor', 'Plastik', 'gram', '0', '0',],
    ['Ember Hitam/Pot', 'Plastik', 'gram', '0', '0',],
    ['Putihan/HVS', 'Kertas', 'gram', '2370', '0',],
    ['Majalah', 'Kertas', 'gram', '0', '2530',],
    ['Buku Kotor', 'Kertas', 'gram', '0', '0',],
    ['Koran', 'Kertas', 'gram', '0', '0',],
    ['Karton/Boncos', 'Kertas', 'gram', '1200', '240',],
    ['Kardus', 'Kertas', 'gram', '400', '0',],
    ['Duplek', 'Kertas', 'gram', '0', '0',],
    ['Karung Semen', 'Kertas', 'gram', '0', '0',],
    ['Kertas Buram', 'Kertas', 'gram', '0', '0',],
    ['Botol/Beling', 'Plastik', 'gram', '900', '0',],
    ['Beling Pecah', 'Plastik', 'gram', '0', '2530',],
    ['Kristal', 'Plastik', 'gram', '0', '0',],
    ['Keping CD/DVD', 'Plastik', 'gram', '0', '2530',],
    ['Toples Tipis', 'Plastik', 'gram', '0', '0',],
    ['Galon LeMinerale', 'Plastik', 'gram', '460', '0',],
    ['Styrofoam', 'Plastik', 'gram', '0', '0',],
    ['Jelantah', 'Plastik', 'gram', '3960', '0',],
    ['Sepatu', 'Plastik', 'gram', '0', '0',],
    ['Aki Mobil', 'Plastik', 'gram', '0', '0',],
    ['Aki Motor', 'Plastik', 'gram', '0', '2530',],
    ['Karpet', 'Plastik', 'gram', '0', '0',],
    ['Impact', 'Plastik', 'gram', '0', '0',],
    ];
    final tableData2 = [
      ['Besi', 'Metal', 'gram', '0', '0',],
      ['Aluminium', 'Metal', 'gram', '0', '0',],
      ['Tembaga', 'Metal', 'gram', '0', '0',],
      ['Babet/Kran', 'Metal', 'gram', '0', '0',],
      ['Kaleng', 'Metal', 'gram', '1500', '3000',],
      ['Seng/Kawat', 'Metal', 'gram', '0', '0',],
      ['PE (Plastik Putih)', 'Plastik', 'gram', '0', '0',],
      ['PVC (Paralon)', 'Plastik', 'gram', '0', '0',],
      ['Asoy (Plastik Bekas)', 'Plastik', 'gram', '0', '0',],
      ['Botol Putih (Bodong Bersih)', 'Plastik', 'gram', '200', '0',],
      ['Botol Warna (Bodong Warna)', 'Plastik', 'gram', '1150', '3000',],
      ['Gelas Mineral (Bersih)', 'Plastik', 'gram', '0', '0',],
      ['Gelas Mineral (Kotor)', 'Plastik', 'gram', '0', '0',],
      ['Gelas Mineral (Warna)', 'Plastik', 'gram', '0', '0',],
      ['Tutup Botol', 'Plastik', 'gram', '300', '0',],
      ['Tutup Galon', 'Plastik', 'gram', '100', '700',],
      ['Emberan', 'Plastik', 'gram', '0', '1035',],
      ['Kabin', 'Plastik', 'gram', '0', '0',],
      ['Botol Kotor', 'Plastik', 'gram', '0', '0',],
      ['Ember Hitam/Pot', 'Plastik', 'gram', '0', '0',],
      ['Putihan/HVS', 'Kertas', 'gram', '2370', '0',],
      ['Majalah', 'Kertas', 'gram', '0', '0',],
      ['Buku Kotor', 'Kertas', 'gram', '0', '0',],
      ['Koran', 'Kertas', 'gram', '0', '0',],
      ['Karton/Boncos', 'Kertas', 'gram', '1200', '3000',],
      ['Kardus', 'Kertas', 'gram', '400', '0',],
      ['Duplek', 'Kertas', 'gram', '0', '0',],
      ['Karung Semen', 'Kertas', 'gram', '0', '0',],
      ['Kertas Buram', 'Kertas', 'gram', '0', '0',],
      ['Botol/Beling', 'Plastik', 'gram', '900', '0',],
      ['Beling Pecah', 'Plastik', 'gram', '0', '0',],
      ['Kristal', 'Plastik', 'gram', '0', '0',],
      ['Keping CD/DVD', 'Plastik', 'gram', '0', '0',],
      ['Toples Tipis', 'Plastik', 'gram', '0', '0',],
      ['Galon LeMinerale', 'Plastik', 'gram', '460', '0',],
      ['Styrofoam', 'Plastik', 'gram', '0', '0',],
      ['Jelantah', 'Plastik', 'gram', '3960', '0',],
      ['Sepatu', 'Plastik', 'gram', '0', '0',],
      ['Aki Mobil', 'Plastik', 'gram', '0', '0',],
      ['Aki Motor', 'Plastik', 'gram', '0', '0',],
      ['Karpet', 'Plastik', 'gram', '0', '0',],
      ['Impact', 'Plastik', 'gram', '0', '0',],
    ];
    final tableData3 = [
      ['Besi', 'Metal', 'gram', '0', '0',],
      ['Aluminium', 'Metal', 'gram', '0', '0',],
      ['Tembaga', 'Metal', 'gram', '0', '0',],
      ['Babet/Kran', 'Metal', 'gram', '0', '0',],
      ['Kaleng', 'Metal', 'gram', '0', '0',],
      ['Seng/Kawat', 'Metal', 'gram', '0', '0',],
      ['PE (Plastik Putih)', 'Plastik', 'gram', '0', '0',],
      ['PVC (Paralon)', 'Plastik', 'gram', '0', '0',],
      ['Asoy (Plastik Bekas)', 'Plastik', 'gram', '0', '0',],
      ['Botol Putih (Bodong Bersih)', 'Plastik', 'gram', '1210', '0',],
      ['Botol Warna (Bodong Warna)', 'Plastik', 'gram', '1230', '0',],
      ['Gelas Mineral (Bersih)', 'Plastik', 'gram', '0', '0',],
      ['Gelas Mineral (Kotor)', 'Plastik', 'gram', '0', '0',],
      ['Gelas Mineral (Warna)', 'Plastik', 'gram', '0', '0',],
      ['Tutup Botol', 'Plastik', 'gram', '250', '0',],
      ['Tutup Galon', 'Plastik', 'gram', '320', '4235',],
      ['Emberan', 'Plastik', 'gram', '0', '1107',],
      ['Kabin', 'Plastik', 'gram', '0', '0',],
      ['Botol Kotor', 'Plastik', 'gram', '0', '0',],
      ['Ember Hitam/Pot', 'Plastik', 'gram', '0', '0',],
      ['Putihan/HVS', 'Kertas', 'gram', '6950', '0',],
      ['Majalah', 'Kertas', 'gram', '0', '0',],
      ['Buku Kotor', 'Kertas', 'gram', '0', '0',],
      ['Koran', 'Kertas', 'gram', '4420', '0',],
      ['Karton/Boncos', 'Kertas', 'gram', '0', '0',],
      ['Kardus', 'Kertas', 'gram', '0', '0',],
      ['Duplek', 'Kertas', 'gram', '0', '0',],
      ['Karung Semen', 'Kertas', 'gram', '0', '0',],
      ['Kertas Buram', 'Kertas', 'gram', '0', '0',],
      ['Botol/Beling', 'Plastik', 'gram', '0', '0',],
      ['Beling Pecah', 'Plastik', 'gram', '0', '0',],
      ['Kristal', 'Plastik', 'gram', '0', '0',],
      ['Keping CD/DVD', 'Plastik', 'gram', '0', '0',],
      ['Toples Tipis', 'Plastik', 'gram', '0', '0',],
      ['Galon LeMinerale', 'Plastik', 'gram', '3210', '0',],
      ['Styrofoam', 'Plastik', 'gram', '0', '0',],
      ['Jelantah', 'Plastik', 'gram', '2550', '0',],
      ['Sepatu', 'Plastik', 'gram', '0', '0',],
      ['Aki Mobil', 'Plastik', 'gram', '0', '0',],
      ['Aki Motor', 'Plastik', 'gram', '0', '0',],
      ['Karpet', 'Plastik', 'gram', '0', '0',],
      ['Impact', 'Plastik', 'gram', '0', '0',],
    ];
    final tableData4 = [
     ['Besi', 'Metal', 'gram', '0', '0',],
     ['Aluminium', 'Metal', 'gram', '0', '0',],
     ['Tembaga', 'Metal', 'gram', '0', '0',],
     ['Babet/Kran', 'Metal', 'gram', '0', '0',],
     ['Kaleng', 'Metal', 'gram', '0', '0',],
     ['Seng/Kawat', 'Metal', 'gram', '0', '0',],
     ['PE (Plastik Putih)', 'Plastik', 'gram', '0', '0',],
     ['PVC (Paralon)', 'Plastik', 'gram', '0', '0',],
     ['Asoy (Plastik Bekas)', 'Plastik', 'gram', '0', '0',],
     ['Botol Putih (Bodong Bersih)', 'Plastik', 'gram', '0', '0',],
     ['Botol Warna (Bodong Warna)', 'Plastik', 'gram', '0', '0',],
     ['Gelas Mineral (Bersih)', 'Plastik', 'gram', '0', '0',],
     ['Gelas Mineral (Kotor)', 'Plastik', 'gram', '0', '0',],
     ['Gelas Mineral (Warna)', 'Plastik', 'gram', '0', '0',],
     ['Tutup Botol', 'Plastik', 'gram', '0', '0',],
     ['Tutup Galon', 'Plastik', 'gram', '0', '0',],
     ['Emberan', 'Plastik', 'gram', '0', '0',],
     ['Kabin', 'Plastik', 'gram', '0', '0',],
     ['Botol Kotor', 'Plastik', 'gram', '0', '0',],
     ['Ember Hitam/Pot', 'Plastik', 'gram', '0', '0',],
     ['Putihan/HVS', 'Kertas', 'gram', '0', '0',],
     ['Majalah', 'Kertas', 'gram', '0', '0',],
     ['Buku Kotor', 'Kertas', 'gram', '0', '0',],
     ['Koran', 'Kertas', 'gram', '0', '0',],
     ['Karton/Boncos', 'Kertas', 'gram', '0', '0',],
     ['Kardus', 'Kertas', 'gram', '0', '0',],
     ['Duplek', 'Kertas', 'gram', '0', '0',],
     ['Karung Semen', 'Kertas', 'gram', '0', '0',],
     ['Kertas Buram', 'Kertas', 'gram', '0', '0',],
     ['Botol/Beling', 'Plastik', 'gram', '0', '0',],
     ['Beling Pecah', 'Plastik', 'gram', '0', '0',],
     ['Kristal', 'Plastik', 'gram', '0', '0',],
     ['Keping CD/DVD', 'Plastik', 'gram', '0', '0',],
     ['Toples Tipis', 'Plastik', 'gram', '1000', '0',],
     ['Galon LeMinerale', 'Plastik', 'gram', '0', '0',],
     ['Styrofoam', 'Plastik', 'gram', '0', '0',],
     ['Jelantah', 'Plastik', 'gram', '0', '0',],
     ['Sepatu', 'Plastik', 'gram', '0', '0',],
     ['Aki Mobil', 'Plastik', 'gram', '0', '0',],
     ['Aki Motor', 'Plastik', 'gram', '0', '0',],
     ['Karpet', 'Plastik', 'gram', '0', '0',],
     ['Impact', 'Plastik', 'gram', '0', '0',],
    ];

    pdf.addPage(
      pw.MultiPage(
        // header: (context) {
        //   return pw.Text(
        //     'Flutter Approach',
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'TABUNGAN',
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      nama,
                      style: const pw.TextStyle(
                        fontSize: 15.0,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.Text(
                      tgl,
                      style: const pw.TextStyle(
                        fontSize: 12.0,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Bank Sampah CSJ',
                      style: pw.TextStyle(
                        fontSize: 15.5,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Jalan Betawi, Kelurahan Jombang,\nKecamatan Ciputat, Kota Tangerang Selatan',
                    ),
                    pw.Text(
                      DateFormat("EEEE, d MMMM yyyy - hh:MM", "id_ID").format(DateTime.now().subtract(const Duration(days: 14))).toString(),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),

            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.TableHelper.fromTextArray(
              headers: tableHeaders,
              data: daftardata,
              border: null,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
              const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30.0,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
              },
            ),
            pw.Divider(),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // pw.Row(
                        //   children: [
                        //     pw.Expanded(
                        //       child: pw.Text(
                        //         'Net total',
                        //         style: pw.TextStyle(
                        //           fontWeight: pw.FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     pw.Text(
                        //       '\$ 464',
                        //       style: pw.TextStyle(
                        //         fontWeight: pw.FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // pw.Row(
                        //   children: [
                        //     pw.Expanded(
                        //       child: pw.Text(
                        //         'Vat 19.5 %',
                        //         style: pw.TextStyle(
                        //           fontWeight: pw.FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     pw.Text(
                        //       '\$ 90.48',
                        //       style: pw.TextStyle(
                        //         fontWeight: pw.FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // pw.Divider(),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Total ',
                                style: pw.TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Text(
                              'Rp. ${total}',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 2 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                        pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                        pw.Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              // pw.SizedBox(height: 2 * PdfPageFormat.mm),
              // pw.Text(
              //   'Flutter Approach',
              //   style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              // ),
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.center,
              //   children: [
              //     pw.Text(
              //       'Address: ',
              //       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              //     ),
              //     pw.Text(
              //       'Merul Badda, Anandanagor, Dhaka 1212',
              //     ),
              //   ],
              // ),
              // pw.SizedBox(height: 1 * PdfPageFormat.mm),
              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.center,
              //   children: [
              //     pw.Text(
              //       'Email: ',
              //       style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              //     ),
              //     pw.Text(
              //       'flutterapproach@gmail.com',
              //     ),
              //   ],
              // ),
            ],
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'banksampah.pdf', pdf: pdf);
  }
}

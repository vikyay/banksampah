import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:banksampah/screens/dashboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID', null).then((_) => runApp(const ProviderScope(child: MaterialApp(
    title: 'Bank Sampah',
    debugShowCheckedModeBanner: false,
    home: Dashboard(),
  ))));

}

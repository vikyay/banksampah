import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banksampah/data/datasource/datasource.dart';

final taskDatasourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});

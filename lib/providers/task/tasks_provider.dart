import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banksampah/data/data.dart';
import 'package:banksampah/providers/providers.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});

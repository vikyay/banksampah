import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:banksampah/config/config.dart';
import 'package:banksampah/data/data.dart';
import 'package:banksampah/providers/providers.dart';
import 'package:banksampah/utils/utils.dart';
import 'package:banksampah/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:banksampah/widgets/peserta.dart';



class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(
      BuildContext context,
      GoRouterState state,
      ) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: const DisplayWhiteText(
          text: 'Tambahkan Barang',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Nama Penyetor',
                style: context.textTheme.titleLarge,
              ),
              const Gap(10),
              const Peserta(),
              const Gap(30),
              const SelectDateTime(),
              const Gap(30),
              CommonTextField(
                hintText: 'Tambahkan jika ada',
                title: 'Catatan',
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: _createTask,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayWhiteText(
                    text: 'Lanjutkan ke daftar barang',
                  ),
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        category: category,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        note: note,
        isCompleted: false,
      );

      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Task create successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }
}

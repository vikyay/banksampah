import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

@immutable
class Helpers {
  const Helpers._();
  static String timeToString(TimeOfDay time) {
    try {
      final DateTime now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      final formatType = DateFormat.jm();
      return formatType.format(date);
    } catch (e) {
      return '12:00';
    }
  }

  static void selectDate(BuildContext context, WidgetRef ref) async {
    final dateProvider = StateProvider<DateTime>((ref) {
      return DateTime.now();
    });
    final initialDate = ref.read(dateProvider);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2060),
    );
    print(pickedDate.toString());
    print('su');
    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state = pickedDate;
    }
  }

  static DateTime _stringToDateTime(String dateString) {
    try {
      DateFormat format = DateFormat.yMMMd();
      return format.parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String dateFormatter(DateTime date) {
    try {
      return DateFormat.yMMMd('id_ID').format(date);
    } catch (e) {
      return DateFormat.yMMMd('id_ID').format(
        DateTime.now(),
      );
    }
  }
}

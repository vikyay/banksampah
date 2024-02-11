import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'helpers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'common_text_field.dart';

// class SelectDateTime extends ConsumerWidget {
//   const SelectDateTime({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dateProvider = StateProvider<DateTime>((ref) {
//       return DateTime.now();
//     });
//     final timeProvider = StateProvider.autoDispose<TimeOfDay>((ref) {
//       return TimeOfDay.now();
//     });
//     final time = ref.watch(timeProvider);
//     final date = ref.watch(dateProvider);
//
//
//
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             decoration: InputDecoration(
//               suffixIcon: IconButton(
//                 onPressed: () => Helpers.selectDate(context, ref),
//                 icon: const FaIcon(FontAwesomeIcons.calendar),
//               ),
//               hintText: Helpers.dateFormatter(date)
//             ),
//             readOnly: true,
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: TextField(
//             readOnly: true,
//             decoration: InputDecoration(
//               hintText: Helpers.timeToString(time),
//               suffixIcon: IconButton(
//                 onPressed: () => _selectTime(context, ref),
//                 icon: const FaIcon(FontAwesomeIcons.clock),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _selectTime(BuildContext context, WidgetRef ref) async {
//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     final timeProvider = StateProvider.autoDispose<TimeOfDay>((ref) {
//       return TimeOfDay.now();
//     });
//     if (pickedTime != null) {
//       ref.read(timeProvider.notifier).state = pickedTime;
//     }
//   }
// }



class SelectDateTime extends ConsumerWidget {
  SelectDateTime({super.key});

  final dateProvider = StateProvider<DateTime>((ref) {
    return DateTime.now();
  });

  final timeProvider = StateProvider.autoDispose<TimeOfDay>((ref) {
    return TimeOfDay.now();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            title: 'Date',
            hintText: Helpers.dateFormatter(date),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => Helpers.selectDate(context, ref),
              icon: const FaIcon(FontAwesomeIcons.calendar),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: CommonTextField(
            title: 'Time',
            hintText: Helpers.timeToString(time),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context, ref),
              icon: const FaIcon(FontAwesomeIcons.clock),
            ),
          ),
        ),
      ],
    );
  }

  void _selectTime(BuildContext context, WidgetRef ref) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state = pickedTime;
    }
  }
}





class SelectDate extends ConsumerWidget {
  const SelectDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProvider = StateProvider<DateTime>((ref) {
      return DateTime.now().subtract(const Duration(days: 10));
    });
    final date = ref.watch(dateProvider);
    return TextField(
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => {Helpers.selectDate(context, ref)},
            icon: const FaIcon(FontAwesomeIcons.calendar),
          ),
          hintText: Helpers.dateFormatter(date)),
      readOnly: true,
    );

  }
}

class SelectDateTwo extends ConsumerWidget {
  const SelectDateTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProvider = StateProvider<DateTime>((ref) {
      return DateTime.now();
    });
    final date = ref.watch(dateProvider);
    return TextField(
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => Helpers.selectDate(context, ref),
            icon: const FaIcon(FontAwesomeIcons.calendar),
          ),
          hintText: Helpers.dateFormatter(date)),
      readOnly: true,
    );
  }
}


class SelectMonth extends ConsumerWidget {
  const SelectMonth({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProvider = StateProvider<DateTime>((ref) {
      return DateTime.now();
    });
    final date = ref.watch(dateProvider);
    return TextField(
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => Helpers.selectDate(context, ref),
            icon: const FaIcon(FontAwesomeIcons.calendar),
          ),
          hintText: Helpers.dateFormatter(date)),
      readOnly: true,
    );
  }
}

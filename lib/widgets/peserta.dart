import 'package:flutter/material.dart';
import 'package:banksampah/utils/utils.dart';
import 'package:gap/gap.dart';

@override
const List<String> list = <String>['Ayah', 'Bunda', 'Aik', 'Uncle', 'Meong','Cicak'];

class Peserta extends StatefulWidget {
  const Peserta({super.key});

  @override
  State<Peserta> createState() => _PesertaState();
}

class _PesertaState extends State<Peserta> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      width: 370,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

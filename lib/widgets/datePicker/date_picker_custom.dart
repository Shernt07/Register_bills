// date_picker_custom.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerCustom extends StatelessWidget {
  final TextEditingController dateController;

  const DatePickerCustom({super.key, required this.dateController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            controller: dateController,
            readOnly: true,
            decoration: const InputDecoration(hintText: 'Seleccione una fecha'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Color(0xff08A5C0)),
          onPressed: () async {
            DateTime today = DateTime.now();
            DateTime fiveDaysLater = today.add(const Duration(days: 5));
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: today,
              firstDate: today,
              lastDate: fiveDaysLater,
              selectableDayPredicate: (DateTime date) {
                return date.weekday != DateTime.saturday;
              },
            );
            if (pickedDate != null) {
              dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
            }
          },
        ),
      ],
    );
  }
}

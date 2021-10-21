import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({
    Key? key,
    required this.titleController,
    required this.amountController,
    required this.onSubmit,
    required this.selectedDate,
    required this.setDate,
  }) : super(key: key);

  // String titleInput = '';
  // String amountInput = '';

  final TextEditingController titleController;
  final TextEditingController amountController;
  final DateTime? selectedDate;
  final Function setDate;
  final VoidCallback onSubmit;

  void presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate != null ? selectedDate! : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setDate(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                // onChanged: (value) {
                //   titleInput = value;
                // },
                controller: titleController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => context.nextEditableTextFocus(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                // onChanged: (value) {
                //   amountInput = value;
                // },
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () => presentDatePicker(context),
                // onSubmitted: (_) => onSubmit(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'No Date Chosen'
                        : DateFormat.yMd().format(selectedDate!)),
                  ),
                  TextButton(
                    onPressed: () => presentDatePicker(context),
                    child: const Text('Choose Date'),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: ElevatedButton(
                onPressed: onSubmit,
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (
        FocusScope.of(this).focusedChild!.context!.widget is! EditableText);
  }
}

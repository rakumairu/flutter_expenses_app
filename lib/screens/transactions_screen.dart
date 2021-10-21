import 'package:flutter/material.dart';
import 'package:flutter_course_two_expenses_app/models/transaction.dart';
import 'package:flutter_course_two_expenses_app/screens/transactions_body.dart';
import 'package:flutter_course_two_expenses_app/screens/widgets/transaction_form.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final List<Transaction> transactions = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  DateTime? selectedDate;

  onSubmit() {
    final transactionTitle = titleController.text;
    final transactionAmount =
        amountController.text.isEmpty ? 0 : double.parse(amountController.text);

    if (transactionTitle.isEmpty || transactionAmount <= 0) {
      return;
    }

    setState(() {
      transactions.add(
        Transaction(
          id: 't${transactions.length + 1}',
          title: titleController.text,
          amount: double.parse(amountController.text),
          date: selectedDate != null ? selectedDate! : DateTime.now(),
        ),
      );
      titleController.clear();
      amountController.clear();
    });

    Navigator.of(context).pop();
  }

  onDelete(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  openAddNewTransaction(
    BuildContext ctx,
  ) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: TransactionForm(
            titleController: titleController,
            amountController: amountController,
            selectedDate: selectedDate,
            setDate: setDate,
            onSubmit: onSubmit,
          ),
        );
      },
      isScrollControlled: true,
    );
  }

  setDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text('Expenses App'),
      actions: [
        IconButton(
          onPressed: () => openAddNewTransaction(context),
          icon: const Icon(Icons.add),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: TransactionsBody(
          amountController: amountController,
          titleController: titleController,
          transactions: transactions,
          onSubmit: onSubmit,
          deleteTransaction: onDelete,
          appBarHeight: appBar.preferredSize.height,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => openAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

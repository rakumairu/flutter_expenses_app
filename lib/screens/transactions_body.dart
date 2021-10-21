import 'package:flutter/material.dart';
import 'package:flutter_course_two_expenses_app/models/transaction.dart';
import 'package:flutter_course_two_expenses_app/screens/widgets/chart.dart';
import 'package:flutter_course_two_expenses_app/screens/widgets/transaction_list.dart';

class TransactionsBody extends StatefulWidget {
  const TransactionsBody({
    Key? key,
    required this.titleController,
    required this.amountController,
    required this.transactions,
    required this.onSubmit,
    required this.deleteTransaction,
    required this.appBarHeight,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController amountController;
  final List<Transaction> transactions;
  final VoidCallback onSubmit;
  final Function deleteTransaction;
  final double appBarHeight;

  @override
  _TransactionsBodyState createState() => _TransactionsBodyState();
}

class _TransactionsBodyState extends State<TransactionsBody> {
  List<Transaction> get recentTransaction {
    return widget.transactions
        .where(
          (transaction) => transaction.date.isAfter(
            DateTime.now().subtract(
              const Duration(
                days: 7,
              ),
            ),
          ),
        )
        .toList();
  }

  bool isChartShown = false;

  void toggleChart(bool isShown) {
    setState(() {
      isChartShown = isShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Show chart'),
              Switch.adaptive(
                value: isChartShown,
                onChanged: toggleChart,
              ),
            ],
          ),
          if (isChartShown) Chart(transactions: recentTransaction),
          TransactionList(
            transactions: widget.transactions,
            deleteTransaction: widget.deleteTransaction,
            appBarHeight: widget.appBarHeight,
            isChartShown: isChartShown,
          ),
        ],
      ),
    );
  }
}

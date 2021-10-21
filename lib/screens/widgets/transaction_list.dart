import 'package:flutter/material.dart';
import 'package:flutter_course_two_expenses_app/models/transaction.dart';
import 'package:flutter_course_two_expenses_app/screens/widgets/transaction_card.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactions,
    required this.deleteTransaction,
    required this.appBarHeight,
    required this.isChartShown,
  }) : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTransaction;
  final double appBarHeight;
  final bool isChartShown;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: isChartShown
          ? size.height - appBarHeight - 40
          : size.height -
              160 -
              appBarHeight -
              MediaQuery.of(context).padding.top -
              40,
      padding: const EdgeInsets.all(16.0),
      child: transactions.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return TransactionCard(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction,
                );
              },
              itemCount: transactions.length,
              // children: transactions.map((transaction) {
              //   return TransactionCard(
              //     transaction: transaction,
              //   );
              // }).toList(),
            )
          : const EmptyList(),
    );
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            'No transaction added yet!',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}

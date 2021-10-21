import 'package:flutter/material.dart';
import 'package:flutter_course_two_expenses_app/models/transaction.dart';
import 'package:flutter_course_two_expenses_app/screens/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.transactions}) : super(key: key);

  final List<Transaction> transactions;

  List<Map<String, Object>> get groupedTransactionsList {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double totalSum = 0.0;

        for (var i = 0; i < transactions.length; i++) {
          final currentTransaction = transactions[i];

          if (currentTransaction.date.day == weekDay.day &&
              currentTransaction.date.month == weekDay.month &&
              currentTransaction.date.year == weekDay.year) {
            totalSum += currentTransaction.amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay)[0],
          'amount': totalSum,
        };
      },
    ).reversed.toList();
  }

  double get maxSpending => groupedTransactionsList.fold(
        0.0,
        (previousValue, element) => previousValue += double.parse(
          element['amount'].toString(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsList
                .map(
                  (groupedTransaction) => Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        ChartBar(
                          label: groupedTransaction['day'].toString(),
                          spendingAmount: double.parse(
                            groupedTransaction['amount'].toString(),
                          ),
                          spendingPctOfTotal: maxSpending == 0
                              ? 0
                              : double.parse(
                                    groupedTransaction['amount'].toString(),
                                  ) /
                                  maxSpending,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

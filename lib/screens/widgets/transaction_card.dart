import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_course_two_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  Color _bgColor = Colors.amber;

  @override
  void initState() {
    super.initState();
    const availableColors = [
      Colors.amber,
      Colors.blue,
      Colors.indigo,
      Colors.green
    ];

    _bgColor = availableColors[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _bgColor,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(right: 12),
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 2,
                      ),
                      child: Text(
                        widget.transaction.title,
                        // style: TextStyle(
                        //   fontSize: 15,
                        //   fontWeight: FontWeight.bold,
                        //   color: Colors.grey.shade800,
                        // ),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(
                      DateFormat('yMMMd').format(widget.transaction.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              MediaQuery.of(context).size.width > 360
                  ? TextButton.icon(
                      label: Text(
                        'Delete',
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                      onPressed: () =>
                          widget.deleteTransaction(widget.transaction.id),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    )
                  : IconButton(
                      onPressed: () =>
                          widget.deleteTransaction(widget.transaction.id),
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

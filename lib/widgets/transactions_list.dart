import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/no_transactions.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTheTask;
  TransactionsList({this.transactions, this.deleteTheTask});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? NoTransactions()
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Text('\$${transactions[index].price}'),
                    ),
                  ),
                  title: Text(
                    transactions[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            deleteTheTask(index);
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () {
                            deleteTheTask(index);
                          },
                        ),
                ),
              );
            },
          );
  }
}

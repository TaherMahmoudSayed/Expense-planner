import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function(String id) deleteTransaction;
  TransactionList(this.userTransactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: userTransactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                print("layoutOF image height:" +
                    constraints.maxHeight.toString());
                return Column(
                  children: [
                    Container(
                      height: constraints.maxHeight * 0.15,
                      child: Text(
                        "no transactions added yet!",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          "assets/image/waiting.png",
                          fit: BoxFit.cover,
                        )),
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                                '\$${userTransactions[index].amount.toStringAsFixed(2)}'),
                          ),
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        userTransactions[index].title,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      subtitle: Text(DateFormat.yMMMMd()
                          .format(userTransactions[index].dateTime)),
                      trailing: IconButton(
                        color: Theme.of(context).errorColor,
                        onPressed: () =>
                            deleteTransaction(userTransactions[index].id),
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
                itemCount: userTransactions.length,
              ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/transaction.dart';
import 'package:flutter_application_1/widgets/chartBar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  double totalWeekAmount = 0.0;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    totalWeekAmount = 0.0;
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      //calc total amount of the transactions of the same weekday
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dateTime.day == weekDay.day &&
            recentTransactions[i].dateTime.weekday == weekDay.weekday &&
            recentTransactions[i].dateTime.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
          totalWeekAmount += recentTransactions[i].amount;
        }
      }
      //print('week amount${index}:' + totalWeekAmount.toString());
      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    // print("groupedTransactions:" + groupedTransactions.toString());
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  e['day'].toString(),
                  e['amount'] as double,
                  totalWeekAmount == 0
                      ? 0
                      : (e['amount'] as double) / totalWeekAmount),
            );
          }).toList(),
        ),
      ),
    );
  }
}

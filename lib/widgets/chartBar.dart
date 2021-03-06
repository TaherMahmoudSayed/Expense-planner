import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double totalAmountPrecentage;
  ChartBar(this.label, this.spendingAmount, this.totalAmountPrecentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$ ${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(height: constraints.maxHeight * 0.05),
          //creating the bar
          Container(
            height: constraints.maxHeight * 0.6,
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: totalAmountPrecentage,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            width: 10,
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          //printing the label
          Container(height: constraints.maxHeight * 0.15, child: Text(label)),
        ],
      );
    });
  }
}

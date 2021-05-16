import 'package:expense_planer/models/transaction.dart';
import 'package:expense_planer/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> weekTransactions;
  Chart(this.weekTransactions);
  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var tx in weekTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.price;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'price': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpent {
    return groupedTransactionsValues.fold(0.0, (sum, element) {
      return sum + element["price"];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: data["day"],
                    spentAmount: data["price"],
                    percentage: totalSpent == 0.0
                        ? 0.0
                        : (data["price"] as double) / totalSpent),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

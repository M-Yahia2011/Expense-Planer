import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTX;
  TransactionList(this.transactions, this.deleteTX);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text("You have no transctions"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 150,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              "\$${transactions[index].price.toStringAsFixed(2)}",
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '${transactions[index].title}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        intl.DateFormat.yMMMMd()
                            .format(transactions[index].date),
                      ),
                      trailing: IconButton(
                        onPressed: () => deleteTX(transactions[index].id),
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}

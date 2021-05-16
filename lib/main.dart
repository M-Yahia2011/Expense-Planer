import './widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import 'models/transaction.dart';

main() => runApp(MyRoot());

class MyRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Planner",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: "Quicksand", // the default
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),

          //creating an appbar with default style and copy it through out the app
          // any widget with (title) will has this style
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Opensans',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1)))),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];
  List<Transaction> get _weekTransctions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String newTitle, double newPrice, DateTime date) {
    final tx = Transaction(
        title: newTitle,
        price: newPrice,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _showInputForm(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (widgetCtx) {
          return GestureDetector(
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Expenses Planner"),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //       icon: Icon(Icons.add), onPressed: () => _showInputForm(context))
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Chart(_weekTransctions),
              TransactionList(_userTransactions, _deleteTransaction),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showInputForm(context),
        ));
  }
}

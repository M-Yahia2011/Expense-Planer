import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class NewTransaction extends StatefulWidget {
  final Function addNewTX;
  NewTransaction(this.addNewTX);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  DateTime _selectedDate;
  void _submitData() {
    final inputTitle = titleController.text;
    final inputPrice = double.parse(priceController.text);
    if (priceController.text.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
      _selectedDate = DateTime.now();
    }
    if (inputTitle.isEmpty || inputPrice <= 0) {
      return;
    }
    widget.addNewTX(inputTitle, inputPrice, _selectedDate);
    Navigator.of(context).pop();
  }

  void _chooseDate(BuildContext ctx) async {
    var date = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime.now());
    if (date == null) {
      return;
    }
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) =>
                  _submitData(), // (_) not important value but just save maybe ??
            ),
            TextField(
              decoration: InputDecoration(labelText: "Price"),
              // onChanged: (price) => priceInput = price,
              controller: priceController,
              keyboardType: TextInputType.number,
              onSubmitted: (a) => _submitData(),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No Date Added'
                      : intl.DateFormat.yMMMMd().format(_selectedDate)),
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20)),
                    onPressed: () => _chooseDate(context),
                    child: Text(
                      'Pick a date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
            ElevatedButton(
                onPressed: () => _submitData(), child: Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}

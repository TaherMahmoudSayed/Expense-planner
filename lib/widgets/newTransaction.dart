import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function(String title, double amount, DateTime choosenDate)
      addNewTransation;
  NewTransaction(this.addNewTransation);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //test these two variables without final keyword//////////////////////////////////
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  DateTime? selectedDate;
  /////////////////////////////////////////
  void submitTransaction() {
    String title = titleInput.text;
    double amount =
        double.parse(amountInput.text.isNotEmpty ? amountInput.text : "0");
    DateTime? selectedDate = this.selectedDate;
    if (title.isEmpty || amount <= 0 || selectedDate == null) {
      print("error");
      return;
    }
    this.widget.addNewTransation(title, amount, selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          this.selectedDate = value;
        });
      } else
        return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Title", contentPadding: EdgeInsets.all(5)),
                    controller: titleInput,
                    onSubmitted: (_) => submitTransaction(),
                  ),
                  TextField(
                    controller: amountInput,
                    decoration: InputDecoration(
                        labelText: "Amount", contentPadding: EdgeInsets.all(5)),
                    onSubmitted: (_) => submitTransaction(),
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Text(selectedDate != null
                            ? DateFormat.yMd().format(selectedDate!)
                            : 'No Date Choosen!'),
                        FlatButton(
                            onPressed: presentDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  RaisedButton(
                      onPressed: submitTransaction,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Add Transaction",
                        style: TextStyle(
                            color: Theme.of(context).textTheme.button!.color,
                            fontWeight: FontWeight.normal),
                      ))
                ],
              )),
          color: Colors.tealAccent,
          // margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(
              top: 5,
              left: 5,
              right: 5,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/chart.dart';
import 'package:flutter_application_1/widgets/newTransaction.dart';
import 'models/transaction.dart';
import 'widgets/transactionList.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.purple,
        textTheme: TextTheme(
            headline1: TextStyle(
                fontFamily: "italic",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.redAccent,
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> transactions = [
    // Transaction("t1", 'new shoes', 69.99, DateTime.now()),
    // Transaction("t2", 'weakly Groceries', 16.99,
    //     DateTime.now().subtract(Duration(days: 2))),
  ];
  bool showChart = false;
  List<Transaction> get recentTransactions {
    return transactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime choosenDte) {
    var newTx =
        Transaction(DateTime.now().toString(), title, amount, choosenDte);
    setState(() {
      this.transactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addNewTransaction);
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        IconButton(
            onPressed: () {
              startAddNewTransaction(context);
            },
            icon: Icon(Icons.add)),
      ],
    );
    final transactionListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(transactions, this.deleteTransaction));

    double height = (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
        0.7;
    print("transactionListWidgetHeight:" + height.toString());

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                      value: showChart,
                      onChanged: (val) {
                        setState(() {
                          showChart = val;
                        });
                      }),
                ],
              ),
            if (isLandScape)
              showChart == true
                  //chart widget
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      //calling Chart widget///////
                      child: Chart(recentTransactions),
                      color: Colors.tealAccent,
                    )
                  //TransactionList
                  : transactionListWidget,
            if (!isLandScape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                //calling Chart widget///////
                child: Chart(recentTransactions),
                color: Colors.tealAccent,
              ),
            if (!isLandScape) transactionListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }
}

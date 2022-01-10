import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/transactions_list.dart';
import './widgets/add_new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'dart:io';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.blueGrey[800],
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(),
        textTheme: Theme.of(context).textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
              button: TextStyle(color: Colors.grey),
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  List<Transaction> _transactions = [
    Transaction(
      name: 'Shoes',
      price: 20,
      date: DateTime.now(),
    ),
    Transaction(
      name: 'Bags',
      price: 40.0,
      date: DateTime.now(),
    ),
    Transaction(
      name: 'Umbrella',
      price: 80,
      date: DateTime.now(),
    ),
    Transaction(
      name: 'Camera',
      price: 100,
      date: DateTime.now(),
    ),
    Transaction(
      name: 'Phone',
      price: 90,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteATask(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  void _addNewTransaction(String name, double price, DateTime selectedDate) {
    setState(() {
      _transactions.add(Transaction(
        name: name,
        price: price,
        date: selectedDate,
      ));
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AddNewTransaction(
              addNewTransaction: _addNewTransaction,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Expenses Planner',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    startAddNewTransaction(context);
                  },
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).accentColor,
            actions: [
              IconButton(
                onPressed: () {
                  startAddNewTransaction(context);
                },
                icon: Icon(Icons.add),
              ),
            ],
            title: Text(
              'Expenses Planner',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            centerTitle: true,
          );

    final TransactionsListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionsList(
        transactions: _transactions,
        deleteTheTask: _deleteATask,
      ),
    );

    final pageScaffold = SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(recentTransactions: _recentTransactions),
              ),
            if (!isLandscape) TransactionsListWidget,
            if (isLandscape)
              Switch.adaptive(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  }),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(recentTransactions: _recentTransactions),
                    )
                  : TransactionsListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageScaffold,
          )
        : Scaffold(
            appBar: appBar,
            body: pageScaffold,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      startAddNewTransaction(context);
                    },
                  ),
          );
  }
}

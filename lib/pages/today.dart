import 'package:flutter/material.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';
import 'package:sms/sms.dart';

class Daily extends StatefulWidget {
  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  SmsQuery query = new SmsQuery();
  List messages = new List(); //list of all messages
  List finalMessages = new List(); //list of only messages with transactions

//function that fetches messages,classifies them and extracts info
  fetchSMS() async {
    //print(messages);
    int credited = 0; //number of credit msgs
    int debited = 0; //number of debit msgs

    //regex to extract amount from message
    RegExp tester = new RegExp(
      r"\b\d+\.*\d*\b",
      caseSensitive: false,
      multiLine: false,
    );

    double paid = 0.0;
    double received = 0.0;

    try {
      print("messages length");
      messages = await query.getAllSms;
      print(messages.length);

//loop through all messages
      for (var i = 0; i < messages.length; i++) {
        if ((messages[i].body)
            .toString()
            .toLowerCase()
            .contains("credited with rs")) {
          //is a credit msg?
          print("credited message at $i");
          // print(messages[i].body);
          credited++;
          finalMessages.add(messages[i]);
          String amt = tester
              .stringMatch((messages[i].body).toString())
              .toString(); //match with regex to extract amt

          print(amt);
          double amt2 = double.parse(amt);
          if (amt2 < 1000) addNewTransaction("Debited", amt2, DateTime.now());
          received += double.parse(amt); //parse from string to double format
          print("received: $received");
        } else if ((messages[i].body)
            .toString()
            .toLowerCase()
            .contains("debited by rs")) {
          //is a debit msg?
          print("debited message at $i");
          //  print(messages[i].body);
          debited++;
          finalMessages.add(messages[i]);
          String amt = tester
              .stringMatch((messages[i].body).toString())
              .toString(); //match with regex to extract amt

          print(amt);

          paid += double.parse(amt); //parse from string to double format
          print("paid: $paid");
        }
      }

      double total = received - paid;
      print("creditedcount: $credited");
      print("debitedcount: $debited");
      print("totalpaid: $paid");
      print("totalreceived: $received");
      print("total: $total");
    } catch (e) {
      print("error");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    initState() {
      // TODO: implement initState
      super.initState();
    }

    return Scaffold(
      floatingActionButton: Transform.scale(
        scale: 1.1,
        child: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          backgroundColor: Color(0xFF5e17eb),
          child: Image(
            image: AssetImage('assets/Money.png'),
            width: 30,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Today's Expenses"),
        backgroundColor: Color(0xFF5e17eb),
      ),
      body: FutureBuilder(
        future: fetchSMS(),
        builder: (context, snapshot) {
          return TransactionList(_userTransactions, _deleteTransaction);
        },
      ),
    );
  }
}

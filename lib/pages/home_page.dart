import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './today.dart';
import '../widgets/new_transaction.dart';
import '../models/transaction.dart';
import './monthly.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> userTransactions = [];

  List<Transaction> get _recentTransactions {
    return userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Transform.scale(
          scale: 1.1,
          child: FloatingActionButton(
            tooltip: "Add Cash Transactions",
            onPressed: () => _startAddNewTransaction(context),
            backgroundColor: Color(0xFF5e17eb),
            child: Image(
              image: AssetImage('assets/Money.png'),
              width: 30,
            ),
          ),
        ),
        endDrawer: Drawer(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF5e17eb),
            ),
          ),
        ),
        appBar: AppBar(
          title: Center(
              child: Text(
                  "${DateFormat('EEEE, d MMM').format(new DateTime.now())}")),
          backgroundColor: Color(0xFF5e17eb),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                //height: 200,
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Daily()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(
                        //   top: 15,
                        //   left: 15,
                        // ),
                        child: Text(
                          "Today",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              //padding:
                              //EdgeInsets.only(left: 15, top: 5, right: 15),
                              child: Text(
                                "₹100/300",
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width - 95,
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 2000,
                              percent: 0.3333,
                              center: Text(
                                "33.33%",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: Color(0xFF5ec1e6),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  color: Color(0xFF5e17eb),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(right: 7.5),
                        child: RaisedButton(
                          onPressed: () {
                            print("This Week");
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  "This Week",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                "₹576",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          color: Color(0xFF5e17eb),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(left: 7.5),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Monthly()),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  "This Month",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Text(
                                "₹8473",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          color: Color(0xFF5e17eb),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        //height: 150,
                        padding: EdgeInsets.only(right: 7.5),
                        child: RaisedButton(
                          onPressed: () {
                            print("Ledger");
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Image(
                                  width: 60,
                                  image: AssetImage('assets/Book.png'),
                                ),
                              ),
                              Text(
                                "Ledger",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          color: Color(0xFF5e17eb),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //height: 150,
                        padding: EdgeInsets.only(left: 7.5),
                        child: RaisedButton(
                          onPressed: () {
                            print("Categories");
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Image(
                                  image: AssetImage(
                                    'assets/Chart.png',
                                  ),
                                  width: 65,
                                ),
                              ),
                              Text(
                                "  Categories",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          color: Color(0xFF5e17eb),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                width: double.infinity,
                height: 150,
                child: RaisedButton(
                  onPressed: () {
                    print("Add Notes");
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                    15.0,
                  )),
                  color: Color(0xFF5e17eb),
                  child: Text(
                    "Add Notes",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

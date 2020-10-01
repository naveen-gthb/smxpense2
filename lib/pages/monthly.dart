import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:intl/intl.dart';

class Monthly extends StatefulWidget {
  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  Map<String, double> dataMap = {
    "Week 1": 2,
    "Week 2": 3,
    "Week 3": 5,
    "Week 4": 2,
  };

  DateTime _selectedDate;
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly Expenses"),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Monthly()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 15,
                        left: 15,
                      ),
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
                            padding:
                                EdgeInsets.only(left: 15, top: 5, right: 15),
                            child: Text(
                              "₹100",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
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
            flex: 2,
            child: PieChart(
              dataMap: dataMap,
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.all(15),
                          color: Color(0xFF5e17eb),
                          textColor: Colors.white,
                          child: Text(
                            _selectedDate == null
                                ? 'No Date Chosen!'
                                : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                          ),
                          onPressed: _presentDatePicker,
                        ),
                        RaisedButton(
                          onPressed: () {
                            print("Go");
                          },
                          child: Text("GO"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Categories extends StatelessWidget {
  final Map<String, double> dataMap = {
    "Fast Food": 2,
    "Travel": 3,
    "Groceries": 5,
    "Clothes": 2,
    "Bill Payments": 3
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: PieChart(dataMap: dataMap),
          ),
        ],
      ),
    );
  }
}

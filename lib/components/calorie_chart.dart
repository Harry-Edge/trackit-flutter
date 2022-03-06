import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CalorieChart extends StatefulWidget {

  List<Map> calorieData;

  CalorieChart({Key? key, required this.calorieData}) : super(key: key);

  @override
  _CalorieChartState createState() => _CalorieChartState();
}

class _CalorieChartState extends State<CalorieChart> {

  List<CalorieData> _mapCalorieData = [];

  @override
  void initState()  {
    super.initState();
    _parseData();
  }

  void _parseData() {
    setState(() {
      for (var weight in widget.calorieData){

        var parsedDate = DateTime.parse(weight['date_inputted']);
        final DateFormat formatter = DateFormat('dd-MM');
        final String formatted = formatter.format(parsedDate);

        _mapCalorieData.add(
            CalorieData(
                formatted,
                weight['inputted_calories']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: SfCartesianChart(
        // Initialize category axis
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Calories'),
          tooltipBehavior: TooltipBehavior( enable: true),
          series: <LineSeries<CalorieData, String>>[
            LineSeries<CalorieData, String>(
              // Bind data source
                dataSource:  _mapCalorieData,
                xValueMapper: (CalorieData calories, _) => calories.date,
                yValueMapper: (CalorieData calories, _) => calories.calories,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                markerSettings: const MarkerSettings(
                    borderWidth: 3,
                    borderColor: Colors.red)
            )
          ]
      ),
    );
  }
}

class CalorieData {
  CalorieData(this.date, this.calories);
  final double calories;
  final String date;
}
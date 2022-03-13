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

  late final List<CalorieData> _mapCalorieData = [];
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState()  {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
        enablePanning: true,
        zoomMode: ZoomMode.x,
        maximumZoomLevel: 0.5,
        enableDoubleTapZooming: true);
    _parseData();
  }

  void _parseData() {
    setState(() {
      for (var weight in widget.calorieData){
        _mapCalorieData.add(CalorieData(
            DateTime.parse(weight['date_inputted']),
            weight['inputted_calories']
        ));
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
          title: ChartTitle(
              text: 'Calories',
              textStyle: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold
              )),
          zoomPanBehavior: _zoomPanBehavior,
          tooltipBehavior: TooltipBehavior( enable: true),
          series: <SplineSeries<CalorieData, DateTime>>[
            SplineSeries<CalorieData, DateTime>(
              // Bind data source
                dataSource:  _mapCalorieData,
                name: 'Calories (Kcal)',
                xValueMapper: (CalorieData calories, _) => calories.date,
                color: Colors.yellow[700],
                animationDuration: 2000,
                width: 3,
                opacity: 1,
                splineType: SplineType.monotonic,
                cardinalSplineTension: 0.9,
                yValueMapper: (CalorieData calories, _) => calories.calories,
                markerSettings: MarkerSettings(
                    isVisible: true,
                    height: 3,
                    width: 3,
                    shape: DataMarkerType.circle,
                    borderWidth: 3,
                    borderColor: Colors.yellow[700])
            )
          ],
          primaryXAxis: DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift),
          primaryYAxis: NumericAxis(
              labelAlignment: LabelAlignment.end,
              labelFormat: '{value} Kcal',
              maximumLabels: 3,
              numberFormat: NumberFormat.decimalPattern()),
      ),
    );
  }
}

class CalorieData {
  CalorieData(this.date, this.calories);
  final double calories;
  final DateTime date;
}
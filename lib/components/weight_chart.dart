import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_it/db_functions/db_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class WeightChart extends StatefulWidget {
  
  List<Map> weightData;

  WeightChart({Key? key, required this.weightData}) : super(key: key);

  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {

  List<WeightData> _mapWeightData = [];

  @override
  void initState()  {
    super.initState();
    _parseData();
  }

  void _parseData() {
    setState(() {
      for (var weight in widget.weightData){

        var parsedDate = DateTime.parse(weight['date_inputted']);
        final DateFormat formatter = DateFormat('dd-MM');
        final String formatted = formatter.format(parsedDate);

        _mapWeightData.add(
            WeightData(
                formatted,
                weight['inputted_weight']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: SfCartesianChart(
        // Initialize category axis
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Weight'),
          tooltipBehavior: TooltipBehavior( enable: true),
          series: <LineSeries<WeightData, String>>[
            LineSeries<WeightData, String>(
              // Bind data source
                dataSource:  _mapWeightData,
                xValueMapper: (WeightData weight, _) => weight.date,
                yValueMapper: (WeightData weight, _) => weight.weight,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                markerSettings: MarkerSettings(
                    borderWidth: 3,
                    borderColor: Colors.red)
            )
          ]
      ),
    );
  }
}

class WeightData {
  WeightData(this.date, this.weight);
  final double weight;
  final String date;
}
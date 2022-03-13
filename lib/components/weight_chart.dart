import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class WeightChart extends StatefulWidget {
  
  List<Map> weightData;

  WeightChart({Key? key, required this.weightData}) : super(key: key);

  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {

  late final List<WeightData> _mapWeightData = [];
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
      for (var weight in widget.weightData){
        _mapWeightData.add(WeightData(
          DateTime.parse(weight['date_inputted']),
          weight['inputted_weight']
        ));
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
          title: ChartTitle(
              text: 'Weight',
              textStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold)
          ),
          zoomPanBehavior: _zoomPanBehavior,
          tooltipBehavior: TooltipBehavior( enable: true),
          series: [
            SplineSeries(
              // Bind data source
                name: 'Weight (KG)',
                dataSource:  _mapWeightData,
                xValueMapper: (WeightData weight, _) => weight.date,
                color: Colors.yellow[700],
                animationDuration: 2000,
                width: 3,
                opacity: 1,
                splineType: SplineType.monotonic,
                cardinalSplineTension: 0.9,
                yValueMapper: (WeightData weight, _) => weight.weight,
                markerSettings: MarkerSettings(
                    isVisible: true,
                    height: 2,
                    width: 2,
                    shape: DataMarkerType.circle,
                    borderWidth: 3,
                    borderColor: Colors.yellow[700])
            )
          ],
          primaryXAxis: DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift),
          primaryYAxis: NumericAxis(
              labelFormat: '{value} KG',
              maximumLabels: 3,
              numberFormat: NumberFormat.decimalPattern()),
      ),
    );
  }
}

class WeightData {
  WeightData(this.date, this.weight);
  final double weight;
  final DateTime date;
}
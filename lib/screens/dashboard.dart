import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:track_it/db_functions/db_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:track_it/components/weight_chart.dart';
import 'package:track_it/components/calorie_chart.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<Map> ? _weightData;
  List<Map> ? _calorieData;
  bool _isLoading = true;

  void _refreshData() async {
    final data = await SQLiteDB.getWeightData();
    final calorieData = await SQLiteDB.getCalorieData();

    setState(() {
      _weightData = data;
      _calorieData = calorieData;
      _isLoading = false;
    });
  }

  @override
  void initState()  {
    super.initState();
    // final data = ModalRoute.of(context)!.settings.arguments as List<Map>;
    _refreshData();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLiteDB.deleteWeightEntry(id);
    print(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                  'TRACKIT',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w900)),
            ),
            const SizedBox(height: 10.0),
            WeightChart(weightData: _weightData!),
            const SizedBox(height: 10.0),
            CalorieChart(calorieData: _calorieData!),
            const SizedBox(height: 10.0),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _weightData?.length ?? 0,
                itemBuilder: (context, index) => Card(
                    elevation: 0,
                    color: Colors.white,
                    margin: const EdgeInsets.all(10),
                    child: ListTile (
                      title: Text(_weightData![index]['user'].toString()),
                      subtitle: Text(_weightData![index]['inputted_weight'].toString()),
                      trailing: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => _deleteItem(_weightData![index]['id']),
                                  icon: const Icon(Icons.delete))
                            ],
                          )
                      ),
                    )
                )),
          ],
        ),
      ),
    );
  }
}

class WeightData {
  WeightData(this.date, this.weight);
  final double weight;
  final String date;
}

class CalorieData {
  CalorieData(this.date, this.calories);
  final double calories;
  final String date;
}
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:track_it/db_functions/db_functions.dart';


class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  List<Map> _testData = [
    {'inputtedWeight': 65, 'date': '2022-01-20 14:29:04'},
    {'inputtedWeight': 68.3, 'date': '2022-02-01 14:29:04'},
    {'inputtedWeight': 68.1, 'date': '2022-02-02 14:29:04'},
    {'inputtedWeight': 67, 'date': '2022-02-04 14:29:04'},
    {'inputtedWeight': 68, 'date': '2022-02-05 14:29:04'},
    {'inputtedWeight': 68.3, 'date': '2022-02-06 14:29:04'},
    {'inputtedWeight': 68, 'date': '2022-02-07 14:29:04'},
    {'inputtedWeight': 69, 'date': '2022-02-08 14:29:04'},
    {'inputtedWeight': 70, 'date': '2022-02-09 14:29:04'},
    {'inputtedWeight': 71, 'date': '2022-02-11 14:29:04'},
    {'inputtedWeight': 69.5, 'date': '2022-02-12 14:29:04'},
    {'inputtedWeight': 69.9, 'date': '2022-02-13 14:29:04'},
    {'inputtedWeight': 70, 'date': '2022-02-14 14:29:04'},
    {'inputtedWeight': 70, 'date': '2022-02-15 14:29:04'},
    {'inputtedWeight': 71, 'date': '2022-02-16 14:29:04'},
    {'inputtedWeight': 72, 'date': '2022-02-17 14:29:04'},
    {'inputtedWeight': 72.5, 'date': '2022-02-18 14:29:04'},
    {'inputtedWeight': 72, 'date': '2022-02-19 14:29:04'},
    {'inputtedWeight': 73, 'date': '2022-02-20 14:29:04'},
    {'inputtedWeight': 74, 'date': '2022-02-21 14:29:04'},
    {'inputtedWeight': 74.5, 'date': '2022-02-22 14:29:04'},
    {'inputtedWeight': 73.5, 'date': '2022-02-23 14:29:04'},
    {'inputtedWeight': 73, 'date': '2022-02-24 14:29:04'},
    {'inputtedWeight': 72, 'date': '2022-02-25 14:29:04'},
    {'inputtedWeight': 71, 'date': '2022-02-26 14:29:04'},
    {'inputtedWeight': 72, 'date': '2022-02-27 14:29:04'},
    {'inputtedWeight': 73, 'date': '2022-03-01 14:29:04'},
    {'inputtedWeight': 74, 'date': '2022-03-18 14:29:04'}

  ];


  void getAndOpenDatabase() async {
    await Future.delayed(const Duration(seconds: 1));

    final weightData = await SQLiteDB.getWeightData();
    final calorieData = await SQLiteDB.getCalorieData();

    print(weightData);

    // for (int i = 0; i < _testData.length; i++) {
    //   await SQLiteDB.createNewWeightEntry(
    //       1, _testData[i]['inputtedWeight'], _testData[i]['date']);
    // }

    // await SQLiteDB.createUserInstance();

    // await SQLiteDB.createItem(5.0, 86);

    // SQLiteDB.rawSQLQuery("DROP TABLE weight_entries");

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'weightData': weightData
    });
  }

  @override
  void initState() {
    super.initState();
    getAndOpenDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget> [
              SpinKitFoldingCube(
                color: Colors.black,
                size: 50.0,
              ),
              SizedBox(height: 20.0),
              Text(
                  'TRACKIT',
                   style: TextStyle(
                       color: Colors.black,
                       fontSize: 50.0,
                       fontWeight: FontWeight.w900))
            ]
          ),
        )
    );
  }
}



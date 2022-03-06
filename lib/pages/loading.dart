import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:track_it/db_functions/db_functions.dart';


class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getAndOpenDatabase() async {
    await Future.delayed(const Duration(seconds: 1));

    final weightData = await SQLiteDB.getWeightData();
    final calorieData = await SQLiteDB.getCalorieData();

    print(weightData);

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



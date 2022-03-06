import 'package:flutter/material.dart';
import 'package:track_it/db_functions/db_functions.dart';

class CalorieScreen extends StatefulWidget {
  const CalorieScreen({Key? key}) : super(key: key);

  @override
  _CalorieScreenState createState() => _CalorieScreenState();
}

class _CalorieScreenState extends State<CalorieScreen> {

  String dropdownValue = 'One';

  List<Map> _calorieData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await SQLiteDB.getCalorieData();
    setState(() {
      _calorieData = data;
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
    await SQLiteDB.deleteCalorieEntry(id);
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Calories',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.yellow[700],
                        fontWeight: FontWeight.w900)),
                const Text(
                    'TRACKIT',
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w900))
              ],
            ),
            const SizedBox(height: 10.0),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _calorieData.length,
                itemBuilder: (context, index) => Card(
                    elevation: 0,
                    color: Colors.white,
                    margin: const EdgeInsets.all(5),
                    child: ListTile (
                      title: Text('${_calorieData[index]['inputted_calories'].toString()} Kcal'),
                      subtitle: Text(_calorieData[index]['date_inputted'].toString()),
                      trailing: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => _deleteItem(_calorieData[index]['id']),
                                  icon: Icon(Icons.delete))
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

import 'package:flutter/material.dart';
import 'package:track_it/db_functions/db_functions.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {

  String dropdownValue = 'One';

  List<Map> _weightData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await SQLiteDB.getWeightData();
    setState(() {
      _weightData = data;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weight',
                    style: TextStyle(
                    fontSize: 35,
                    color: Colors.yellow[700],
                    fontWeight: FontWeight.w900)),
                Text(
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
                itemCount: _weightData.length,
                itemBuilder: (context, index) => Card(
                    elevation: 0,
                    color: Colors.white,
                    margin: const EdgeInsets.all(5),
                    child: ListTile (
                      title: Text('${_weightData[index]['inputted_weight'].toString()} KG'),
                      subtitle: Text(_weightData[index]['date_inputted'].toString()),
                      trailing: SizedBox(
                          width: 50,
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () => _deleteItem(_weightData[index]['id']),
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

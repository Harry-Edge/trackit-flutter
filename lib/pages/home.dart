import 'package:flutter/material.dart';
import 'package:track_it/db_functions/db_functions.dart';
import 'package:track_it/screens/dashboard.dart';
import 'package:track_it/screens/Weight.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:track_it/screens/calories.dart';
import 'package:track_it/screens/strength_records.dart';
import 'package:track_it/screens/settings.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String dropdownValue = 'Weight';
  String strengthRecord = 'Deadlift';
  String helperText = 'Weight (KG)';
  String helperTextPlaceholder = 'eg. 70';

  DateTime selectedDate = DateTime.now();

  int _selectedIndex = 0;
  bool _isLoading = true;

  final widgetOptions = [
    const DashboardScreen(),
    const WeightScreen(),
    const CalorieScreen(),
    const StrengthRecordsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState()  {
    super.initState();
    // final data = ModalRoute.of(context)!.settings.arguments as List<Map>;
    _refreshData();
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      print('Selected: $selected');
      setState(() {
        selectedDate = selected;
        print('date: $selectedDate');
      });
    }
  }

  void changeHelperText(){
    setState(() {
      if (dropdownValue == 'Weight') {
        helperText = 'Weight (Kg)';
        helperTextPlaceholder = 'eg. 70';
      } else if (dropdownValue == 'Calories') {
        helperText = 'Calories (Kcal)';
        helperTextPlaceholder = 'eg. 2800';
      } else {
        helperText = 'Weight (KG)';
        helperTextPlaceholder = 'eg. 150';
      }
    });
  }

  final TextEditingController _valueEnteredController = TextEditingController();
  final TextEditingController _dateEditingController = TextEditingController();

  void _showAddEntry() async {

    return showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 30,
                right: 30,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  const Text('Type of Entry', style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(height: 6.0),
                  DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), //border of dropdown button/border raiuds of dropdown button
                      ),
                      child:Padding(
                          padding: const EdgeInsets.only(left:10, right:10),
                          child:DropdownButton(
                            value: dropdownValue,
                            items: const [ //add items in the dropdown
                              DropdownMenuItem(
                                child: Text("Weight"),
                                value: "Weight",
                              ),
                              DropdownMenuItem(
                                  child: Text("Calories"),
                                  value: "Calories"
                              ),
                              DropdownMenuItem(
                                child: Text("Strength Record"),
                                value: "Strength Record",
                              )
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                              changeHelperText();
                            },
                            icon: const Padding( //Icon at tail, arrow bottom is default icon
                                padding: EdgeInsets.only(left:20),
                                child:Icon(Icons.arrow_circle_down_sharp)
                            ),
                            iconEnabledColor: Colors.black, //Icon color
                            style: const TextStyle(  //te
                                color: Colors.black, //Font color
                                fontSize: 20,
                                fontWeight: FontWeight.bold, //font size on dropdown button
                            ), //dropdown background color
                            underline: Container(), //remove underline
                            isExpanded: true, //make true to make width 100%
                          )
                      )
                  ),
                  dropdownValue == 'Strength Record' ? const SizedBox(height: 20.0): const SizedBox.shrink(),
                  dropdownValue == 'Strength Record' ?
                  const Text('Exercise', style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )) : const SizedBox.shrink(),
                  dropdownValue == 'Strength Record' ? const SizedBox(height: 6.0) : const SizedBox.shrink(),
                  dropdownValue == 'Strength Record' ? DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey), //border of dropdown button/border raiuds of dropdown button
                      ),
                      child:Padding(
                          padding: const EdgeInsets.only(left:10, right:10),
                          child:DropdownButton(
                            value: strengthRecord,
                            items: const [ //add items in the dropdown
                              DropdownMenuItem(
                                child: Text("Deadlift"),
                                value: "Deadlift",
                              ),
                              DropdownMenuItem(
                                  child: Text("Squat"),
                                  value: "Squat"
                              ),
                              DropdownMenuItem(
                                child: Text("Bench Press"),
                                value: "Bench Press",
                              ),
                              DropdownMenuItem(
                                child: Text("Overhead Press"),
                                value: "Overhead Press",
                              )
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                strengthRecord = newValue!;
                              });
                              changeHelperText();
                            },
                            icon: const Padding( //Icon at tail, arrow bottom is default icon
                                padding: EdgeInsets.only(left:20),
                                child:Icon(Icons.arrow_circle_down_sharp)
                            ),
                            iconEnabledColor: Colors.black, //Icon color
                            style: const TextStyle(  //te
                              color: Colors.black, //Font color
                              fontSize: 20,
                              fontWeight: FontWeight.bold, //font size on dropdown button
                            ), //dropdown background color
                            underline: Container(), //remove underline
                            isExpanded: true, //make true to make width 100%
                          )
                      )
                  ) : const SizedBox.shrink(),
                  const SizedBox(height: 20.0),
                  const Text('Date', style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(height: 6.0),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      side: BorderSide(width: 1, color: Colors.grey),
                      elevation: 0,
                      fixedSize: Size(1000, 50),
                    ),
                    onPressed: () async {
                      await _selectDate(context);
                      setState(() {
                        selectedDate = selectedDate;
                      });
                    },
                    child: Text(
                        '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  Text(helperText, style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
                  const SizedBox(height: 6.0),
                  TextField(
                      controller: _valueEnteredController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),
                          hintText: helperTextPlaceholder)
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      onPressed: () async {
                        // Save new journal
                        await _addItem();
                        // Clear the text fields
                        _valueEnteredController.text = '';
                        // Close the bottom sheet
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.yellow[700],
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50))),
                          fixedSize: Size(1000, 50),
                      ),
                      icon: Icon(Icons.add),
                      label: Text('Add Entry', style: TextStyle(
                        fontSize: 24,
                          fontWeight: FontWeight.w700
                      ),))
                ],
              ),
            );
          }
        ));
  }

  Future<void> _addItem() async {
      setState(() {
        _isLoading = true;
      });
    print(dropdownValue);

    if (dropdownValue == 'Weight') {
      await SQLiteDB.createNewWeightEntry(
          1, _valueEnteredController.text, selectedDate
      );
    } else if (dropdownValue == 'Calories'){
      await SQLiteDB.createNewCalorieEntry(
          1, _valueEnteredController.text, selectedDate
      );
    }
     _refreshData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: _isLoading ? const Center(
          child: SpinKitFoldingCube(
            color: Colors.black,
            size: 50.0,
          ),
        )
            : widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showAddEntry();},
        backgroundColor: Colors.yellow[700],
        child: const Icon(Icons.add, color: Colors.black)
      ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem> [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home, color: Colors.black),
                backgroundColor: Colors.yellow[700],
                label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.monitor_weight_outlined, color: Colors.black),
                backgroundColor: Colors.yellow[700],
                label: 'Weight'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.stacked_line_chart, color: Colors.black),
                backgroundColor: Colors.yellow[700],
                label: 'Strength Records'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.fastfood, color: Colors.black),
                backgroundColor: Colors.yellow[700],
                label: 'Calories'),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings, color: Colors.black),
                backgroundColor: Colors.yellow[700],
                label: 'Settings')
          ],

          backgroundColor: Colors.yellow[800],
          selectedItemColor: Colors.black,

          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )
    );
  }
}

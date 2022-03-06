import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:track_it/db_functions/db_functions.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  Map userData = {};

  bool targetsEnabled = false;
  String weightPreference = '';

  void _refreshData() async {
    final data = await SQLiteDB.getUserData();
    print(data);
    setState(() {
      userData = data[0];

      if (userData['targets_enabled'] == 0){
        targetsEnabled = false;
      }else{
        targetsEnabled = true;
      }

      if (userData['weight_preference'] == 'KG') {
        weightPreference = 'KG';
      }else {
        weightPreference = 'LBS';
      }

    });
  }

  @override
  void initState()  {
    super.initState();
    // final data = ModalRoute.of(context)!.settings.arguments as List<Map>;
    _refreshData();
  }

  void enableOrDisableTargets(newBoolValue) async {
    if (newBoolValue == false) {
      await SQLiteDB.updateTargetsOption(0);
    }else {
      print(newBoolValue);
      await SQLiteDB.updateTargetsOption(1);
    }
  }

  void changeWeightPreference() async {
    if (weightPreference == 'KG') {
      await SQLiteDB.updateWeightPreference('LBS');
      setState(() {
        weightPreference = 'LBS';
      });
    }else {
      await SQLiteDB.updateWeightPreference('KG');
      setState(() {
        weightPreference = 'KG';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('General'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.settings),
              title: Text('Weight Preference'),
              value: Text(weightPreference),
              onPressed: (value){
                changeWeightPreference();
              }
            ),
            SettingsTile.switchTile(
              onToggle: (value) {
                setState(() {
                  enableOrDisableTargets(value);
                  targetsEnabled = value;
                });
              },
              initialValue: targetsEnabled,
              leading: Icon(Icons.trending_up_rounded),
              title: Text('Enable Targets'),
            ),
          ],
        ),
        SettingsSection(
          title: Text('Targets'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Language'),
              value: Text('English'),
            ),
            SettingsTile.switchTile(
              onToggle: (value) {
                setState(() {
                  targetsEnabled = value;
                });
              },
              initialValue: targetsEnabled,
              leading: Icon(Icons.trending_up_rounded),
              title: Text('Enable Targets'),
            ),
          ],
        ) ,
      ],
    );
  }
}




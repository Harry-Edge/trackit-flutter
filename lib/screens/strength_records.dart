import 'package:flutter/material.dart';

class StrengthRecordsScreen extends StatefulWidget {
  const StrengthRecordsScreen({Key? key}) : super(key: key);

  @override
  _StrengthRecordsScreenState createState() => _StrengthRecordsScreenState();
}

class _StrengthRecordsScreenState extends State<StrengthRecordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Strength Records')
      ),
    );
  }
}

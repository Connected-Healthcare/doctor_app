import 'package:doctor_app/individual/screen/chart.dart';
import 'package:flutter/material.dart';

class IndividualScreen extends StatelessWidget {
  final String individual;
  IndividualScreen(this.individual);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$individual"),
      ),
      body: IndividualChartScreen(this.individual),
    );
  }
}

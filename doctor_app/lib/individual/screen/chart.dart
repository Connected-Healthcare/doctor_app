import 'dart:async';

import 'package:doctor_app/individual/state/schema.dart';
import 'package:doctor_app/individual/widget/accelerometer.dart';
import 'package:doctor_app/individual/widget/heartbeat.dart';
import 'package:doctor_app/individual/widget/oxygen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class IndividualChartScreen extends StatefulWidget {
  final String user;
  IndividualChartScreen(this.user);

  @override
  _IndividualChartScreenState createState() => _IndividualChartScreenState();
}

class _IndividualChartScreenState extends State<IndividualChartScreen> {
  static const int MaxRead = 20;

  // States
  List<CloudSchema> _cloudSchema = List<CloudSchema>.empty(growable: true);
  StreamSubscription _stream;
  int _currentMaxEpochTime = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.local_hospital),
          title: Text("Heartbeat Graph"),
        ),
        HeartbeatGraph(this._cloudSchema, this._currentMaxEpochTime),

        ListTile(
          leading: Icon(Icons.local_hospital),
          title: Text("Oxygen Graph"),
        ),
        OxygenGraph(this._cloudSchema, this._currentMaxEpochTime),

        ListTile(
          leading: Icon(Icons.local_hospital),
          title: Text("Accelerometer Graph"),
        ),
        AccelerometerGraph(this._cloudSchema, this._currentMaxEpochTime),

        // END
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    // Stream for User
    _stream = FirebaseDatabase.instance
        .reference()
        .child(this.widget.user)
        .limitToLast(MaxRead)
        .onValue
        .listen((event) {
      _cloudSchema.clear();
      DataSnapshot snap = event.snapshot;
      Map<String, dynamic> m = Map.castFrom(snap.value);
      Map<String, Map<dynamic, dynamic>> m2 = Map.castFrom(m);
      var cloudData = m2.values.toList();
      for (var d in cloudData) {
        CloudSchema schema = CloudSchema(d);
        if (!schema.parse()) {
          continue;
        }
        _currentMaxEpochTime = _currentMaxEpochTime > schema.epochTime
            ? _currentMaxEpochTime
            : schema.epochTime;
        _cloudSchema.add(schema);
      }

      setState(() {});
    }, cancelOnError: true);
  }

  @override
  void dispose() {
    _stream?.cancel();
    super.dispose();
  }
}

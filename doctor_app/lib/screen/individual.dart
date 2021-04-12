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
      body: IndividualBody(),
    );
  }
}

// TODO, Subscribe to firebase and render charts here
class IndividualBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

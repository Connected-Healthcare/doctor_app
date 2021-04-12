import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SettingsBody(),
    );
  }
}

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Add User card
        Card(
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text("Add User"),
          ),
        ),

        Card(
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Text("Stored Users"),
            children: [
              ListTile(
                leading: Icon(Icons.supervised_user_circle),
                title: Text("RLOC5000"),
              )
            ],
          ),
        )

        // END
      ],
    );
  }
}

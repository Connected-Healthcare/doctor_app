import 'package:doctor_app/screen/settings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => _onPressedSettings(context),
          )
        ],
      ),
    );
  }

  void _onPressedSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SettingsScreen();
        },
      ),
    );
  }
}

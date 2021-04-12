import 'package:doctor_app/screen/individual.dart';
import 'package:doctor_app/screen/settings.dart';
import 'package:doctor_app/storage/shared_prefs_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: HomeBody(),
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

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPrefsModel>(
      builder: (context, model, _) {
        List<String> users = model.users;
        if (users.isEmpty) {
          return ListTile(
            title: Text("Please add users in Settings"),
          );
        }

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text("${users[index]}"),
                onTap: () => _onUserPress(context, users[index]),
              ),
            );
          },
        );
      },
    );
  }

  void _onUserPress(BuildContext context, String user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return IndividualScreen(user);
        },
      ),
    );
  }
}

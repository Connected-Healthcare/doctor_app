import 'package:doctor_app/screen/client_alert.dart';
import 'package:doctor_app/screen/individual.dart';
import 'package:doctor_app/screen/settings.dart';
import 'package:doctor_app/storage/shared_prefs_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _screens = [
    HomeBody(),
    ClientAlertScreen(),
  ];

  final List<Widget> _tabs = [
    Tab(icon: Icon(Icons.supervised_user_circle_sharp)),
    Tab(icon: Icon(Icons.add_alert_sharp)),
  ];

  // State
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    assert(_screens.length == _tabs.length);
    return DefaultTabController(
      length: _screens.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
          bottom: TabBar(
            onTap: (int index) {
              _index = index;
              setState(() {});
            },
            tabs: _tabs,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _onPressedSettings(context),
            )
          ],
        ),
        body: IndexedStack(
          index: _index,
          children: _screens,
        ),
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

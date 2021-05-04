import 'package:doctor_app/storage/shared_prefs_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientAlertScreen extends StatefulWidget {
  @override
  _ClientAlertScreenState createState() => _ClientAlertScreenState();
}

class _ClientAlertScreenState extends State<ClientAlertScreen> {
  static const String AlertTopic = "alerts";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Event>(
      stream: FirebaseDatabase.instance.reference().child(AlertTopic).onValue,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        }

        var filteredData = _processAlertSnapshot(snapshot.data);
        if (filteredData.isEmpty) {
          return Card(
            child: ListTile(
              leading: Icon(
                Icons.admin_panel_settings_rounded,
                color: Colors.green,
              ),
              title: Text("No Alerts"),
            ),
          );
        }

        return ListView(
          children: [
            for (var k in filteredData.keys)
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.add_alert_rounded,
                    color: Colors.red,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _onDeleteAlert(k),
                  ),
                  title: Text(
                      "Received alert from $k at ${DateTime.fromMillisecondsSinceEpoch(filteredData[k])}"),
                ),
              ),
          ],
        );

        // END
      },
    );
  }

  @override
  void initState() {
    FirebaseDatabase.instance.reference().child(AlertTopic);
    super.initState();
  }

  Map<String, dynamic> _processAlertSnapshot(Event event) {
    List<String> users =
        Provider.of<SharedPrefsModel>(context, listen: false).users;

    Map<String, dynamic> m = Map.castFrom(event.snapshot.value);
    Map<String, dynamic> filteredData = Map<String, dynamic>();
    for (String u in users) {
      bool contains = m.containsKey(u);
      if (!contains) {
        continue;
      }
      filteredData[u] = m[u];
    }

    return filteredData;
  }

  void _onDeleteAlert(String user) async {
    await FirebaseDatabase.instance
        .reference()
        .child(AlertTopic)
        .child(user)
        .set(null);
  }
}

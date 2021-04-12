import 'package:doctor_app/storage/shared_prefs_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUser extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.add),
        title: Text("Add User"),
        onTap: () => _onAddUser(context),
      ),
    );
  }

  Future<void> _onAddUser(
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add new user"),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter user name here",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _onCancel(context),
            child: Text("Done"),
          ),

          ElevatedButton(
            onPressed: () => _onAdd(context),
            child: Text("Add"),
          ),

          // END
        ],
      ),
    );
  }

  void _onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> _onAdd(BuildContext context) async {
    String username = _controller.text;
    if (username.isEmpty) {
      return;
    }

    SharedPrefsModel prefsModel =
        Provider.of<SharedPrefsModel>(context, listen: false);
    bool added = await prefsModel.addUser(username);
    print("Added : $added");

    _controller.clear();
  }
}

class ListUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SharedPrefsModel>(
      builder: (context, model, _) {
        print("${model.users}");
        return Card(
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Text("Stored Users"),
            children: _subscribedUsers(model.users),
          ),
        );
      },
    );
  }

  List<Widget> _subscribedUsers(List<String> users) {
    if (users.isEmpty) {
      return List<Widget>.empty();
    }

    List<Widget> subscribedUser = List<Widget>.empty(growable: true);
    for (var user in users) {
      subscribedUser.add(UserTile(user));
    }
    return subscribedUser;
  }
}

class UserTile extends StatelessWidget {
  final String user;
  UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.supervised_user_circle),
      title: Text("$user"),
      trailing: IconButton(
        icon: Icon(Icons.remove),
        onPressed: () => _onRemovePressed(context),
      ),
    );
  }

  void _onRemovePressed(BuildContext context) {
    SharedPrefsModel prefsModel =
        Provider.of<SharedPrefsModel>(context, listen: false);
    prefsModel.removeUser(user);
  }
}

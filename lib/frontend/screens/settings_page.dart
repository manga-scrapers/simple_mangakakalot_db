import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              //todo: create backup option
            },
            title: AutoSizeText("Backup"),
            leading: Icon(Icons.backup),
          ),
          ListTile(
            onTap: () {
              //todo: create restores option
            },
            title: AutoSizeText("Restore"),
            leading: Icon(Icons.restore),
          )
        ],
      ),
    );
  }
}

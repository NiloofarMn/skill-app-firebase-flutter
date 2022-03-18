import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/pages/editpage/edit_data.dart';
import 'package:firebase_test/pages/home/widgets/data_list.dart';
import 'package:firebase_test/model/skill_model.dart';
import 'package:firebase_test/shared/export_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    void _editData() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) => EditData(
          user: user,
        ),
      );
    }

    return StreamProvider<List<Skill>>.value(
      value: DatabaseService().skills,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Skill App',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Configs.mainColor),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () => AuthService().signOut(),
                child: Text(
                  'Sign out',
                  style: TextStyle(color: Configs.compColors1),
                )),
          ],
        ),
        body: const DataList(),
        floatingActionButton:
            Provider.of<User>(context, listen: false).isAnonymous
                ? null
                : FloatingActionButton.extended(
                    onPressed: _editData,
                    label: const Text('EditData'),
                    backgroundColor: Configs.mainColor,
                  ),
      ),
    );
  }
}

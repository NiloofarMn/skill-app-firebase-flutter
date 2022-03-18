import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/pages/editpage/edit_data.dart';
import 'package:firebase_test/model/skill_model.dart';
import 'package:firebase_test/pages/home/widgets/costum_listtile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataList extends StatelessWidget {
  const DataList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skills = Provider.of<List<Skill>>(context);
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

    return ListView.builder(
        itemCount: skills.length,
        itemBuilder: (context, index) {
          Skill item = skills[index];
          return GestureDetector(
            onTap: user.uid == item.uid ? _editData : null,
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: CostumListTile(
                name: item.name,
                skills: item.skills,
                owned: user.uid == item.uid,
              ),
            ),
          );
        });
  }
}

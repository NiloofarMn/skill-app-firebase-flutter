import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/model/skill_model.dart';
import 'package:firebase_test/shared/configs.dart';
import 'package:firebase_test/shared/database_service.dart';
import 'package:flutter/material.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({
    Key? key,
    required this.skill,
    required this.user,
  }) : super(key: key);
  final Skill skill;
  final User user;

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  bool isLoadingAddButton = false;
  late DatabaseService _db;

  @override
  void initState() {
    _db = DatabaseService(user: widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text('Skills:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Row(
        children: [
          buildAddButton(context),
          isLoadingAddButton
              ? CircularProgressIndicator(
                  backgroundColor: Configs.mainColor,
                  color: Configs.compColors1,
                )
              : const SizedBox(
                  width: 2,
                ),
        ],
      ),
    ]);
  }

  TextButton buildAddButton(BuildContext context) {
    return TextButton(
        onPressed: handleOnPressAddButton,
        child: Text(
          'Add Skill',
          style: TextStyle(color: Configs.compColors1, fontSize: 18),
        ));
  }

  handleOnPressAddButton() async {
    if (widget.skill.skills.length > 3) {
      showAlertDialog(context);
      return;
    }
    setState(() {
      widget.skill.skills
          .add({'name': 'skill ${widget.skill.skills.length}', 'level': 50.0});
      isLoadingAddButton = true;
    });
    await _db.updateUserData(
        widget.skill.isAnon, widget.skill.name, widget.skill.skills);
    setState(() => isLoadingAddButton = false);
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: Configs.compColors1),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          Icon(
            Icons.warning,
            size: 40,
            color: Configs.compColors2,
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: const Text(
              "Number of skills are limited! \nMax=4",
            ),
          ),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/shared/configs.dart';
import 'package:firebase_test/shared/database_service.dart';
import 'package:firebase_test/model/skill_model.dart';
import 'package:flutter/material.dart';

class EditNameBar extends StatefulWidget {
  const EditNameBar({
    Key? key,
    required this.skill,
    required this.user,
    required this.formKey,
  }) : super(key: key);
  final Skill skill;
  final User user;
  final GlobalKey<FormState> formKey;

  @override
  _EditNameBarState createState() => _EditNameBarState();
}

class _EditNameBarState extends State<EditNameBar> {
  bool nameisLoading = false;
  double _padding = 0;
  bool nameTaped = false;

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(user: widget.user);
    if (nameTaped && MediaQuery.of(context).viewInsets.bottom != 0) {
      _padding = widget.skill.skills.length < 2 ? 200 : 30;
    } else {
      _padding = 0;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: _padding),
      child: TextFormField(
        initialValue: widget.skill.name,
        maxLength: 10,
        decoration: Configs.fieldDecoration.copyWith(
          label: const Text('Name'),
          suffixIcon: nameisLoading
              ? CircularProgressIndicator(
                  backgroundColor: Configs.mainColor,
                  color: Configs.compColors1,
                )
              : null,
        ),
        onTap: () {
          setState(() {
            nameTaped = true;
          });
        },
        onFieldSubmitted: (value) async {
          nameTaped = false;
          setState(() => nameisLoading = true);
          if (widget.formKey.currentState!.validate()) {
            await _db.updateUserData(
                widget.skill.isAnon, value, widget.skill.skills);
          }
          setState(() => nameisLoading = false);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Don't leave the name Field Empty";
          }
        },
      ),
    );
  }
}

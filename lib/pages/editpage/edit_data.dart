import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/pages/editpage/widgets/widgets.dart';
import 'package:firebase_test/shared/database_service.dart';
import 'package:firebase_test/pages/laoding.dart';
import 'package:firebase_test/model/skill_model.dart';
import 'package:flutter/material.dart';

class EditData extends StatefulWidget {
  const EditData({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final _formKey = GlobalKey<FormState>();
  late Skill _skill;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Skill>(
        stream: DatabaseService(user: widget.user).skillData,
        builder: (context, snapshot) {
          if (snapshot.hasData) _skill = snapshot.data as Skill;
          return snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      controller: _scrollController,
                      children: [
                        EditNameBar(
                          skill: _skill,
                          user: widget.user,
                          formKey: _formKey,
                        ),
                        const SizedBox(height: 10),
                        AddSkill(
                          skill: _skill,
                          user: widget.user,
                        ),
                        const SizedBox(height: 5),
                        _skill.skills.isNotEmpty
                            ? EditSkillSliders(
                                skill: _skill,
                                user: widget.user,
                                formKey: _formKey,
                                scrollDown: scrollDown,
                              )
                            : const SizedBox(
                                height: 10,
                              ),
                      ],
                    ),
                  ),
                )
              : const Loading();
        });
  }

  Future<void> scrollDown(double padding) async {
    Timer(const Duration(milliseconds: 500), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/shared/configs.dart';
import 'package:firebase_test/shared/database_service.dart';
import 'package:firebase_test/model/skill_model.dart';
import 'package:flutter/material.dart';

class EditSkillSliders extends StatefulWidget {
  const EditSkillSliders({
    Key? key,
    required this.skill,
    required this.user,
    required this.formKey,
    required this.scrollDown,
  }) : super(key: key);
  final Skill skill;
  final User user;
  final GlobalKey<FormState> formKey;
  final Function(double padding) scrollDown;

  @override
  _EditSkillSlidersState createState() => _EditSkillSlidersState();
}

class _EditSkillSlidersState extends State<EditSkillSliders> {
  bool changeHasStarted = false;
  final List<double> _currentSliderValue = [50, 50, 50, 50];
  List<bool> isLoading = [false, false, false, false];
  List<bool> isPaddingNeeded = [false, false, false, false];
  double _padding = 0;
  late DatabaseService _db;
  @override
  void initState() {
    _db = DatabaseService(user: widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: List.generate(widget.skill.skills.length, (index) {
            if (!changeHasStarted) {
              _currentSliderValue[index] = widget.skill.skills[index]['level'];
            }
            return Padding(
              padding: EdgeInsets.only(
                  bottom: isPaddingNeeded[index] ? _padding : 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: deleteButton(index),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    flex: 3,
                    child: nameOfSkill(index),
                  ),
                  Expanded(flex: 5, child: slider(index)),
                  isLoading[index]
                      ? Expanded(
                          flex: 1,
                          child: CircularProgressIndicator(
                            backgroundColor: Configs.mainColor,
                            color: Configs.compColors1,
                          ),
                        )
                      : const SizedBox(
                          height: 2,
                        ),
                ],
              ),
            );
          }).toList(),
        ));
  }

  TextButton deleteButton(int index) {
    return TextButton(
      onPressed: () async {
        widget.skill.skills.removeAt(index);
        setState(() => isLoading[index] = true);
        await _db.updateUserData(
            widget.skill.isAnon, widget.skill.name, widget.skill.skills);
        if (widget.skill.skills.isEmpty) {
          // to prevent getting errors
          isLoading[index] = false;
          return;
        }
        setState(() => isLoading[index] = false);
      },
      child: Icon(
        Icons.delete,
        color: Configs.compColors2,
      ),
    );
  }

  TextFormField nameOfSkill(int index) {
    return TextFormField(
        initialValue: widget.skill.skills[index]['name'],
        textAlign: TextAlign.center,
        maxLength: 10,
        decoration: Configs.skillfieldDecoration.copyWith(
          label: const Text('Skill'),
        ),
        onTap: () {
          isPaddingNeeded = [false, false, false, false];
          isPaddingNeeded[index] = true;
          _padding = index * 90 + (450 - (widget.skill.skills.length * 100));
          setState(() {});
          widget.scrollDown(_padding);
        },
        onFieldSubmitted: (value) async {
          isPaddingNeeded[index] = false;
          _padding = 0;
          setState(() => isLoading[index] = true);
          if (widget.formKey.currentState!.validate()) {
            widget.skill.skills[index]['name'] = value;
            await _db.updateUserData(
                widget.skill.isAnon, widget.skill.name, widget.skill.skills);
          }
          setState(() => isLoading[index] = false);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "required!";
          }
        });
  }

  SliderTheme slider(int index) {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: Configs.colors[(_currentSliderValue[index] / 10).round()],
        activeTickMarkColor:
            Configs.colors[(_currentSliderValue[index] / 10).round()],
        activeTrackColor:
            Configs.colors[(_currentSliderValue[index] / 10).round()],
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
      ),
      child: Slider(
          value: _currentSliderValue[index],
          max: 100,
          divisions: 10,
          label: '${_currentSliderValue[index].round().toString()}%',
          onChangeStart: (value) => changeHasStarted = true,
          onChanged: (value) {
            setState(() {
              _currentSliderValue[index] = value;
            });
          },
          onChangeEnd: (value) async {
            changeHasStarted = false;
            widget.skill.skills[index]['level'] = value;
            setState(() => isLoading[index] = true);
            await _db.updateUserData(
                widget.skill.isAnon, widget.skill.name, widget.skill.skills);
            setState(() => isLoading[index] = false);
          }),
    );
  }
}

import 'package:firebase_test/shared/configs.dart';
import 'package:flutter/material.dart';

class CostumListTile extends StatelessWidget {
  const CostumListTile(
      {Key? key, required this.skills, required this.name, required this.owned})
      : super(key: key);

  final List skills;
  final String name;
  final bool owned;

  @override
  Widget build(BuildContext context) {
    double skillScore = 0;
    for (var item in skills) {
      skillScore += item['level'];
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildName(skillScore),
          const SizedBox(
            height: 30,
          ),
          skills.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: generateSkillSliders(),
                )
              : const SizedBox(
                  height: 40,
                  child: Center(child: Text('There is no information yet!')),
                ),
        ],
      ),
    );
  }

  Row buildName(double skillScore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              const TextSpan(
                  text: ' has score of',
                  style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(
                  text: skills.isEmpty
                      ? ' 0% '
                      : ' ${(skillScore / skills.length).round()}% ',
                  style: TextStyle(
                      color: skills.isEmpty
                          ? Configs.compColors2
                          : Configs.colors[
                              (skillScore / (skills.length * 10)).round()])),
            ],
          ),
        ),
        owned
            ? Icon(
                Icons.star,
                size: 20,
                color: Configs.compColors2,
              )
            : const SizedBox(
                width: 10,
              ),
      ],
    );
  }

  Column generateSkillSliders() {
    return Column(
      children: List.generate(
        skills.length,
        (index) {
          double _currentSliderValue = skills[index]['level'];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: buildSkillName(index),
              ),
              Expanded(
                flex: 3,
                child: buildSkillSlider(_currentSliderValue),
              ),
            ],
          );
        },
      ),
    );
  }

  Text buildSkillName(int index) {
    return Text(
      skills[index]['name'],
      style: const TextStyle(fontSize: 16),
    );
  }

  SliderTheme buildSkillSlider(double _currentSliderValue) {
    return SliderTheme(
      data: SliderThemeData(
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 1),
        disabledActiveTrackColor:
            Configs.colors[(_currentSliderValue / 10).round()],
        disabledThumbColor: Configs.colors[(_currentSliderValue / 10).round()],
      ),
      child: Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 10,
        label: _currentSliderValue.round().toString(),
        inactiveColor: Configs.colors[(_currentSliderValue / 10).round()],
        onChanged: null,
      ),
    );
  }
}

import 'package:firebase_test/shared/configs.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = ColorTween(begin: Configs.compColors1, end: Configs.compColors2)
        .animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Configs.mainColor,
              valueColor: animation,
            ),
            const Text('Loadidng...'),
          ],
        ),
      ),
    );
  }
}

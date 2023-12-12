import 'dart:async';
import 'package:flutter/material.dart';

class QuizTimerWidget extends StatefulWidget {
  final Function()? onRadioButtonSelected;

  const QuizTimerWidget({
    Key? key,
    this.onRadioButtonSelected,
  }) : super(key: key);

  @override
  State<QuizTimerWidget> createState() => _QuizTimerWidgetState();
}

class _QuizTimerWidgetState extends State<QuizTimerWidget> {
  int seconds = 60;
  Timer? timer;
  bool isPaused = false;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0 && !isPaused) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  stopTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      widget.onRadioButtonSelected?.call();
    }
  }

  togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Text(
              "$seconds",
              style: const TextStyle(fontSize: 24, color: Colors.blueAccent),
            ),
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: seconds / 60,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
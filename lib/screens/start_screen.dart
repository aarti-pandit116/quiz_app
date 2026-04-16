import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key, required this.onSwitchScreen});

  final VoidCallback onSwitchScreen;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: .center,
        spacing: 20,
        children: [
          Image.asset(
            'assets/quiz_logo.jpg',
            fit: BoxFit.scaleDown,
            width: 280,
          ),
          const Text(
            'Learn Flutter the fun way!',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          ElevatedButton(
            onPressed: widget.onSwitchScreen,
            child: Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}

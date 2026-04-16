import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screens/question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final List<String> chosenAnswers;
  final void Function() onRestart;
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].questionText,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final int numberOfTotalQuestions = questions.length;
    final int numberOfCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: .all(40),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SizedBox(height: 50),
            Text(
              "You answered $numberOfCorrectQuestions out of $numberOfTotalQuestions correctly",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1A237E), // Indigo 900,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "List of questions...",
              style: TextStyle(
                color: Color(0xFF1A237E).withOpacity(0.8), // Indigo 900,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: QuestionSummary(summaryData: summaryData)),
            SizedBox(height: 20),
            TextButton(
              onPressed: onRestart,
              child: const Text("Restart Quiz !"),
            ),
          ],
        ),
      ),
    );
  }
}

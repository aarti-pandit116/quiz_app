import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: summaryData.map((data) {
          final isCorrectAnswer = data['user_answer'] == data['correct_answer'];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: isCorrectAnswer
                      ? Color(0xFF00695C) // Teal 800
                      : Color(0xFF1A237E),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      ((data['question_index'] as int) + 1).toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        data['question'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Your Answer: ${data['user_answer'] as String}",
                        style: TextStyle(
                          color: Color(0xFF1A237E), // Indigo 900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Correct Answer: ${data['correct_answer'] as String}",
                        style: const TextStyle(
                          color: Color(0xFF00695C), // Teal 800
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

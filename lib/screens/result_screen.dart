import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screens/question_summary.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final List<String> chosenAnswers;
  final void Function() onRestart;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  InterstitialAd? _interstitialAd;
  bool _showAnswers = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    InterstitialAd.load(
      adUnitId: getInterstitialAdUnitId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _showAnswers = true;
              });
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              setState(() {
                _showAnswers = true;
              });
              ad.dispose();
            },
          );
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  String getInterstitialAdUnitId() {
    if (Platform.isAndroid || Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1033173712';
    }
    throw UnsupportedError('Unsupported platform');
  }

  void _showAnswersAndAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
    } else {
      // If ad failed to load, just show the answers
      setState(() {
        _showAnswers = true;
      });
    }
  }

  void _showAdPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF512F),
                  Color(0xFFDD2476),
                ], // Bright creative gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 60,
                ),
                const SizedBox(height: 15),
                const Text(
                  "Unlock Answers!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Watch a short ad to see all the correct answers and review your performance.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    _showAnswersAndAd();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFFDD2476),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "Watch This Ad",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < widget.chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].questionText,
        'correct_answer': questions[i].answers[0],
        'user_answer': widget.chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
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
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
              "You answered $numberOfCorrectQuestions out of $numberOfTotalQuestions correctly",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF1A237E), // Indigo 900,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "List of questions...",
              style: TextStyle(
                color: const Color(0xFF1A237E).withOpacity(0.8), // Indigo 900,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            if (_showAnswers)
              Expanded(child: QuestionSummary(summaryData: summaryData))
            else
              ElevatedButton.icon(
                onPressed: _showAdPopup,
                icon: const Icon(Icons.lock_open),
                label: const Text('Want to see the Answers'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: widget.onRestart,
              icon: const Icon(Icons.refresh),
              label: const Text("Restart Quiz !"),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> answers;

  Question(this.questionText, this.answers);


  List<String> getShuffledAnswers() {
    final shuffled = List.of(answers);
    shuffled.shuffle();
    return shuffled;
  }
}

# How We Identify the Correct Answer

You might have noticed that we never explicitly define a "correct answer" variable or key in `questions.dart`. So how does the app know which answer is correct?

The secret lies in the **order of the answers** inside `lib/data/questions.dart`!

### The Logic

If you look at the `Question` data in your `questions.dart` file, every single question lists the **correct answer as the very first item (Index 0)** in its `answers` list.

```dart
Question('What are the main building blocks of Flutter UI?', [
  'Widgets',      // <-- INDEX 0: This is always the correct answer!
  'Components',   // Incorrect
  'Blocks',       // Incorrect
  'Functions',    // Incorrect
]),
```

### So how does `ResultScreen` know?

In `lib/screens/result_screen.dart`, when we build the summary data to check if you got it right, we look at the original list of questions. We simply grab the very first answer (`index 0`) from the original list:

```dart
'correct_answer': questions[i].answers[0], // Grabbing the first item!
```

### But wait, aren't the answers shuffled during the quiz?

Yes! If the correct answer is always at the top, the game would be too easy. 

That is why inside `lib/models/question_modal.dart`, we have a method called `getShuffledAnswers()`:

```dart
List<String> getShuffledAnswers() {
  final shuffled = List.of(answers);
  shuffled.shuffle();
  return shuffled;
}
```

When displaying the buttons to the user on the `QuestionScreen`, the app calls `getShuffledAnswers()`. This mixes up the order visually for the player. However, the original `answers` list inside `questions.dart` **never changes**.

Because the original list is never permanently altered, `answers[0]` will reliably always point to the actual correct answer!

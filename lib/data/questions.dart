import 'package:quiz_app/models/question_modal.dart';

List<Question> questions = [
  Question('What are the main building blocks of Flutter UI?', [
    'Widgets',
    'Components',
    'Blocks',
    'Functions',
  ]),
  Question('Which language is used to develop Flutter apps?', [
    'Java',
    'Kotlin',
    'Dart',
    'Swift',
  ]),
  Question('Which widget is used for immutable layouts?', [
    'StatelessWidget',
    'StatefulWidget',
    'InheritedWidget',
    'Container',
  ]),
  Question('Which widget allows dynamic updates in Flutter?', [
    'StatelessWidget',
    'StatefulWidget',
    'Container',
    'Scaffold',
  ]),
  Question('What is the root widget of a Flutter app?', [
    'MaterialApp',
    'Scaffold',
    'Container',
    'AppBar',
  ]),
  Question('Which widget is used to create a basic app layout structure?', [
    'Container',
    'Column',
    'Scaffold',
    'Stack',
  ]),
  Question('Which widget is used to arrange children vertically?', [
    'Row',
    'Column',
    'Stack',
    'ListView',
  ]),
  Question('Which widget is used to arrange children horizontally?', [
    'Column',
    'Row',
    'Stack',
    'GridView',
  ]),
  Question('Which widget is scrollable by default?', [
    'Column',
    'Row',
    'ListView',
    'Container',
  ]),
  Question('What is used to manage state across the app efficiently?', [
    'setState',
    'Provider',
    'Navigator',
    'Builder',
  ]),
  Question('Which function is the entry point of a Flutter app?', [
    'start()',
    'runApp()',
    'main()',
    'init()',
  ]),
  Question('Which widget is used for navigation between screens?', [
    'Navigator',
    'Route',
    'MaterialPageRoute',
    'All of the above',
  ]),
];

// Answer Key (index-based)
List<int> answers = [
  0, // Widgets
  2, // Dart
  0, // StatelessWidget
  1, // StatefulWidget
  0, // MaterialApp
  2, // Scaffold
  1, // Column
  1, // Row
  2, // ListView
  1, // Provider
  2, // main()
  3, // All of the above
];

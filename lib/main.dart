import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/presentation/pages/number_trivial_page.dart';
import 'package:flutter_clean_architecture_tdd/injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600
      ),
      home: const NumberTriviaPage(),
    );
  }
}

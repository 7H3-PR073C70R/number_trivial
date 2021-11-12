import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';

class TrivialDisplay extends StatelessWidget {
  final NumberTrivia trivia;
  const TrivialDisplay({Key? key, required this.trivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${trivia.number}',
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        Text(
          trivia.text,
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

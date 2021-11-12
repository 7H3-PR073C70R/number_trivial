import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivial_bloc.dart';

class TrivialControl extends StatefulWidget {
  const TrivialControl({Key? key}) : super(key: key);

  @override
  _TrivialControlState createState() => _TrivialControlState();
}

class _TrivialControlState extends State<TrivialControl> {
  late String inputStr;
  final controller =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
            keyboardType: TextInputType.number,
            controller: controller,
            onChanged: (value) {
              inputStr = value;
            },
            onSubmitted: (_) {
              dispatchConcret();
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            )),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: dispatchConcret,
              child: const Text('Search'),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: ElevatedButton(
              onPressed: dispatchRandom,
              child: const Text('Get random trivia'),
            )),
          ],
        )
      ],
    );
  }

  void dispatchConcret() {
    controller.clear();
    BlocProvider.of<NumberTrivialBloc>(context).add(GetTriviaForConcreteNumber(inputStr));
  }

  void dispatchRandom() {
    BlocProvider.of<NumberTrivialBloc>(context).add(GetTriviaForRandomNumber());

  }
}